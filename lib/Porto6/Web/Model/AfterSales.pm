package Porto6::Web::Model::AfterSales;
use warnings;
use strict;
use utf8;

use base 'Catalyst::Model::Adaptor';

__PACKAGE__->config(
    class => 'Porto6::AfterSales',
);

sub prepare_arguments {
    my ($self, $app) = @_;

    return { rs => $app->model('DB::Sale') };
}

1;
