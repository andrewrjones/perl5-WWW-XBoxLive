#!perl

use strict;
use warnings;

use Test::More tests => 14;

BEGIN { use_ok('WWW::XBoxLive'); }
require_ok('WWW::XBoxLive');

my $xbox_live = new_ok('WWW::XBoxLive');

my $gamercard = $xbox_live->get('BrazenStraw3');
isa_ok( $gamercard, 'WWW::XBoxLive::Gamercard' );
is( $gamercard->gamertag, 'BrazenStraw3', 'gamertag' );
ok( $gamercard->is_valid, 'is_valid' );

is( $gamercard->account_status, 'gold', 'account_status' );
ok( $gamercard->bio,        'bio' );
ok( $gamercard->gamerscore, 'gamerscore' );
is( $gamercard->gender,   'male', 'gender' );
is( $gamercard->location, 'UK',   'location' );
ok( $gamercard->motto, 'motto' );
is( $gamercard->name, 'Andrew', 'name' );
like( $gamercard->reputation, qr/\d/, 'reputation' );

ok( $gamercard->recent_games, 'recent_games' );

__END__
These are live tests, just to make sure the format of the gamercard does not change.
