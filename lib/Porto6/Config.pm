package Porto6::Config;
use warnings;
use strict;
use utf8;
use feature 'state';
use Exporter 'import';
use Config::ZOMG;
use Catalyst::Utils ();
use Data::Visitor::Callback;

our @EXPORT = qw/get_config/;

sub get_config {
    state $config;

    if (!$config) {
        my $home = Catalyst::Utils::home(__PACKAGE__);

        my $obj = Config::ZOMG->new(
            name         => 'porto6_web',
            path         => $home,
            local_suffix => exists $ENV{CATALYST_CONFIG_LOCAL_SUFFIX}
                         ?  $ENV{CATALYST_CONFIG_LOCAL_SUFFIX}
                         :  'local',
        );

        $config = visit( $obj->load );
    }

    return $config;
}

sub visit {
    my ($c) = @_;

    my $v = Data::Visitor::Callback->new(
        plain_value => sub {
            return unless defined $_;

            if (/__ENV\(([^\)]+)\)__/) {
                my $env_var = $1;

                if (!defined $ENV{ $env_var }) {
                    die "Missing required ENV var $env_var";
                }
                else {
                    return $ENV{ $env_var };
                }
            }
            else {
                return $_;
            }
        }
    );

    return $v->visit( $c );
}

1;
