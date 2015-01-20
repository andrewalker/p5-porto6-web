package Porto6::Web::Controller::Checkout;
use Moose;
use namespace::autoclean;
use String::Random qw/random_string/;

BEGIN { extends 'Catalyst::Controller' }

sub place_order :Path('/checkout') Args(0) POST {
    my ( $self, $ctx ) = @_;

    my $req = $ctx->req->body_data;
    my $chance_rs = $ctx->model('DB::Chance');

    my $client = $ctx->model('DB::Client')->create($req->{client});
    my $sale = $client->add_to_sales({ gateway => $req->{gateway} });

    for my $item (@{ $req->{items} }) {
        for (1 .. $item->{chances}) {
            my $random_code = _gen_random_code($chance_rs);
            $sale->add_to_chances({ item => $item->{name}, code => $random_code });
        }
    }

    $sale->discard_changes;

    $ctx->stash(json_data => {
        sale => {
            id      => $sale->id,
            gateway => $sale->gateway,
            status  => $sale->status,
        }
    });
    $ctx->res->status(201);
}

sub _gen_random_code {
    my ($rs) = @_;
    my $code = random_string('n' x 10);

    return _gen_random_code($rs) if (substr($code, 0, 1) eq '0' || $rs->count({ code => $code }));

    return $code;
}

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Porto6::Web::Controller::Checkout - Checkout Controller for Porto6::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 place_order

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
