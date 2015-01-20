#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use JSON;

use Test::WWW::Mechanize::Catalyst;

my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Porto6::Web');

$mech->get_ok('/ping');

is($mech->ct, 'application/json', 'content-type is json');

my $json = decode_json($mech->content);

is($json->{msg}, 'Pong', 'message is correct');

done_testing();
