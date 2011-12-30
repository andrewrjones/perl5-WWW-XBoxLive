use strict;
use warnings;

package WWW::XBoxLive::Game;

# ABSTRACT: Represents an XBox Live game

use Object::Tiny qw{
  available_achievements
  available_gamerscore
  earned_gamerscore
  earned_achievements
  last_played
  percentage_complete
  title
};

1;

=head1 SYNOPSIS

  my $game = WWW::XBoxLive::Game->new(%data);

=attr available_achievements

=attr available_gamerscore

=attr earned_gamerscore

=attr earned_achievements

=attr last_played

=attr percentage_complete

=attr title

=head1 SEE ALSO

=for :list
* L<WWW::XBoxLive>

=cut
