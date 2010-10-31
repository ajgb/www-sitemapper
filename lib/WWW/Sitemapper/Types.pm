
package WWW::Sitemapper::Types;

=encoding utf8

=head1 NAME

WWW::Sitemapper::Types - types used by L<WWW::Sitemapper>.

=cut

use strict;
use warnings;
use URI;
use DateTime;
use DateTime::Duration;

our $VERSION = '0.04';

use MooseX::Types -declare => [qw(
    tURI
    tDateTime
    tDateTimeDuration
)];

use MooseX::Types::Moose qw(
    Str
    Int
    Num
);

=head1 SYNOPSIS

    use WWW::Sitemapper::Types qw( tURI tDateTime tDateTimeDuration );

=head1 TYPES

=head2 tURI

    has 'uri' => (
        is => 'rw',
        isa => tURI,
        coerce => 1,
    );

L<URI> object.

Coerces from C<Str> via L<URI/new>.

=cut

class_type tURI, { class => 'URI' };

coerce tURI,
    from Str,
        via { URI->new( $_, 'http' ) };

=head2 tDateTime

    has 'datetime' => (
        is => 'rw',
        isa => tDateTime,
        coerce => 1,
    );

L<DateTime> object.

Coerces from C<Int> via L<DateTime>-E<gt>from_epoch( epoch => $_ ).

=cut

class_type tDateTime, { class => 'DateTime' };

coerce tDateTime,
    from Int,
        via { DateTime->from_epoch( epoch => $_ ) };


=head2 tDateTimeDuration

    has 'datetimeduration' => (
        is => 'rw',
        isa => tDateTimeDuration,
        coerce => 1,
    );

L<DateTime::Duration> object.

Coerces from C<Num> via L<DateTime::Duration>-E<gt>new( minutes => $_ ).

=cut


class_type tDateTimeDuration, { class => 'DateTime::Duration' };

coerce tDateTimeDuration,
    from Num,
        via { DateTime::Duration->new( minutes => $_ ) };



=head1 AUTHOR

Alex J. G. Burzyński, E<lt>ajgb@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Alex J. G. Burzyński

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.


=cut

1;
