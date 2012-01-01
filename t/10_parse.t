#!perl

use strict;
use warnings;

use Test::More tests => 10;

use FindBin qw($Bin);

BEGIN { use_ok('WWW::XBoxLive'); }
require_ok('WWW::XBoxLive');

use WWW::XBoxLive::Gamercard;

my $xbox_live = new_ok( 'WWW::XBoxLive', );

open( my $fh, '<', "$Bin/resources/BrazenStraw3.card" ) or die $!;
my $hold = $/;
undef $/;
my $html = <$fh>;
$/ = $hold;

my $gamercard = $xbox_live->_parseCard($html);
isa_ok( $gamercard, 'WWW::XBoxLive::Gamercard' );

is(
    $gamercard->bio,
'Software developer and a bit of a geek. Arsenal fan. http://twitter.com/andrewrjones http://andrew-jones.com',
    'bio'
);
is( $gamercard->account_status, 'gold',            'account_status' );
is( $gamercard->gamerscore,     '135',             'gamerscore' );
is( $gamercard->location,       'UK',              'location' );
is( $gamercard->motto,          'Am I drunk yet?', 'motto' );
is( $gamercard->name,           'Andrew',          'name' );

close $fh;
