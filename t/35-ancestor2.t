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

my $xp = $e->xp;
$xp->set_namespace("text","http://example.com/text");

my @nodes;
@nodes = $e->findnodes( '//Footnote');
ok(@nodes, 1);

my $footnote = $nodes[0];

@nodes = $footnote->findnodes( 'ancestor::*');
ok(@nodes, 3);

@nodes = $footnote->findnodes('ancestor::text:footnote', $e);
ok(@nodes, 1);

exit 0;

__DATA__
<foo xmlns:text="http://example.com/text">
<text:footnote text:id="ftn2">
<text:footnote-citation>2</text:footnote-citation>
<text:footnote-body>
<Footnote style="font-size: 10pt; margin-left: 0.499cm;
margin-right: 0cm; text-indent: -0.499cm; font-family: ; ">AxKit
is very flexible in how it lets you transform the XML on the
server, and there are many modules you can plug in to AxKit to
allow you to do these transformations. For this reason, the AxKit
installation does not mandate any particular modules to use,
instead it will simply suggest modules that might help when you
install AxKit.</Footnote>
</text:footnote-body>
</text:footnote>
</foo>
