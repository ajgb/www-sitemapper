use strict;
use warnings;
package WWW::Sitemapper::Tree;
#ABSTRACT: Tree structure of pages.

use Moose;
use WWW::Sitemapper::Types qw( tURI tDateTime );

=attr id

Unique id of the node.

isa: C<Str>.

=cut

has 'id' => (
    is => 'rw',
    isa => 'Str',
    required => 1,
    default => '0',
);

=attr uri

URI object for page. Represents the link found on the web site - before any
redirections.

isa: L<WWW::Sitemapper::Types/"tURI">.

=cut

has 'uri' => (
    is => 'rw',
    isa => tURI,
    required => 1,
);

has '_base_uri' => (
    is => 'rw',
    isa => tURI,
);

=attr title

Title of page.

isa: C<Str>.

=cut

has 'title' => (
    is => 'rw',
    isa => 'Str',
);

=attr last_modified

Value of Last-modified header.

isa: L<WWW::Sitemapper::Types/"tDateTime">.

=cut

has 'last_modified' => (
    is => 'rw',
    isa => tDateTime,
    coerce => 1,
);

=attr nodes

An array of all mapped links found on the page - represented by
L<WWW::Sitemapper::Tree>.

isa: C<ArrayRef[>L<WWW::Sitemapper::Tree>C<]>.

=cut

has 'nodes' => (
    traits => [qw( Array )],
    is => 'rw',
    isa => 'ArrayRef[WWW::Sitemapper::Tree]',
    default => sub { [] },
    handles => {
        children => 'elements',
        add_child => 'push',
    }
);

has '_dictionary' => (
    traits => [qw( Hash )],
    is => 'rw',
    isa => 'HashRef[ScalarRef]',
    default => sub { +{} },
    handles => {
        add_to_dictionary => 'set',
        fast_lookup => 'get',
        all_entries => 'values',
    }
);

has '_redirects' => (
    traits => [qw( Hash )],
    is => 'rw',
    isa => 'HashRef[Ref]',
    default => sub { +{} },
    handles => {
        store_redirect => 'set',
        find_redirect => 'get',
    },
);


=method find_node

    my $mapper = MyWebSite::Map->new(
        site => 'http://mywebsite.com/',
        status_storage => 'sitemap.data',
    );
    $mapper->restore_state();

    my $node = $mapper->tree->find_node( $uri );

Searches the cache for a node with matching uri.

Note: use it only at the root element L<WWW::Sitemapper/"tree">.

=cut

sub find_node {
    my $self = shift;
    my $url = shift;

    if ( my $node = $self->fast_lookup( $url->as_string ) ) {
        return $$node;
    }
    return;
}

=method redirected_from

    my $parent = $mapper->tree->redirected_from( $uri );

Searches the redirects cache for a node with matching uri.

Note: use it only at the root element L<WWW::Sitemapper/"tree">.

=cut

sub redirected_from {
    my $self = shift;
    my $url = shift;

    if ( my $node = $self->find_redirect( $url->as_string ) ) {
        return $$node;
    }
    return;
}

=method add_node

    my $child = $parent->add_node(
        WWW::Sitemapper::Tree->new(
            uri => $uri,
        )
    );

Adds new node to C<$parent> object and returns child with id set.

=cut

sub add_node {
    my $self = shift;
    my $link = shift;

    $link->id( join(':', $self->id, scalar @{ $self->nodes } ) );

    $self->add_child( $link );

    return $link;
}

=method loc
    
    print $node->loc;

Represents the base location of page (which may be different from node
L<"uri"> if there was a redirection).

=cut

sub loc {
    my $self = shift;

    return $self->_base_uri || $self->uri;
}


=method children

    for my $child ( $node->children ) {
        ...
    }

Returns all children of the node.

=cut

1;
