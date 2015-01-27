package Porto6::Web::Controller::Deposit;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base :Chained('/') :PathPrefix :CaptureArgs(0) {
    my ( $self, $ctx ) = @_;

    $ctx->stash( current_model => 'DB::Sale', );
}

sub with_id :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $ctx, $id ) = @_;
    my $row = $ctx->model->find($id);

    if (!$row || $row->gateway ne 'Deposit') {
        return $ctx->detach('/error_404');
    }

    $ctx->stash(
        id => $id,
        row => $row
    );
}

sub confirm :Chained('with_id') :Args(0) {
    my ( $self, $ctx ) = @_;

    $ctx->stash->{row}->update({ status => 'payed' });

    $ctx->res->body('Confirmado.');
}

sub cancel :Chained('with_id') :Args(0) {
    my ( $self, $ctx ) = @_;

    $ctx->stash->{row}->update({ status => 'failed' });

    $ctx->res->body('Cancelado.');
}

sub send_mails :Chained('base') :Args(0) {
    my ( $self, $ctx ) = @_;

    $ctx->model('AfterSales')->update_deposit(sub {
        my ( $id, $action ) = @_;
        $ctx->uri_for( $self->action_for($action), [$id] );
    });

    $ctx->stash(current_view => 'DontCare');
}

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Porto6::Web::Controller::Deposit

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
