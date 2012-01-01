use strict;
use warnings;

package WWW::XBoxLive::Gamercard;

# ABSTRACT: Represents an XBox Live Gamercard

use Object::Tiny qw{
  account_status
  avatars
  bio
  gamerscore
  gamertag
  gender
  is_cheater
  is_valid
  location
  motto
  name
  online
  online_status
  profile_link
  recent_games
  reputation
};

1;

=head1 SYNOPSIS

  my $gamercard = WWW::XBoxLive::Gamercard->new(%data);

  say $gamercard->name;
  say $gamercard->location;

=attr account_status

Either C<gold> or C<free>.

=attr avatars

=attr bio

=attr gamerscore

=attr gamertag

=attr gender

Either C<male>, C<female> or C<unknown>.

=attr is_cheater

=attr is_valid

=attr location

=attr motto

=attr name

=attr online

=attr online_status

=attr profile_link

=attr recent_games

Returns an array ref of L<WWW::XBoxLive::Game> objects.

=attr reputation

=head1 SEE ALSO

=for :list
* L<WWW::XBoxLive>
* L<WWW::XBoxLive::Game>

=cut
