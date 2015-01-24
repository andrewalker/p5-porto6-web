package Porto6::Web::Controller::Notify;
use Moose;
use Data::Printer;
use namespace::autoclean;
use Porto6::UpdateStatus;

BEGIN { extends 'Catalyst::Controller' }

has _updater => (
    is => 'rw',
    predicate => '_has_updater',
);

sub updater {
    my ($self, $ctx) = @_;

    if (!$self->_has_updater) {
        my $updater = Porto6::UpdateStatus->new(
            rs => $ctx->model('DB::Sale'),
        );
        return $self->_updater($updater);
    }

    return $self->_updater;
}

sub notify :Path('/notify') :Args(1) {
    my ( $self, $ctx, $gateway ) = @_;

    my $normalized_gateway = _normalize($gateway);
    my $updater = $self->updater($ctx);

    # Business::CPI handles the rest
    # (beautifully, must I add)
    my $notification = $ctx->model('CPI')->get($normalized_gateway)->notify;

    my $sale = $ctx->model('DB::Sale')->find($notification->{payment_id});

    if (! $sale) {
        $ctx->log->warn("Could not find sale for " . p($notification));
        die();
    }

    $updater->update_sale($sale, $notification->{status}, $notification->{gateway_transaction_id});

    $ctx->res->body('kthx');
}

sub update_all :Path('/update_all') :Args(0) {
    my ( $self, $ctx ) = @_;
    $self->updater($ctx)->update_all;
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
