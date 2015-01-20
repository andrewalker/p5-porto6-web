use strict;
use warnings;
use lib 'lib';

use Porto6::Web;

my $app = Porto6::Web->apply_default_middlewares(Porto6::Web->psgi_app);
$app;

