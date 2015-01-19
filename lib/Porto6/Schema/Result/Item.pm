use utf8;
package Porto6::Schema::Result::Item;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Porto6::Schema::Result::Item

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

=head1 TABLE: C<item>

=cut

__PACKAGE__->table("item");

=head1 ACCESSORS

=head2 name

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("name", { data_type => "text", is_nullable => 0 });

=head1 PRIMARY KEY

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->set_primary_key("name");

=head1 RELATIONS

=head2 chances

Type: has_many

Related object: L<Porto6::Schema::Result::Chance>

=cut

__PACKAGE__->has_many(
  "chances",
  "Porto6::Schema::Result::Chance",
  { "foreign.item" => "self.name" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2015-01-19 19:23:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum://LDtzwE89C+p80zHKh4gw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
