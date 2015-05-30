#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
use Test::More;
use JSON;

use Test::WWW::Mechanize::Catalyst;
use Porto6::Schema;
use Porto6::Config;

my $db = Porto6::Schema->connect(get_config()->{model}{DB}{connect_info}{dsn});
my $id;

sub cleanup {
    my $sale = $db->resultset('Sale')->find($id);
    $sale->chances->delete;
    my $client = $sale->client;
    $sale->delete;
    $client->delete;
}


subtest 'other methods are not found' => sub {
    my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Porto6::Web');

    my $res = $mech->get('/checkout');

    is($mech->status, 404, 'GET /checkout is 404');

};

subtest 'checkout' => sub {
    my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Porto6::Web');
    $mech->add_header('Content-Type', 'application/json');

    my $res = $mech->post('/checkout', Content => encode_json(
        {
            client => {
                name => 'André Walker',
                phone => '(19) 12341234',
                email => 'andre+test@whatever.com',
                comments => 'this is a comment',
            },
            items => [
                {
                    name => 'L3',
                    chances => 2,
                },
                {
                    name => 'J3',
                    chances => 6,
                }
            ],
            gateway => 'PagSeguro',
        }
    ));

    is($mech->ct, 'application/json', 'content-type is json');
    is($mech->status, 201, 'http status is created');

    my $json = decode_json($mech->content);

    is($json->{sale}{gateway}, 'PagSeguro', 'gateway is correct');
    is($json->{sale}{status}, 'new', 'status is correct');
    ok($json->{sale}{id}, 'there is an id');

    $id = $json->{sale}{id};

    my $sale = $db->resultset('Sale')->find($id);
    ok($sale, 'found sale in database');
    is($sale->chances->search({ item => 'L3' })->count, 2, 'L3 chances are correct');
    is($sale->chances->search({ item => 'J3' })->count, 6, 'J3 chances are correct');
};

subtest 'redirect' => sub {
    my $mech = Test::WWW::Mechanize::Catalyst->new(catalyst_app => 'Porto6::Web');
    $mech->add_header('Content-Type', 'application/json');

    $mech->get_ok("/redirect/$id");

    # TODO: test the rest
};

cleanup();

done_testing();
