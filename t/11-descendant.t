#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

use Test;
plan( tests => 4);

use XML::Elemental::XPath;

my $x = XML::Elemental::XPath->parser;

ok(1);
my $e = $x->parse_string(join '', <DATA>);
ok($e);

my @bbb = $e->findnodes('//BBB');
ok(@bbb, 5);

my @subbbb = $e->findnodes('//DDD/BBB');
ok(@subbbb, 3);

exit 0;

__DATA__
<AAA>
<BBB/>
<CCC/>
<BBB/>
<DDD><BBB/></DDD>
<CCC><DDD><BBB/><BBB/></DDD></CCC>
</AAA>
