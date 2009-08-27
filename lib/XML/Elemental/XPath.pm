package XML::Elemental::XPath;
use strict;

use base 'XML::Elemental';

use vars qw($VERSION);
$VERSION = '0.01';

my $classes = {
               Document   => 'XML::Elemental::XPath::Document',
               Element    => 'XML::Elemental::XPath::Element',
               Characters => 'XML::Elemental::XPath::Characters',
};

sub parser { return $_[0]->SUPER::parser($classes); }

__END__

sub path # utility?
  { my $elt= shift;
    my @context= ( $elt, $elt->ancestors);
    return "/" . join( "/", reverse map {$_->gi} @context);
  }
  
# No unique ID handling.

