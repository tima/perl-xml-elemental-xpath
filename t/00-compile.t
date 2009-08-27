my $loaded;
BEGIN { print "1..1\n" }
use XML::Elemental::XPath::Attribute;
use XML::Elemental::XPath::Characters;
use XML::Elemental::XPath::Document;
use XML::Elemental::XPath::Element;
use XML::Elemental::XPath::Namespace;
use XML::Elemental::XPath;
use XML::XPathEngine::Elemental;
$loaded++;
print "ok 1\n";
END { print "not ok 1\n" unless $loaded }
