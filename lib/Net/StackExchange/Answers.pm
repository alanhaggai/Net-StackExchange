package Net::StackExchange::Answers;

# ABSTRACT: Provides accessors for an answer

use Moose;

has [
    qw{
        answer_id
        question_id
        creation_date
        up_vote_count
        down_vote_count
        view_count score
      }
    ] => (
    is       => 'ro',
    isa      => 'Int',
    required => 1,
);

has 'accepted' => (
    is       => 'ro',
    isa      => 'Boolean',
    required => 1,
    coerce   => 1,
);

has [
    qw{
        answer_comments_url
        title
      }
    ] => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has [
    qw{
        locked_date
        last_edit_date
        last_activity_date
      }
    ] => (
    is  => 'ro',
    isa => 'Int',
);

has 'owner' => (
    is  => 'ro',
    isa => 'Net::StackExchange::Owner',
);

has 'community_owned' => (
    is       => 'ro',
    isa      => 'Boolean',
    required => 1,
    coerce   => 1,
);

has 'body' => (
    is  => 'ro',
    isa => 'Str',
);

has 'comments' => (
    is  => 'ro',
    isa => 'ArrayRef[Net::StackExchange::Comments]',
);

has '_NSE' => (
    is       => 'ro',
    isa      => 'Net::StackExchange',
    required => 1,
);

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
    my $answers_request = $answers_route->prepare_request( { 'id' => '1036353' } );

    $answers_request->body(1);

    my $answers_response = $answers_request ->execute( );
    my $answer           = $answers_response->answers(0);

    print "__Answer__\n";
    print "Title: ", $answer->title(), "\n";
    print "Body: ",  $answer->body (), "\n";

=attr C<answer_id>

Returns id of the answer.

=attr C<accepted>

Returns whether this answer is the accepted answer on its question.

=attr C<answer_comments_url>

Returns a link to the method that returns comments on this answer.

=attr C<question_id>

Returns id of the question this post is or is on.

=attr C<locked_date>

Returns date this question was locked.

=attr C<owner>

Returns a L<Net::StackExchange::Owner> object.

=attr C<creation_date>

Returns date this post was created.

=attr C<last_edit_date>

Returns last time this post was edited.

=attr C<last_activity_date>

Returns last time this post had any activity.

=attr C<up_vote_count>

Returns number of up votes on this post.

=attr C<down_vote_count>

Returns number of down votes on this post.

=attr C<view_count>

Returns number of times this post has been viewed.

=attr C<score>

Returns score of this post.

=attr C<community_owned>

Returns whether this post is community owned.

=attr C<title>

Returns title of this post, in plaintext.

=attr C<body>

Returns body of this post, rendered as HTML.

=attr C<comments>

Returns a L<Net::StackExchange::Comments> object.
