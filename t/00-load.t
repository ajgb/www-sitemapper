#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WWW::Sitemapper' ) || print "Bail out!
";
}

diag( "Testing WWW::Sitemapper $WWW::Sitemapper::VERSION, Perl $], $^X" );
