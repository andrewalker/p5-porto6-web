requires 'Catalyst::Runtime' => '5.90082';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General';
requires 'DBIx::Class::UUIDColumns';
requires 'DBIx::Class::Schema::Config';
requires 'URI::db';

on test => sub {
    requires 'Test::More' => '0.88';
};
