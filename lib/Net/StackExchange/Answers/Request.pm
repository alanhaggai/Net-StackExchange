package Net::StackExchange::Answers::Request;

# ABSTRACT: Request methods for answers

use Moose;
use Moose::Util::TypeConstraints;

use JSON qw{ decode_json };

with 'Net::StackExchange::Role::Request';

has 'id' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has [ qw{ body comments } ] => (
    is     => 'rw',
    isa    => 'Boolean',
    coerce => 1,
);

has [ qw{ fromdate max min page todate } ] => (
    is  => 'rw',
    isa => 'Int',
);

has 'pagesize' => (
    is      => 'rw',
    isa     => 'Int',
    trigger => sub {
        my ( $self, $pagesize ) = @_;

        if ( $pagesize < 1 || $pagesize > 100 ) {
            confess 'value should be between 1 and 100 inclusive';
        }
    },
);

has 'order' => (
    is      => 'rw',
    isa     => enum( [ qw{ asc desc } ] ),
    default => 'desc',
);

has 'sort' => (
    is      => 'rw',
    isa     => enum( [ qw{ activity views creation votes } ] ),
    default => 'activity',
);

has '_NSE' => (
    is       => 'rw',
    isa      => 'Net::StackExchange',
    required => 1,
);

sub execute {
    my $self         = shift;
    my $json         = Net::StackExchange::Core::_execute($self);
    my $se           = $self->_NSE();
    my $json_decoded = decode_json($json);

    my $response = Net::StackExchange::Answers::Response->new( {
        '_NSE'          => $se,
        '_json_decoded' => $json_decoded,
        'json'          => $json,
        'total'         => $json_decoded->{'total'   },
        'page'          => $json_decoded->{'page'    },
        'pagesize'      => $json_decoded->{'pagesize'},
    } );
    return $response;
}

sub _get_request_attributes {
    return qw{ body comments fromdate max min order page pagesize sort todate };
}

__PACKAGE__->meta()->make_immutable();

no Moose;
no Moose::Util::TypeConstraints;

1;

__END__

=head1 SYNOPSIS

    use Net::StackExchange;

    my $se = Net::StackExchange->new( {
        'network' => 'stackoverflow.com',
        'version' => '1.0',
    } );

    my $answers_route   = $se->route('answers');
    my $answers_request = $answers_route->prepare_request( { 'id' => 1036353 } );

    $answers_request->body(1);

    my $answers_response = $answers_request->execute();

=head1 CONSUMES ROLES

L<Net::StackExchange::Roles::Request>

=attr C<id>

A single primary key identifier or a vectorised, semicolon-delimited list of
identifiers.

=attr C<body>

When true, a post's body will be included in the response.

=attr C<comments>

When true, any comments on a post will be included in the response.

=attr C<fromdate>

Unix timestamp of the minimum creation date on a returned item. Accepted range
is 0 to 253_402_300_799.

=attr C<max>

Maximum of the range to include in the response according to the current C<sort>.

=attr C<min>

Minimum of the range to include in the response according to the current C<sort>.

=attr C<order>

How the current C<sort> should be ordered. Accepted values are C<desc> (default)
or C<asc>.

=attr C<page>

The pagination offset for the current collection. Affected by the specified
C<pagesize>.

=attr C<pagesize>

The number of collection results to display during pagination. Should be between
1 and 100 inclusive.

=attr C<sort>

How a collection should be sorted. Valid values are one of C<activity> (default),
C<views>, C<creation>, or C<votes>.

=attr C<todate>

Unix timestamp of the maximum creation date on a returned item. Accepted range
is 0 to 253_402_300_799.

=method C<execute>

Executes the request and returns a L<Net::StackExchange::Answers::Response>
object.
