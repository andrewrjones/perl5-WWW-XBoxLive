#!perl

use strict;
use warnings;

use Test::More tests => 5;

BEGIN { use_ok('WWW::XBoxLive::Profile'); }
require_ok('WWW::XBoxLive::Profile');

my $profile = new_ok(
    'WWW::XBoxLive::Profile',
    [
        gamertag => 'BrazenStraw3',
        name     => 'Andrew',
    ]
);

is( $profile->gamertag, 'BrazenStraw3' );
is( $profile->name,     'Andrew' );
