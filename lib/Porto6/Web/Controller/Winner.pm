package Porto6::Web::Controller::Winner;
use Moose;
use Porto6::Winner;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub winners :Path('/winners') :Args(0) {
    my ( $self, $ctx ) = @_;

    my $w = Porto6::Winner->new;

    $w->roll_the_dice if $w->winner_rs->count == 0;

    $ctx->stash(
        json_data => {
            winners => [
                map {
                    {
                        name   => $_->chance->sale->client->name,
                        email  => $_->chance->sale->client->email,
                        chance => $_->chance->code,
                        item   => $_->item->name,
                    }
                } $w->winner_rs->all
            ]
        }
    );

}

__PACKAGE__->meta->make_immutable;

1;

=encoding utf-8

=head1 NAME

Porto6::Web::Controller::Winner - Winners of the prize

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 redirect

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
