package Net::StackExchange::Route;

# ABSTRACT: Builds appropriate request object

use Moose;

has '_route' => (
    is  => 'ro',
    isa => 'Str',
);

has '_NSE' => (
    is       => 'ro',
    isa      => 'Net::StackExchange',
    required => 1,
);

sub prepare_request {
    my ( $self, $arg ) = @_;

    $arg->{'_NSE'} = $self->_NSE();
    my $route      = $self->_route();
    return "Net::StackExchange::${route}::Request"->new($arg);
}

__PACKAGE__->meta()->make_immutable();

no Moose;

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

=method C<prepare_request>

Returns respective request object based on the route with which this object has
been created. The request object for the particular route will be constructed
using the hash reference that is passed to C<prepare_request>.
