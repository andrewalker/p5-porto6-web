package Porto6::Winner;
use Porto6::Config;
use Porto6::Schema;
use List::Util qw/shuffle/;
use Moose;
use utf8;
use open qw< :std :utf8 >;

has db => (
    is      => 'ro',
    lazy    => 1,
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

has item_rs => (
    is      => 'ro',
    lazy    => 1,
    isa     => 'DBIx::Class::ResultSet',
    default => sub { shift->db->resultset('Item') },
);

has winner_rs => (
    is      => 'ro',
    lazy    => 1,
    isa     => 'DBIx::Class::ResultSet',
    default => sub { shift->db->resultset('Winner') },
);

has sale_rs => (
    is      => 'ro',
    lazy    => 1,
    isa     => 'DBIx::Class::ResultSet',
    default => sub { shift->db->resultset('Sale') },
);

sub _find_and_save_winner {
    my ($self, $item, @chances) = @_;

    # yes, I'm paranoid
    for ( 0 .. int(rand 100) ) {
        @chances = shuffle(@chances);
    }

    my $picked = $chances[rand @chances];

    $self->winner_rs->create({
        chance       => $picked->[0],
        client_email => $picked->[1],
        item         => $item,
    });

    return $picked->[1];
}

sub roll_the_dice {
    my ($self) = @_;

    if ($self->winner_rs->count > 0) {
        warn "Not rolling the dice: winners already set";
        return;
    }

    my $sales = $self->sale_rs->search({ status => { -in => ['sent-email', 'payed'] } });
    my %chances;

    while (my $sale = $sales->next) {
        my $email = $sale->client->email;
        $chances{$email} ||= {
            L3 => [],
            J3 => [],
            V1 => [],
        };

        for my $c ($sale->chances->all) {
            my $item = $c->get_column('item');
            push @{ $chances{$email}{$item} }, [ $c->code, $email ];
        }
    }

    for my $i (shuffle(qw/L3 J3 V1/)) {
        my $winner_email = $self->_find_and_save_winner($i, map { @{ $_->{$i} } } values %chances);
        delete $chances{$winner_email};
    }
}

sub print_winners {
    my ($self) = @_;

    if ($self->winner_rs->count == 0) {
        $self->roll_the_dice;
    }

    my $winners = $self->winner_rs->search;

    while (my $winner = $winners->next) {
        my $client = $winner->chance->sale->client;
        my $item = $winner->chance->get_column('item');
        print "Item $item: " . $client->name . ' - ' . $client->email . "\n";
    }
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;
