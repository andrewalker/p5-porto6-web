package Porto6::UpdateStatus;
use Moose;
use utf8;
use Business::CPI;
use Porto6::Config;
use Porto6::Schema;
use Try::Tiny;

has db => (
    is => 'ro',
    lazy => 1,
    default => sub {
        my $self = shift;
        return Porto6::Schema->connect(
            $self->config->{model}{DB}{connect_info}{dsn}
        );
    },
);

has config => (
    is      => 'ro',
    lazy    => 1,
    default => sub { get_config() },
);

has rs => (
    is      => 'ro',
    lazy    => 1,
    default => sub { shift->db->resultset('Sale') },
);

has gateways => (
    is      => 'ro',
    lazy    => 1,
    default => sub { shift->config->{model}{CPI}{gateway} },
);

has _cpi => (
    is => 'ro',
    default => sub { +{} },
);

sub cpi {
    my ($self, $gt) = @_;

    my $cache = $self->_cpi;

    return $cache->{$gt} if exists $cache->{$gt};

    my $cpi = Business::CPI->new(
        gateway => $gt,
        %{ $self->gateways->{$gt} },
    );

    return $cache->{$gt} = $cpi;
}

sub get_payments_without_id {
    my ($self) = @_;

    my @gateways = keys %{ $self->gateways };
    my %gateways;

    for my $gateway (@gateways) {
        my $result = $self->rs->search({
            gateway_id => undef,
            gateway => $gateway
        }, {
            order_by => 'created_at'
        });

        if (my $row = $result->first) {
            $gateways{$gateway} = $row->created_at;
        }
    }

    return \%gateways;
}

sub update_payments_without_id {
    my ($self) = @_;

    my %seen;
    my $payments_without_id = $self->get_payments_without_id;
    my $rs = $self->rs;

    for my $gt (keys %{ $self->gateways }) {
        my $start_date = $payments_without_id->{$gt};
        next unless $start_date;

        try {
            my $cpi = $self->cpi($gt);

            # subtract one day, to be safe
            my $query = $cpi->query_transactions({ initial_date => $start_date->subtract(days => 1) });

            for my $t (@{ $query->{transactions} }) {
                my $id  = $t->{payment_id};
                my $row = $rs->find($id);
                $seen{$id} = 1;

                $self->update_sale($row, $t->{status}, $t->{gateway_transaction_id});
            }
        }
        catch {
            warn "There was a problem querying transactions: $_";
        };
    }

    return \%seen;
}

sub get_incomplete_sales {
    my ($self, $seen) = @_;

    my $rs = $self->rs;
    my @sales = $rs->search({ status => { -in => [ 'new', 'waiting' ] } })->all;
    my %sales;

    for my $sale (@sales) {
        next if $seen->{$sale->id};
        $sales{$sale->gateway} ||= [];
        push @{ $sales{$sale->gateway} }, $sale;
    }

    return \%sales;
}

sub update_all {
    my ($self) = @_;

    my $seen = $self->update_payments_without_id;
    my $sales = $self->get_incomplete_sales($seen);
    $self->update_sales($sales);

    return;
}

sub update_sales {
    my ($self, $sales) = @_;

    for my $gt (keys %$sales) {
        my $cpi = $self->cpi($gt);
        for my $sale ( @{ $sales->{$gt} } ) {
            if ($sale->gateway_id) {
                my $details = $cpi->get_transaction_details($sale->gateway_id);
                $self->update_sale($sale, $details->{status});
            }
        }
    }

    return;
}

sub update_sale {
    my ($self, $row, $status, $gateway_id) = @_;

    my %args;

    if ($gateway_id) {
        $args{gateway_id} = $gateway_id;
    }

    if ($status =~ /processing|pending/ && $row->status !~ /waiting/) {
        $args{status} = 'waiting';
    }
    elsif ($status =~ /success|completed/ && $row->status !~ /payed|sent-email/) {
        $args{status} = 'payed';
    }
    elsif ($status =~ /denied|reversed|failed/ && $row->status !~ /failed/) {
        $args{status} = 'failed';
    }
    else {
        # no change
    }

    if (keys %args) {
        $args{updated_at} = \'now()';
        $row->update(\%args);
    }

    return;
}

1;
