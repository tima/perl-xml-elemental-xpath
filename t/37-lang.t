#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan(tests => 4);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @en = $e->findnodes( '//*[lang("en")]');
ok(@en, 2);

my @de = $e->findnodes( '//content[lang("de")]');
ok(@de, 1);

exit 0;

__DATA__
<page xml:lang="en">
  <content>Here we go...</content>
  <content xml:lang="de">und hier deutschsprachiger Text :-)</content>
</page>
