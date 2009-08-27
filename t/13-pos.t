#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan( tests => 4);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok( $e);

my $first = $e->findvalue( '/AAA/BBB[1]/@id');
ok($first, "first");

my $last = $e->findvalue( '/AAA/BBB[last()]/@id');
ok($last, "last");

exit 0;

__DATA__
<AAA>
<BBB id="first"/>
<BBB/>
<BBB/>
<BBB id="last"/>
</AAA>
