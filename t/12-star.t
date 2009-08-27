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

@nodes = $e->findnodes( '/AAA/CCC/DDD/*');
ok(@nodes, 4);

@nodes = $e->findnodes( '/*/*/*/BBB');
ok(@nodes, 5);

@nodes = $e->findnodes( '//*');
ok(@nodes, 17);

exit 0;

__DATA__
<AAA>
<XXX><DDD><BBB/><BBB/><EEE/><FFF/></DDD></XXX>
<CCC><DDD><BBB/><BBB/><EEE/><FFF/></DDD></CCC>
<CCC><BBB><BBB><BBB/></BBB></BBB></CCC>
</AAA>
