#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan( tests => 5);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

my $doc_one = qq|<doc><para>para one</para></doc>|;

my $e = $x->parse_string($doc_one);
ok($e);

my $doc_one_chars = $e->find( 'string-length(/doc/text())');
ok($doc_one_chars == 0, 1);

my $doc_two = qq|
<doc>
  <para>para one has <b>bold</b> text</para>
</doc>
|;

$e = $x->parse_string($doc_two);
ok($e);

my $doc_two_chars = $e->find( 'string-length(/doc/text())');
ok($doc_two_chars == 3, 1);

my $doc_two_para_chars = $e->find( 'string-length(/doc/para/text())');
ok($doc_two_para_chars == 13, 1);

exit 0;

