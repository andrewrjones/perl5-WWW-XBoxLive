use strict;
use warnings;

package WWW::XBoxLive::Profile;

# ABSTRACT: Represents an XBox Live profile

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

  my $profile = WWW::XBoxLive::Profile->new(%data);

  say $profile->name;
  say $profile->location;

=attr account_status

Either C<gold> or C<free>

=attr avatars

=attr bio

=attr gamerscore

=attr gamertag

=attr gender

=attr is_cheater

=attr is_valid

=attr location

=attr motto

=attr name

=attr online

=attr online_status

=attr profile_link

=attr recent_games

Returns an array of L<WWW::XBoxLive::Game> objects.

=attr reputation

=head1 SEE ALSO

=for :list
* L<WWW::XBoxLive>
* L<WWW::XBoxLive::Game>

=cut
