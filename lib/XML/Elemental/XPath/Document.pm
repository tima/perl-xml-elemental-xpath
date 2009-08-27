package XML::Elemental::XPath::Document;
use strict;
use base 'XML::Elemental::Document';

# feeling around in the dark on this one.

sub isDocumentNode              { return 1; }
sub isElementNode               { return 1; }
sub isAttributeNode             { return 0; }
sub isTextNode                  { return 0; }
sub isProcessingInstructionNode { return 0; }
sub isPINode                    { return 0; }
sub isCommentNode               { return 0; }
sub isNamespaceNode             { return 0; }

sub getRootNode   { return $_[0]; }
sub getAttributes { return wantarray ? () : []; }
sub getValue      { return $_[0]->root_element->text_content; }
sub getParentNode { return undef; }
sub getName       { return undef; }
sub getNamespace  { }
sub getLocalName  { }

sub getChildNodes {
    return wantarray ? $_[0]->root_element : [$_[0]->root_element];
}

sub to_number {
    require XML::XPathEngine::Number;
    return XML::XPathEngine::Number->new($_[0]->root_element->text_content);
}

sub cmp { return $_[1] == $_[0] ? 0 : -1; }

{
    my $xp;

    sub xp {
        require XML::XPathEngine::Elemental;
        $xp ||= XML::XPathEngine::Elemental->new();
        $XML::XPathEngine::Namespaces = 1;
        $xp->set_namespace('xml',   'http://www.w3.org/XML/1998/namespace');
        $xp->set_namespace('xmlns', 'http://www.w3.org/2000/xmlns/');
        $xp->set_strict_namespaces(1);
        return $xp;
    }
}

sub find_before {
    my ($self, $child) = @_;
    my $before;
    for my $kid (@{$self->contents}) {
        return $before if $before and $kid eq $child;
        $before = $kid;
    }
    return;
}

sub find_after {
    my ($self, $child) = @_;
    my $after;
    my @kids = @{$self->contents || []};
    while (my $kid = shift @kids) {
        return shift @kids if $kid eq $child;
    }
    return;
}

sub first_elt { return $_[0]->root_element; }

#--- xpath operations

sub findnodes { return $_[0]->xp->findnodes($_[1], $_[0]); }

sub findnodes_as_string {
    return $_[0]->xp->findnodes_as_string($_[1], $_[0]);
}
sub findvalue { return $_[0]->xp->findvalue($_[1], $_[0]); }
sub exists { return $_[0]->xp->exists($_[1], $_[0]); }
sub find { return $_[0]->xp->find($_[1], $_[0]); }

sub matches {
    my ($e, $path, $node) = @_;
    $node ||= $e;
    return $e->xp->matches($node, $path, $e) || 0;
}

1;
