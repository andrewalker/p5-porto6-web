use utf8;
package Porto6::Schema::Result::Winner;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Porto6::Schema::Result::Winner

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

=head1 TABLE: C<winner>

=cut

__PACKAGE__->table("winner");

=head1 ACCESSORS

=head2 item

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 chance

  data_type: 'text'
  is_foreign_key: 1
  is_nullable: 0

=head2 client_email

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "item",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "chance",
  { data_type => "text", is_foreign_key => 1, is_nullable => 0 },
  "client_email",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</item>

=back

=cut

__PACKAGE__->set_primary_key("item");

=head1 UNIQUE CONSTRAINTS

=head2 C<winner_chance_key>

=over 4

=item * L</chance>

=back

=cut

__PACKAGE__->add_unique_constraint("winner_chance_key", ["chance"]);

=head2 C<winner_client_email_key>

=over 4

=item * L</client_email>

=back

=cut

__PACKAGE__->add_unique_constraint("winner_client_email_key", ["client_email"]);

=head1 RELATIONS

=head2 chance

Type: belongs_to

Related object: L<Porto6::Schema::Result::Chance>

=cut

__PACKAGE__->belongs_to(
  "chance",
  "Porto6::Schema::Result::Chance",
  { code => "chance" },
  { is_deferrable => 0, on_delete => "NO ACTION", on_update => "NO ACTION" },
);

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


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2015-02-07 11:00:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:u4SgO69C1ZYDbRZsqdeGaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
