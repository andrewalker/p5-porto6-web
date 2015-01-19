package Porto6::Web::Model::DB;

use Moose;
extends 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Porto6::Schema',
);

1;
