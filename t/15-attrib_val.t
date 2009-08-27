#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan( tests => 5);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @nodes;
@nodes = $e->findnodes( '//BBB[@id = "b1"]');
ok(@nodes, 1);

@nodes = $e->findnodes( '//BBB[@name = "bbb"]');
ok(@nodes, 1);

@nodes = $e->findnodes( '//BBB[normalize-space(@name) = "bbb"]');
ok(@nodes, 2);

exit 0;

__DATA__
<AAA>
<BBB id='b1'/>
<BBB name=' bbb '/>
<BBB name='bbb'/>
</AAA>
