#!/usr/bin/env perl
use warnings;
use strict;
use FindBin '$Bin';
use lib "$Bin/../lib";
use DBIx::Class::Schema::Loader qw/make_schema_at/;
use Porto6::Schema;

my $info = (values %{ Porto6::Schema->config->[0] })[0]->{PORTO6_DATABASE};

make_schema_at(
    'Porto6::Schema',
    {
        dump_directory    => "$Bin/../lib",
        components        => [ 'UUIDColumns', 'InflateColumn::DateTime' ],
        quote_names       => 1,
        db_schema         => ['porto6'],
        schema_base_class => 'DBIx::Class::Schema::Config',
    },
    [
        $info->{dsn},
        $info->{user},
        $info->{password},
        undef,
        {
            on_connect_do => ['SET search_path TO porto6, public, pg_catalog'],
        }
    ],
);
