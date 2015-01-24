#!/usr/bin/env perl
use warnings;
use strict;
use utf8;
use Porto6::UpdateStatus;

my $updater = Porto6::UpdateStatus->new;
$updater->update_all;
