use utf8;
package Porto6::Schema::Result::Sale;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Porto6::Schema::Result::Sale

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::UUIDColumns>

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("UUIDColumns", "InflateColumn::DateTime");

=head1 TABLE: C<sale>

=cut

__PACKAGE__->table("sale");

=head1 ACCESSORS

=head2 id

  data_type: 'uuid'
  is_nullable: 0
  size: 16

=head2 client

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 status

  data_type: 'enum'
  default_value: 'new'
  extra: {custom_type_name => "sale_status",list => ["new","waiting","payed","sent-email","failed","expired"]}
  is_nullable: 0

=head2 gateway

  data_type: 'text'
  is_nullable: 0

=head2 gateway_id

  data_type: 'text'
  is_nullable: 1

=head2 created_at

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=head2 updated_at

  data_type: 'timestamp with time zone'
  default_value: current_timestamp
  is_nullable: 1
  original: {default_value => \"now()"}

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "uuid", is_nullable => 0, size => 16 },
  "client",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "status",
  {
    data_type => "enum",
    default_value => "new",
    extra => {
      custom_type_name => "sale_status",
      list => ["new", "waiting", "payed", "sent-email", "failed", "expired"],
    },
    is_nullable => 0,
  },
  "gateway",
  { data_type => "text", is_nullable => 0 },
  "gateway_id",
  { data_type => "text", is_nullable => 1 },
  "created_at",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
  "updated_at",
  {
    data_type     => "timestamp with time zone",
    default_value => \"current_timestamp",
    is_nullable   => 1,
    original      => { default_value => \"now()" },
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 chances

Type: has_many

Related object: L<Porto6::Schema::Result::Chance>

=cut

__PACKAGE__->has_many(
  "chances",
  "Porto6::Schema::Result::Chance",
  { "foreign.sale" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 client

Type: belongs_to

Related object: L<Porto6::Schema::Result::Client>

=cut

__PACKAGE__->belongs_to(
  "client",
  "Porto6::Schema::Result::Client",
  { id => "client" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2015-01-26 16:27:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1aSmn9EZOFKwxEGZhXNp2A

__PACKAGE__->uuid_columns('id');

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
