#!perl

use strict;
use warnings;

use Test::More tests => 10;

use FindBin qw($Bin);

BEGIN { use_ok('WWW::XBoxLive'); }
require_ok('WWW::XBoxLive');

use WWW::XBoxLive::Profile;

my $xbox_live = new_ok( 'WWW::XBoxLive', );

open( my $fh, '<', "$Bin/resources/BrazenStraw3.htm" ) or die $!;
my $hold = $/;
undef $/;
my $html = <$fh>;
$/ = $hold;

my $profile = $xbox_live->_parse($html);
isa_ok( $profile, 'WWW::XBoxLive::Profile' );

is(
    $profile->bio,
'Software developer and a bit of a geek. Arsenal fan. http://twitter.com/andrewrjones http://andrew-jones.com',
    'bio'
);
is( $profile->account_status, 'gold',            'account_status' );
is( $profile->location,       'UK',              'location' );
is( $profile->motto,          'Am I drunk yet?', 'motto' );
is( $profile->name,           'Andrew',          'name' );
is( $profile->online_status,
    'Last seen less than a minute ago playing Xbox Dashboard',
    'online_status' );
