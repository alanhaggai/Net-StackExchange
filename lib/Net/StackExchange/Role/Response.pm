package Net::StackExchange::Role::Response;

# ABSTRACT: Common response methods

use Moose::Role;

has [ qw{ total page pagesize } ] => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

no Moose::Role;

1;

__END__

=attr C<total>

Returns total number of items in this sequence.

=attr C<page>

Returns page of the total collection returned.

=attr C<pagesize>

Returns size of each page returned from the collection.
