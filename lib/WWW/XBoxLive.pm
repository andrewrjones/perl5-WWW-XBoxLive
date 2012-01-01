use strict;
use warnings;

package WWW::XBoxLive;

# ABSTRACT: Get XBox Live gamercard information

use WWW::XBoxLive::Gamercard;
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
sub _parseCard {
    my ( $this, $html ) = @_;

    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    my $bio = _trimWhitespace( $tree->findvalue('//div[@id="Bio"]') );
    my $gamerscore =
      _trimWhitespace( $tree->findvalue('//div[@id="Gamerscore"]') );
    my $motto    = _trimWhitespace( $tree->findvalue('//div[@id="Motto"]') );
    my $location = _trimWhitespace( $tree->findvalue('//div[@id="Location"]') );
    my $name     = _trimWhitespace( $tree->findvalue('//div[@id="Name"]') );

    my $account_status = 'free';
    if ( $html =~ /<div class=.*Gold.*>/ ) {
        $account_status = 'gold';
    }

    $tree->delete;

    my $gamercard = WWW::XBoxLive::Gamercard->new(
        account_status => $account_status,
        bio            => $bio,
        gamerscore     => $gamerscore,
        location       => $location,
        motto          => $motto,
        name           => $name,
    );

    return $gamercard;
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

  my $gamercard = $xbox_live->get('BrazenStraw3');

  say $gamercard->name;
  say $gamercard->online_status;

  for my $game ($gamercard->recent_games){
    say $game->title;
    say $game->last_played;
  }

=cut
