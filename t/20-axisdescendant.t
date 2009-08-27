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
@nodes = $e->findnodes( '/descendant::*');
ok(@nodes, 11);

@nodes = $e->findnodes( '/AAA/BBB/descendant::*');
ok(@nodes, 4);

@nodes = $e->findnodes( '//CCC/descendant::*');
ok(@nodes, 6);

@nodes = $e->findnodes( '//CCC/descendant::DDD');
ok(@nodes, 3);

exit 0;

__DATA__
<AAA>
<BBB><DDD><CCC><DDD/><EEE/></CCC></DDD></BBB>
<CCC><DDD><EEE><DDD><FFF/></DDD></EEE></DDD></CCC>
</AAA>
