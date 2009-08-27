package XML::Elemental::XPath::Characters;
use strict;
use base 'XML::Elemental::Characters';

sub isDocumentNode              { return 0; }
sub isElementNode               { return 0; }
sub isAttributeNode             { return 0; }
sub isTextNode                  { return 1; }
sub isProcessingInstructionNode { return 0; }
sub isPINode                    { return 0; }
sub isCommentNode               { return 0; }
sub isNamespaceNode             { return 0; }

*getRootNode   = *XML::Elemental::Characters::root;
*getParentNode = *XML::Elemental::Characters::parent;
*string_value  = *XML::Elemental::Characters::data;
*getValue      = *XML::Elemental::Characters::data;
*getData       = *XML::Elemental::Characters::data;

sub getChildNodes { return wantarray ? () : []; }    # necessary?
sub getFirstChild { }
sub getLastChild  { }
sub getNextSibling     { $_[0]->parent->find_after($_[0]); }
sub getPreviousSibling { $_[0]->parent->find_before($_[0]); }

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

sub appendText { return $_[0]->data($_[0]->data . $_[1]) }    # necessary?

sub getAttributes { return wantarray ? () : []; }             # necessary?

sub cmp {
    my ($a, $b) = @_;
    return 0  if $a == $b;
    return 1  if $a->in_element($b);
    return -1 if $b->in_element($a);
    my @branch_a = ($a, $a->ancestors);
    my @branch_b = ($b, $b->ancestors);
    return undef unless $branch_a[-1] == $branch_b[-1];       # different doc
    my ($ancestor_a, $ancestor_b)
      ;    # find the first ancestors that is not shared -- they are siblings.

    while ($ancestor_a == $ancestor_b) {
        $ancestor_a = pop @branch_a;
        $ancestor_b = pop @branch_b;
    }
    for my $n (@{$ancestor_a->parent->contents}) {
        return 1  if $n == $ancestor_a;
        return -1 if $n == $ancestor_b;
    }
    return undef;    # this should never happen.
}

#--- xpath operations

sub findnodes { return $_[0]->root->xp->findnodes($_[1], $_[0]); }

sub findnodes_as_string {
    return $_[0]->root->xp->findnodes_as_string($_[1], $_[0]);
}
sub findvalues { return $_[0]->root->xp->findvalues($_[1], $_[0]); }
sub exists { return $_[0]->root->xp->exists($_[1], $_[0]); }
sub find { return $_[0]->root->xp->find($_[1], $_[0]); }

sub matches {
    my ($e, $path, $node) = @_;
    $node ||= $e;
    return $e->root->xp->matches($node, $path, $e) || 0;
}

1;
