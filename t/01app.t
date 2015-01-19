#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

use Catalyst::Test 'Porto6::Web';

ok( request('/')->is_success, 'Request should succeed' );

done_testing();
