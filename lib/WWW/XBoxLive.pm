use strict;
use warnings;

package WWW::XBoxLive;

# ABSTRACT: Get XBox Live gamercard information

use WWW::XBoxLive::Gamercard;
use WWW::XBoxLive::Game;

use LWP::Simple              ();
use HTML::TreeBuilder::XPath ();

# the gamercard url
use constant GAMERCARD_URL => 'http://gamercard.xbox.com/%s/%s.card';

# if a user has this avatar, they are not a user
use constant INVALID_AVATAR =>
  'http://image.xboxlive.com//global/t.FFFE07D1/tile/0/20000';

=method new()

Create a new WWW::XBoxLive object.

=cut

sub new {
    my $class = shift;
    my $self  = {};

    bless( $self, $class );

    $self->{region} = 'en-US';

    return $self;
}

=method get_gamercard( $gamertag )

Get a gamercard. Returns an WWW::XBoxLive::Gamercard object.

=cut

sub get_gamercard {
    my ( $this, $gamertag ) = @_;

    # get the html
    my $html =
      LWP::Simple::get( sprintf( GAMERCARD_URL, $this->{region}, $gamertag ) );

    # parse
    my $gamercard = $this->_parse_gamercard($html);

    return $gamercard;
}

# parse the HTML
sub _parse_gamercard {
    my ( $this, $html ) = @_;

    # generate HTML tree
    my $tree = HTML::TreeBuilder::XPath->new_from_content($html);

    # get the gamertag
    my $gamertag = _trimWhitespace( $tree->findvalue('//title') );

    # is valid? If not, then skip everything else
    my $gamerpic = $tree->findvalue('//img[@id="Gamerpic"]/@src');
    if ( $gamerpic eq INVALID_AVATAR ) {
        return WWW::XBoxLive::Gamercard->new(
            gamertag => $gamertag,
            is_valid => 0,
        );
    }

    my $bio = _trimWhitespace( $tree->findvalue('//div[@id="Bio"]') );
    my $gamerscore =
      _trimWhitespace( $tree->findvalue('//div[@id="Gamerscore"]') );
    my $motto    = _trimWhitespace( $tree->findvalue('//div[@id="Motto"]') );
    my $location = _trimWhitespace( $tree->findvalue('//div[@id="Location"]') );
    my $name     = _trimWhitespace( $tree->findvalue('//div[@id="Name"]') );
    my $profile_link = $tree->findvalue('//a[@id="Gamertag"]/@href');

    # guess account status
    my $account_status = 'unknown';
    if ( $tree->exists('//body/div[@class=~ /Gold/]') ) {
        $account_status = 'gold';
    }
    elsif ( $tree->exists('//body/div[@class=~ /Silver/]') ) {
        $account_status = 'silver';
    }

    # find gender
    my $gender = 'unknown';
    if ( $tree->exists('//body/div[@class=~ /Male/]') ) {
        $gender = 'male';
    }
    elsif ( $tree->exists('//body/div[@class=~ /Female/]') ) {
        $gender = 'female';
    }

    # count the reputation stars
    my @reputation_stars =
      $tree->findnodes('//div[@class="RepContainer"]/div[@class="Star Full"]');
    my $reputation = scalar @reputation_stars;

    # games
    my @recent_games;
    for my $i ( 1 .. 5 ) {
        my $title = $tree->findvalue(
            '//ol[@id="PlayedGames"]/li[' . $i . ']/a/span[@class="Title"]' );
        if ($title) {
            my $last_played =
              $tree->findvalue( '//ol[@id="PlayedGames"]/li[' 
                  . $i
                  . ']/a/span[@class="LastPlayed"]' );
            my $earned_gamerscore =
              $tree->findvalue( '//ol[@id="PlayedGames"]/li[' 
                  . $i
                  . ']/a/span[@class="EarnedGamerscore"]' );
            my $available_gamerscore =
              $tree->findvalue( '//ol[@id="PlayedGames"]/li[' 
                  . $i
                  . ']/a/span[@class="AvailableGamerscore"]' );
            my $earned_achievements =
              $tree->findvalue( '//ol[@id="PlayedGames"]/li[' 
                  . $i
                  . ']/a/span[@class="EarnedAchievements"]' );
            my $available_achievements =
              $tree->findvalue( '//ol[@id="PlayedGames"]/li[' 
                  . $i
                  . ']/a/span[@class="AvailableAchievements"]' );
            my $percentage_complete =
              $tree->findvalue( '//ol[@id="PlayedGames"]/li[' 
                  . $i
                  . ']/a/span[@class="PercentageComplete"]' );

            my $game = WWW::XBoxLive::Game->new(
                available_achievements => $available_achievements,
                available_gamerscore   => $available_gamerscore,
                earned_achievements    => $earned_achievements,
                earned_gamerscore      => $earned_gamerscore,
                last_played            => $last_played,
                percentage_complete    => $percentage_complete,
                title                  => $title,
            );

            push @recent_games, $game;
        }
    }

    # to ensure we do not have memory leaks
    $tree->delete;

    # create new gamercard
    my $gamercard = WWW::XBoxLive::Gamercard->new(
        account_status => $account_status,
        bio            => $bio,
        gamerscore     => $gamerscore,
        gamertag       => $gamertag,
        gender         => $gender,
        is_valid       => 1,
        location       => $location,
        motto          => $motto,
        name           => $name,
        profile_link   => $profile_link,
        recent_games   => \@recent_games,
        reputation     => $reputation,
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
