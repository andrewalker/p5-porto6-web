package Porto6::Web::Controller::Redirect;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub redirect :Path('/redirect') :Args(1) {
    my ( $self, $ctx, $payment_id ) = @_;

    my $sale = $ctx->model('DB::Sale')->find($payment_id);

    if (!$sale) {
        die 'Pagamento não encontrado';
    }

    if ($sale->status ne 'new') {
        die 'Status é ' . $sale->status;
    }

    my $cpi = $ctx->model('CPI')->get($sale->gateway);
    my $client = $sale->client;

    my $cart = $cpi->new_cart({
        buyer => {
            name => $client->name,
            email => $client->email,
        }
    });

    my %items;

    for ($sale->chances->all) {
        my $item = $_->item;
        $items{ $item->name } //= { count => 0, price => $item->price };
        $items{ $item->name }{count}++;
    }

    for my $name (keys %items) {
        $cart->add_item({
            id          => "smnp-$name",
            quantity    => $items{$name}{count},
            price       => $items{$name}{price},
            description => "Cupons para sorteio ($name)",
        });
    }

    $ctx->stash(
        checkout_form => $cart->get_form_to_pay( $sale->id ),
        current_view  => 'CheckoutForm'
    );
}

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Porto6::Web::Controller::Redirect - Redirect Controller for Porto6::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 redirect

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
