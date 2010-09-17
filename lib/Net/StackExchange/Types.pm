package Net::StackExchange::Types;

# ABSTRACT: Custom types

use Moose::Util::TypeConstraints;
use JSON;

subtype 'List::id'
    => as 'Str'
    => where { $_ =~ /^(?:\d;?)+$/ };

subtype 'JSON::XS::Boolean'
    => as 'JSON::XS::Boolean';

subtype 'JSON::PP::Boolean'
    => as 'JSON::PP::Boolean';

subtype 'Boolean'
    => as 'Str'
    => where { $_ eq 'true' || $_ eq 'false' };

coerce 'Boolean'
    => from 'JSON::XS::Boolean'
    => via {
        if ( JSON::is_bool($_) && $_ == JSON::true ) {
            return 'true';
        }
        return 'false';
    }
    => from 'JSON::PP::Boolean'
    => via {
        if ( JSON::is_bool($_) && $_ == JSON::true ) {
            return 'true';
        }
        return 'false';
    }
    => from 'Int'
    => via {
        if ($_) {
            return 'true';
        }
        return 'false';
    };

no Moose::Util::TypeConstraints;

1;
