use ExtUtils::MakeMaker;
use strict;

WriteMakefile(
    'NAME'             => 'XML::Elemental::XPath',
    'VERSION_FROM'     => 'lib/XML/Elemental/XPath.pm',
    'ABSTRACT_FROM'    => 'lib/XML/Elemental/XPath.pm',
    'MIN_PERL_VERSION' => '5.008001',
    'LICENSE'          => 'perl',
    'AUTHOR'           => 'Timothy Appnel <tima@cpan.org>',
    'PREREQ_PM'        => {
        'XML::Elemental'   =>2.1, 
        'XML::XPathEngine' =>0.11,
		'Test'             =>0,
        'Test::More'       =>0,
    },
    'META_MERGE'       => {
        'resources' => {
            'license'    => 'http://dev.perl.org/licenses/',
            'repository' => 'http://github.com/tima/perl-xml-elemental-xpath',
            #'bugtracker' =>
            #  'http://rt.cpan.org/Public/Dist/Display.html?Name=XML-Elemental-XPath',
        },
    },
);
