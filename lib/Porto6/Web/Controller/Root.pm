package Porto6::Web::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

__PACKAGE__->config(namespace => '');

sub index :Path :Args(0) {
    my ( $self, $ctx ) = @_;

    $ctx->res->body('hello there');
}

sub default :Path {
    my ( $self, $ctx ) = @_;

    $ctx->detach('/error_404');
}

sub error_404 :Private {
    my ( $self, $ctx ) = @_;

    $ctx->stash( json_data => { msg => 'Page not found' } );
    $ctx->res->status(404);
}

sub ping :Path('/ping') :Args(0) {
    my ( $self, $ctx ) = @_;
    $ctx->stash( json_data => { msg => 'Pong' } );
}

sub end : ActionClass('RenderView') {}

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Porto6::Web::Controller::Root - Root Controller for Porto6::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=head2 default

Standard 404 error page

=head2 end

Attempt to render a view, if needed.

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
