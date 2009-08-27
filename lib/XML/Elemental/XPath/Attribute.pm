package XML::Elemental::XPath::Attribute;
use strict;

use XML::Elemental::XPath::Namespace;
use XML::Elemental::Util qw(process_name);

sub new {
    return bless {name => $_[1], value => $_[2], parent => $_[3]}, $_[0];
}

sub isDocumentNode              { return 0; }
sub isElementNode               { return 0; }
sub isAttributeNode             { return 1; }
sub isTextNode                  { return 0; }
sub isProcessingInstructionNode { return 0; }
sub isPINode                    { return 0; }
sub isCommentNode               { return 0; }
sub isNamespaceNode             { return 0; }

sub getName {
    my ($local_name, $ns) = process_name($_[0]->{name});
    unless (defined $ns && $ns ne '') {
        my $foo;
        ($foo, $ns) = process_name($_[0]->{parent}->name);
    }
    my $prefix = $_[0]->root->xp->get_namespace($ns);
    return $prefix
      ? "${prefix}:${local_name}"
      : $local_name;    # right thing? what about undef ns?
}

sub getLocalName {
    my ($local_name) = process_name($_[0]->{name});
    return $local_name;
}

sub getPrefix {
    my ($local_name, $ns) = process_name($_[0]->{name});
    unless (defined $ns && $ns ne '') {  # undef or empty means parent namespace
        my $foo;
        ($foo, $ns) = process_name($_[0]->{parent}->name);
    }
    return $_[0]->root->xp->get_prefix($ns);
}

sub getNamespace {
    my ($a, $prefix) = @_;
    my $ns;
    unless (defined $prefix) {           # default to this one.
        my $foo;
        ($foo, $ns) = process_name($_[0]->{name});
        unless (defined $ns && $ns ne '')
        {                                # undef or empty means parent namespace
            ($foo, $ns) = process_name($_[0]->{parent}->name);
        }
    } else {
        $ns = $a->root->xp->get_namespace($prefix);
    }
#    return undef unless defined $ns && $ns ne '';
    return XML::Elemental::XPath::Namespace->new($prefix, $ns);
}

sub getData { return $_[0]->{value}; }

# *getNodeValue = *getData; # necessary?

sub setNodeValue { return $_[0]->{value} = $_[1]; }

sub string_value { return $_[0]->{value}; }
sub toString     { return qq{$_[0]->{name}="$_[0]->{value}"}; }

sub to_number {
    require XML::XPathEngine::Number;
    return XML::XPathEngine::Number->new($_[0]->{value});
}

sub root { $_[0]->{parent}->root }

sub cmp {
    my ($a, $b) = @_;
    if ($b->isa('XML::Elemental::XPath::Attribute')) {
        return $a->parent->cmp($b->parent)
          || $a->getLocalName cmp $b->getLocalName;
    } elsif ($b->isa('XML::Elemental::XPath::Element')) {
        return $a->parent->cmp($b) || 1;
    } elsif ($b->isa('XML::Elemental::XPath::Document')) {
        return 1;
    } else {
        die "unknown node type ", ref($b);
    }
}

1;
