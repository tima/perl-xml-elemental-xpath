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
@nodes = $e->findnodes( '/AAA/BBB/DDD/CCC/EEE/ancestor::*');
ok(@nodes, 4);
ok($nodes[1]->getName, "BBB"); # test document order

@nodes = $e->findnodes( '//FFF/ancestor::*');
ok(@nodes, 5);

exit 0;

__DATA__
<AAA>
<BBB><DDD><CCC><DDD/><EEE/></CCC></DDD></BBB>
<CCC><DDD><EEE><DDD><FFF/></DDD></EEE></DDD></CCC>
</AAA>
