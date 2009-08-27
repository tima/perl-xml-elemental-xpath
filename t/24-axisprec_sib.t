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
@nodes = $e->findnodes( '/AAA/XXX/preceding-sibling::*');
ok(@nodes, 1);
ok($nodes[0]->getName, "BBB");

@nodes = $e->findnodes( '//CCC/preceding-sibling::*');
ok(@nodes, 4);

@nodes = $e->findnodes( '/AAA/CCC/preceding-sibling::*[1]');
ok($nodes[0]->getName, "XXX");

@nodes = $e->findnodes( '/AAA/CCC/preceding-sibling::*[2]');
ok($nodes[0]->getName, "BBB");

exit 0;

__DATA__
<AAA>
    <BBB>
        <CCC/>
        <DDD/>
    </BBB>
    <XXX>
        <DDD>
            <EEE/>
            <DDD/>
            <CCC/>
            <FFF/>
            <FFF>
                <GGG/>
            </FFF>
        </DDD>
    </XXX>
    <CCC>
        <DDD/>
    </CCC>
</AAA>
