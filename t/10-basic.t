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

my @root = $e->findnodes('/AAA');
ok(@root, 1);

my @ccc = $e->findnodes('/AAA/CCC');
ok(@ccc, 3);

my @bbb = $e->findnodes('/AAA/DDD/BBB');
ok(@bbb, 2);

exit 0;

__DATA__
<AAA>
    <BBB/>
    <CCC/>
    <BBB/>
    <CCC/>
    <BBB/>
    <!-- comment -->
    <DDD>
        <BBB/>
        Text
        <BBB/>
    </DDD>
    <CCC/>
</AAA>
