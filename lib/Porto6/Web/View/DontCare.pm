package Porto6::Web::View::DontCare;
use warnings;
use strict;
use utf8;
use base 'Catalyst::View';

sub process {
    my ($self, $ctx) = @_;
    $ctx->res->content_type('text/plain');
    $ctx->res->output('kthx');
}

1;
