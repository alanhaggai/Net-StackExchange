package Net::StackExchange::Owner;

# ABSTRACT: Attributes to represent a user

use Moose;
use Moose::Util::TypeConstraints;

has 'user_id' => (
    is       => 'rw',
    isa      => 'Int',
    required => 1,
);

has 'user_type' => (
    is       => 'rw',
    isa      => enum( [ qw{ anonymous unregistered registered moderator } ] ),
    required => 1,
);

has 'display_name' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

has 'reputation' => (
    is       => 'rw',
    isa      => 'Int',
    required => 1,
);

has 'email_hash' => (
    is       => 'rw',
    isa      => 'Str',
    required => 1,
);

__PACKAGE__->meta()->make_immutable();

no Moose;
no Moose::Util::TypeConstraints;

1;

__END__

=head1 SYNOPSIS



=attr C<user_id>

Returns id of the user.

=attr C<user_type>

Returns type of the user.

=attr C<display_name>

Returns displayable name of the user.

=attr C<reputation>

Returns reputation of the user.

=attr C<email_hash>

Returns email hash, suitable for fetching a gravatar.
