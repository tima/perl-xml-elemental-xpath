#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan( tests => 7);
 
 use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @nodes;
@nodes = $e->findnodes( '//*[count(BBB) = 2]');
ok($nodes[0]->getName, "DDD");

@nodes = $e->findnodes( '//*[count(*) = 2]');
ok(@nodes, 2);

@nodes = $e->findnodes( '//*[count(*) = 3]');
ok(@nodes, 2);
ok($nodes[0]->getName, "AAA");
ok($nodes[1]->getName, "CCC");

exit 0;

__DATA__
<AAA>
<CCC><BBB/><BBB/><BBB/></CCC>
<DDD><BBB/><BBB/></DDD>
<EEE><CCC/><DDD/></EEE>
</AAA>
