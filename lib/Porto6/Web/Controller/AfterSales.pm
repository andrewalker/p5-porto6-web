package Porto6::Web::Controller::AfterSales;
use Moose;
use Data::Printer;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/') :PathPart('') :CaptureArgs(0) {
    my ( $self, $ctx ) = @_;
    $ctx->stash(
        current_model => 'AfterSales',
        current_view  => 'DontCare',
    );
}

sub gateway_postback :Chained('base') :PathPart('gateway_postback') :Args(1) {
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

    $ctx->model->update_sale($sale, $notification->{status}, $notification->{gateway_transaction_id});
}

sub update_all :Chained('base') :PathPart('update_all') :Args(0) {
    my ( $self, $ctx ) = @_;
    $ctx->model->update_all;
}

sub send_mails :Chained('base') :PathPart('send_mails') :Args(0) {
    my ( $self, $ctx ) = @_;
    $ctx->model->send_payment_received_mails;
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
