use utf8;
package Porto6::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema::Config';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2015-01-19 19:22:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Kn1e38PuNyMnZpLkAJVeGw

use URI;

sub filter_loaded_credentials {
    my $class = shift;

    my $res = $class->next::method( @_ );

    if ( exists $ENV{DATABASE_URL} ) {
        my $var = $ENV{DATABASE_URL};
        $var =~ s/^postgres/db:pg/;

        my $uri = URI->new( $var );

        $res->{dsn}      = $uri->dbi_dsn;
        $res->{user}     = $uri->user;
        $res->{password} = $uri->password;
    }

    return $res;
};

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
