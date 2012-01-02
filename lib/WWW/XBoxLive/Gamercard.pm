use strict;
use warnings;

package WWW::XBoxLive::Gamercard;

# ABSTRACT: Represents an XBox Live Gamercard

use Object::Tiny qw{
  account_status
  bio
  gamerscore
  gamertag
  gender
  is_valid
  location
  motto
  name
  profile_link
  recent_games
  reputation
};

sub avatar_small {
    my ($this) = @_;

    return unless $this->gamertag;

    return sprintf( 'http://avatar.xboxlive.com/avatar/%s/avatarpic-s.png',
        $this->gamertag );
}

sub avatar_large {
    my ($this) = @_;

    return unless $this->gamertag;

    return sprintf( 'http://avatar.xboxlive.com/avatar/%s/avatarpic-l.png',
        $this->gamertag );
}

sub avatar_body {
    my ($this) = @_;

    return unless $this->gamertag;

    return sprintf( 'http://avatar.xboxlive.com/avatar/%s/avatar-body.png',
        $this->gamertag );
}

1;

=head1 SYNOPSIS

  my $gamercard = WWW::XBoxLive::Gamercard->new(%data);

  say $gamercard->name;
  say $gamercard->location;

=attr account_status

Either C<gold>, C<silver> or C<unknown>.

=attr avatar_small

URL to the small avatar pic. For example, L<http://avatar.xboxlive.com/avatar/BrazenStraw3/avatarpic-s.png>.

=attr avatar_large

URL to the large avatar pic. For example, L<http://avatar.xboxlive.com/avatar/BrazenStraw3/avatarpic-l.png>.

=attr avatar_body

URL to the avatar body pic. For example, L<http://avatar.xboxlive.com/avatar/BrazenStraw3/avatar-body.png>.

=attr bio

The players bio.

=attr gamerscore

The players gamerscore.

=attr gamertag

The players gamertag.

=attr gender

Either C<male>, C<female> or C<unknown>.

=attr is_valid

True if this is a valid profile (i.e. a real player).

=attr location

The location of the player.

=attr motto

The players motto.

=attr name

The players name.

=attr profile_link

A link to the profile.

=attr recent_games

Returns an array ref of L<WWW::XBoxLive::Game> objects.

=attr reputation

The number of reputation stars the player has. A number between 1 and 5.

=head1 SEE ALSO

=for :list
* L<WWW::XBoxLive>
* L<WWW::XBoxLive::Game>

=cut
