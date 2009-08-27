use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		 => 'XML::Elemental::XPath',
    'VERSION_FROM'	 => 'lib/XML/Elemental/XPath.pm',
    'PREREQ_PM'		 => { 
        XML::Elemental   =>2.1, 
        XML::XPathEngine =>0.11,
	Test             =>0,
        Test::More       =>0,
    }
);
