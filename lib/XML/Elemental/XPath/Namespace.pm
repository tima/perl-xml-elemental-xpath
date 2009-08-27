package XML::Elemental::XPath::Namespace;
use strict;

sub new {
    my ($class, $prefix, $uri) = @_;
    bless {prefix => $prefix, uri => $uri}, $class;
}

sub isDocumentNode              { return 0; }
sub isElementNode               { return 0; }
sub isAttributeNode             { return 0; }
sub isTextNode                  { return 0; }
sub isProcessingInstructionNode { return 0; }
sub isPINode                    { return 0; }
sub isCommentNode               { return 0; }
sub isNamespaceNode             { return 1; }

sub getPrefix    { return $_[0]->{prefix}; }
sub getExpanded  { return $_[0]->{uri}; }
sub getValue     { return $_[0]->{uri}; }
sub getData      { return $_[0]->{uri}; }
sub string_value { return $_[0]->{uri}; }

1;

__END__

sub toString {
	my $self = shift;
	my $string = '';
	return '' unless defined $self->[node_expanded];
	if ($self->[node_prefix] eq '#default') {
		$string .= ' xmlns="';
	}
	else {
		$string .= ' xmlns:' . $self->[node_prefix] . '="';
	}
	$string .= XML::XPath::Node::XMLescape($self->[node_expanded], '"&<');
	$string .= '"';
}
