#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use Porto6::AfterSales;

my $updater = Porto6::AfterSales->new;
$updater->update_all;
