use strict;
use warnings;
package WWW::Sitemapper::Types;
#ABSTRACT: Types used by L<WWW::Sitemapper>.

use URI;
use DateTime;
use DateTime::Duration;

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

=cut

=type tURI

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

=type tDateTime

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


=type tDateTimeDuration

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

1;
