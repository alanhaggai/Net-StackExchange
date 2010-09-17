package Net::StackExchange::Role::Request;

# ABSTRACT: Common request methods

use Carp qw{ croak };
use Moose::Role;
use Moose::Util::TypeConstraints;

has 'type' => (
    is      => 'rw',
    isa     => 'Str',
    trigger => sub {
        my ( $self, $type ) = @_;

        if ( $type ne 'jsontext' ) {
            confess q{the only valid value is 'jsontext'};
        }
    },
);

has [ qw{ key jsonp } ] => (
    is  => 'rw',
    isa => 'Str',
);

no Moose::Role;
no Moose::Util::TypeConstraints;

1;

__END__

=attr C<type>

The only valid value is C<jsontext>. Responds with mime-type text/json, if set.

=attr C<key>

Accepts a key and validates this request to a specific application.

=attr C<jsonp>

If set, the response returns JSON with Padding instead of standard JSON.
