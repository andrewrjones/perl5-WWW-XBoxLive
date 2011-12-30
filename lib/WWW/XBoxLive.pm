use strict;
use warnings;

package WWW::XBoxLive;

# ABSTRACT: Get XBox Live profile information

use WWW::XBoxLive::Profile;
use WWW::XBoxLive::Game;

use HTML::TreeBuilder::XPath;

=method new()

Create a new WWW::XBoxLive object

=cut

sub new {
    my $class = shift;
    my $self  = {};

    bless( $self, $class );
    return $self;
}

=method get( $gamertag )

Get a profile. Returns an WWW::XBoxLive::Profile object

=cut

sub get {
    my ( $this, $gamertag ) = @_;
}

# parse the HTML
sub _parse {
    my ( $this, $html ) = @_;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    my $bio = _trimWhitespace(
        $tree->findvalue('//div[@class="bio"]/div[@class="value"]') );
    my $gamerscore =
      _trimWhitespace( $tree->findvalue('//div[@class="gamerscore"]') );
    my $motto    = _trimWhitespace( $tree->findvalue('//div[@class="motto"]') );
    my $location = _trimWhitespace(
        $tree->findvalue('//div[@class="location"]/div[@class="value"]') );
    my $name = _trimWhitespace(
        $tree->findvalue('//div[@class="name"]/div[@class="value"]') );
    my $online_status =
      _trimWhitespace( $tree->findvalue('//div[@class="presence"]') );

    my $account_status = 'free';
    if ( $tree->findvalue('//div[@class="goldBadge"]') ) {
        $account_status = 'gold';
    }

    my $profile = WWW::XBoxLive::Profile->new(
        account_status => $account_status,
        bio            => $bio,
        gamerscore     => $gamerscore,
        location       => $location,
        motto          => $motto,
        name           => $name,
        online_status  => $online_status,
    );

    return $profile;
}

# trims whitespace from a string
sub _trimWhitespace {
    my $string = shift;
    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    return $string;
}

1;

=head1 SYNOPSIS

  my $xbox_live = WWW::XBoxLive->new();

  my $profile = $xbox_live->get('BrazenStraw3');

  say $profile->name;
  say $profile->online_status;

  for my $game ($profile->recent_games){
    say $game->title;
    say $game->last_played;
  }

=cut
