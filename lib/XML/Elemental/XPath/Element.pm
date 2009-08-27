package XML::Elemental::XPath::Element;
use strict;
use base 'XML::Elemental::Element';

use XML::Elemental::XPath::Namespace;
use XML::Elemental::Util qw(process_name);

sub isDocumentNode              { return 0; }
sub isElementNode               { return 1; }
sub isAttributeNode             { return 0; }
sub isTextNode                  { return 0; }
sub isProcessingInstructionNode { return 0; }
sub isPINode                    { return 0; }
sub isCommentNode               { return 0; }
sub isNamespaceNode             { return 0; }

*getRootNode     = *XML::Elemental::Node::root;        # element inherits this
*getParentNode   = *XML::Elemental::Element::parent;
*getExpandedName = *XML::Elemental::Element::name;     # right thing?
*string_value = *XML::Elemental::Element::text_content;

sub getName {
    my ($local_name, $ns) = process_name($_[0]->name);
    my $prefix = $_[0]->root->xp->get_prefix($ns);
    return $prefix
      ? "${prefix}:${local_name}"
      : $local_name;    # right thing? what about undef ns?
}

sub getLocalName {
    my ($local_name) = process_name($_[0]->name);
    return $local_name;
}

# use Data::Dumper;

sub getPrefix {
    my ($local_name, $ns) = process_name($_[0]->name);
    warn $_[0]->root->xp->get_prefix($ns);
    return $_[0]->root->xp->get_prefix($ns);
}

sub getNamespace {
    my ($e, $prefix) = @_;
    my $ns;
    unless (defined $prefix) {    # default to this one.
        (my $x, $ns) = process_name($e->name);
        $prefix = $e->root->xp->get_namespace($ns);

    } else {
        $ns = $e->root->xp->get_namespace($prefix);
    }
    return XML::Elemental::XPath::Namespace->new($prefix, $ns);
}

sub getNamespaces { return $_[0]->root->xp->get_namespaces; }

sub getChildNodes { return wantarray ? @{$_[0]->contents} : $_[0]->contents; }
sub getChildNode  { return $_[0]->contents->[$_[1]] }
sub appendChild   { push @{$_[0]->contents}, $_[1] }    # necessary?
sub getFirstChild { return $_[0]->contents->[0] }
sub getLastChild  { return $_[0]->contents->[-1] }

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

# sub getAttribute { }    # using prefix. necessary?

sub getAttributes {
    my $e = shift;
    my %a = %{$e->attributes};
    require XML::Elemental::XPath::Attribute;
    my @a = map {
        bless {name => $_, value => $a{$_}, parent => $e,},
          'XML::Elemental::XPath::Attribute'
    } sort keys %a;
    return wantarray ? @a : \@a;
}

# *getAttributeNodes = *getAttributes;

sub toString {
    return ''                   unless defined $_[0]->{contents};
    return $_[0]->text_contents unless $_[1];                       # recurse
    return                                                          # no recurse
      join('', map { $_->data }
             grep { $_->can('data') } @{$_[0]->contents});
}

sub to_number {
    require XML::XPathEngine::Number;
    return XML::XPathEngine::Number->new($_[0]->string_value);
}

sub cmp {
    my ($a, $b) = @_;
    return 0  if $a == $b;
    return 1  if $a->in_element($b);
    return -1 if $b->in_element($a);
    my @branch_a = ($a, $a->ancestors);
    my @branch_b = ($b, $b->ancestors);
    return undef unless $branch_a[-1] == $branch_b[-1];    # different doc

    # find the first ancestors that is not shared -- they are siblings.
    my $ancestor_a = pop @branch_a;
    my $ancestor_b = pop @branch_b;
    while ($ancestor_a == $ancestor_b) {
        $ancestor_a = pop @branch_a;
        $ancestor_b = pop @branch_b;
    }
    for my $n (@{$ancestor_a->parent->contents}) {
        return -1 if $n == $ancestor_a;
        return 1  if $n == $ancestor_b;
    }
    return undef;    # this should never happen.
}

#--- xpath operations

sub findnodes { return $_[0]->root->xp->findnodes($_[1], $_[0]); }

sub findnodes_as_string {
    return $_[0]->root->xp->findnodes_as_string($_[1], $_[0]);
}
sub findvalue { return $_[0]->root->xp->findvalue($_[1], $_[0]); }
sub exists { return $_[0]->root->xp->exists($_[1], $_[0]); }
sub find { return $_[0]->root->xp->find($_[1], $_[0]); }

sub matches {
    my ($e, $path, $node) = @_;
    $node ||= $e;
    return $e->root->xp->matches($node, $path, $e) || 0;
}

1;

__END__

sub node_cmp {
    my ($a, $b) = @_;
    if ($b->isa('XML::Elemental::XPath::Element')) {
        return $a->cmp($b);
    } elsif ($b->isa('XML::Elemental::XPath::Attribute')) {
        return $a->cmp($b->parent) || -1;
    } elsif ($b->isa('XML::Elemental::XPath::Document')) {
        return 1;
    } else {
        die "unknown node type ", ref($b);
    }
}
*cmp=*node_cmp;

