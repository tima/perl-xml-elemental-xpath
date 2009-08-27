package XML::XPathEngine::Elemental;
use warnings;
use strict;

use base 'XML::XPathEngine';

sub get_prefix {
    my ($self, $ns) = @_;
    return $self->{xpath_prefix}->{$ns} || '';
}

sub set_namespace {
    $_[0]->{xpath_ns}->{$_[1]}     = $_[2];
    $_[0]->{xpath_prefix}->{$_[2]} = $_[1];
}

sub clear_namespaces {
    $_[0]->{xpath_ns}     = {};
    $_[0]->{xpath_prefix} = {};
}

sub get_namespace {
    my ($self, $prefix) = @_;
    return $self->{xpath_ns}->{$prefix} || '';
}

sub get_namespaces {
    my @ns_nodes;
    require XML::Elemental::XPath::Namespace;
    for my $prefix (keys %{$_[0]->{xpath_ns}}) {
        push @ns_nodes,
          XML::Elemental::XPath::Namespace->new($prefix,
            $_[0]->{xpath_ns}->{$prefix});
    }
    return wantarray ? @ns_nodes : \@ns_nodes;
}

1;
