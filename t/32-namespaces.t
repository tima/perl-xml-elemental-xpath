#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan(tests => 7);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @nodes;

my $xp = $e->root->xp;

$xp->set_namespace("foo", "http://flubber.example.com/");
$xp->set_namespace("goo", "http://foobar.example.com/");
$xp->set_namespace("attr", "http://attribute.example.com/");

@nodes = $e->findnodes('//foo:foo'); # should find flubber.com foos
ok( @nodes, 2);

@nodes = $e->findnodes('//goo:foo'); # should find foobar.com foos
ok( @nodes, 3);

@nodes = $e->findnodes('//foo'); # should NOT find default NS foos
ok( @nodes, 0);

my @vals = $e->findvalue('//attr:node/@attr:findme');
ok( @vals, 1);
ok( $vals[0], 'someval');

exit 0;

__DATA__
<xml xmlns:foo="http://foobar.example.com/"
    xmlns="http://flubber.example.com/">
    <foo>
        <bar/>
        <foo/>
    </foo>
    <foo:foo>
        <foo:foo/>
        <foo:bar/>
        <foo:bar/>
        <foo:foo/>
    </foo:foo>
    <attr:node xmlns:attr="http://attribute.example.com/"
        attr:findme="someval">attr content</attr:node >
</xml>
