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

my @nodes;
@nodes = $e->findnodes( '/AAA/XXX/descendant-or-self::*');
ok(@nodes, 8);

@nodes = $e->findnodes( '//CCC/descendant-or-self::*');
ok(@nodes, 4);

exit 0;

__DATA__
<AAA>
<BBB><CCC/><ZZZ><DDD/></ZZZ></BBB>
<XXX><DDD><EEE/><DDD/><CCC/><FFF/><FFF><GGG/></FFF></DDD></XXX>
<CCC><DDD/></CCC>
</AAA>
