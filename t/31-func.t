#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan(tests => 5);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @nodes;
@nodes = $e->findnodes( '//BBB[position() mod 2 = 0 ]');
ok(@nodes, 4);

@nodes = $e->findnodes('//BBB
        [ position() = floor(last() div 2 + 0.5) 
            or
          position() = ceiling(last() div 2 + 0.5) ]');

ok(@nodes, 2);

@nodes = $e->findnodes('//CCC
        [ position() = floor(last() div 2 + 0.5) 
            or
          position() = ceiling(last() div 2 + 0.5) ]');

ok(@nodes, 1);

exit 0;

__DATA__
<AAA>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <BBB/>
    <CCC/>
    <CCC/>
    <CCC/>
</AAA>
