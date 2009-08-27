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
@nodes = $e->findnodes( '//*[name() = "BBB"]');
ok(@nodes, 5);

@nodes = $e->findnodes( '//*[starts-with(name(), "B")]');
ok(@nodes, 7);

@nodes = $e->findnodes( '//*[contains(name(), "C")]');
ok(@nodes, 3);

exit 0;

__DATA__
<AAA>
<BCC><BBB/><BBB/><BBB/></BCC>
<DDB><BBB/><BBB/></DDB>
<BEC><CCC/><DBD/></BEC>
</AAA>
