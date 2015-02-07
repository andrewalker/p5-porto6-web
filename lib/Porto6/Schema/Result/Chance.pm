use utf8;
package Porto6::Schema::Result::Chance;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Porto6::Schema::Result::Chance

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

=head1 TABLE: C<chance>

=cut

__PACKAGE__->table("chance");

=head1 ACCESSORS

=head2 code

  data_type: 'text'
  is_nullable: 0

=head2 item

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 sale

  data_type: 'uuid'
  is_foreign_key: 1
  is_nullable: 0
  size: 16

=cut

__PACKAGE__->add_columns(
  "code",
  { data_type => "text", is_nullable => 0 },
  "item",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "sale",
  { data_type => "uuid", is_foreign_key => 1, is_nullable => 0, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</code>

=back

=cut

__PACKAGE__->set_primary_key("code");

=head1 RELATIONS

=head2 item

Type: belongs_to

Related object: L<Porto6::Schema::Result::Item>

=cut

__PACKAGE__->belongs_to(
  "item",
  "Porto6::Schema::Result::Item",
  { name => "item" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 sale

Type: belongs_to

Related object: L<Porto6::Schema::Result::Sale>

=cut

__PACKAGE__->belongs_to(
  "sale",
  "Porto6::Schema::Result::Sale",
  { id => "sale" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

=head2 winner

Type: might_have

Related object: L<Porto6::Schema::Result::Winner>

=cut

__PACKAGE__->might_have(
  "winner",
  "Porto6::Schema::Result::Winner",
  { "foreign.chance" => "self.code" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2015-02-07 11:00:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:JbIqp5ai7e2UqcPmqyHfsQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
