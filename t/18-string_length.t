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
@nodes = $e->findnodes( '//*[string-length(name()) = 3]');
ok(@nodes, 2);

@nodes = $e->findnodes( '//*[string-length(name()) < 3]');
ok(@nodes, 2);

@nodes = $e->findnodes( '//*[string-length(name()) > 3]');
ok(@nodes, 3);

exit 0;

__DATA__
<AAA>
<Q/>
<SSSS/>
<BB/>
<CCC/>
<DDDDDDDD/>
<EEEE/>
</AAA>
