#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan(tests => 6);
 
use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @nodes;
@nodes = $e->findnodes( '/AAA/BBB/following-sibling::*');
ok(@nodes, 2);
ok($nodes[1]->getName, "CCC"); # test document order

@nodes = $e->findnodes( '//CCC/following-sibling::*');
ok(@nodes, 3);
ok($nodes[1]->getName, "FFF");

exit 0;

__DATA__
<AAA>
<BBB><CCC/><DDD/></BBB>
<XXX><DDD><EEE/><DDD/><CCC/><FFF/><FFF><GGG/></FFF></DDD></XXX>
<CCC><DDD/></CCC>
</AAA>
