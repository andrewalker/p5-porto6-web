requires 'Catalyst::Runtime' => '5.90082';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General';
requires 'DBIx::Class::UUIDColumns';
requires 'DBIx::Class::Schema::Config';
requires 'Catalyst::Model::CPI';
requires 'Business::CPI::Gateway::PagSeguro' => '0.904';
requires 'Business::CPI::Gateway::PayPal' => '0.905';
requires 'String::Random';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::View::JSON';
requires 'Test::WWW::Mechanize::Catalyst';
requires 'Data::Printer';
requires 'Test::More' => '0.88';
requires 'DBD::Pg' => '2.0';
requires 'DateTime::Format::Pg';
requires 'URI::db';
requires 'Config::ZOMG';
requires 'Data::Visitor::Callback';

on develop => sub {
    requires 'Catalyst::Devel';
    requires 'App::Sqitch';
};
