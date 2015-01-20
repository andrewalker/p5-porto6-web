package Porto6::Web::Controller::Notify;
use Moose;
use Data::Printer;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub notify :Path('/notify') :Args(1) {
    my ( $self, $ctx, $gateway ) = @_;

    my $normalized_gateway = _normalize($gateway);

    # Business::CPI handles the rest
    # (beautifully, must I add)
    my $notification = $ctx->model('CPI')->get($normalized_gateway)->notify;

    my $sale = $ctx->model('DB::Sale')->find($notification->{payment_id});

    if (! $sale) {
        $ctx->log->warn("Could not find sale for " . p($notification));
        die();
    }

    if ($notification->{status} eq 'processing' && $sale->status ne 'waiting') {
        $sale->update({ status => 'waiting', updated_at => \'now()' });
    }
    elsif ($notification->{status} eq 'completed' && $sale->status ne 'payed' && $sale->status ne 'sent-email') {
        $sale->update({ status => 'completed', updated_at => \'now()' });
    }
    else {
        $ctx->log->warn("Oops. We have a problem. Sale: " . $sale->id);
        $ctx->log->warn("Notification: " . p($notification));
        $ctx->log->info("We're gonna tell $normalized_gateway it's ok anyway.");
    }

    # example notification:
    # {
    #     net_amount             => '200.00',
    #     gateway_transaction_id => '9E884542-81B3-4419-9A75-BCC6FB495EF1',
    #     payment_id             => 1,
    #     status                 => 'completed',
    #     amount                 => '200.00',
    #     date                   => '2011-02-10T16:13:41.000-03:00',
    #     payer                  => {
    #         name => "João da Silva",
    #     },
    #     exchange_rate => 0,
    #     fee           => '0.00'
    # }

    $ctx->res->body('kthx');
}

sub _normalize {
    my ($gateway) = @_;

    my $lowercased_gateway = lc $gateway;

    my %map = (
        paypal    => 'PayPal',
        pagseguro => 'PagSeguro',
    );

    return $map{$lowercased_gateway};
}

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Porto6::Web::Controller::Notify - Redirect Controller for Porto6::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 notify

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
