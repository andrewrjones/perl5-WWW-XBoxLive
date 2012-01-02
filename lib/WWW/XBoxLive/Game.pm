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

The number of available achievements for this game.

=attr available_gamerscore

The number of available gamerscore for this game.

=attr earned_achievements

The number of earned achievements for this game.

=attr earned_gamerscore

The number of earned gamerscore for this game.

=attr last_played

The date the game was last played, in the format '12/31/2011'

=attr percentage_complete

The percentage of the game complete, in the format '13%'

=attr title

The title of the game.

=head1 SEE ALSO

=for :list
* L<WWW::XBoxLive>

=cut
