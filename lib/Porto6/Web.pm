package Porto6::Web;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.90;

use Catalyst qw/ConfigLoader/;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config(
    name => 'Porto6::Web',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1, # Send X-Catalyst header
);

# Start the application
__PACKAGE__->setup();

1;

=encoding utf8

=head1 NAME

Porto6::Web - Catalyst based application

=head1 SYNOPSIS

    script/porto6_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Porto6::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

André Walker

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.
