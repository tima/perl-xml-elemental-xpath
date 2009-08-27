#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan( tests => 6);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @ids = $e->findnodes( '//BBB[@id]');
ok(@ids, 2);

my @names = $e->findnodes( '//BBB[@name]');
ok(@names, 1);

my @attribs = $e->findnodes( '//BBB[@*]');
ok(@attribs, 3);

my @noattribs = $e->findnodes( '//BBB[not(@*)]');
ok(@noattribs, 1);

exit 0;

__DATA__
<AAA>
<BBB id='b1'/>
<BBB id='b2'/>
<BBB name='bbb'/>
<BBB/>
</AAA>
