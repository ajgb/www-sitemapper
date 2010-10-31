use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WWW::Sitemapper',
    license             => 'perl',
    dist_author         => q{Alex J. G. Burzyński <ajgb@cpan.org>},
    dist_version_from   => 'lib/WWW/Sitemapper.pm',
    build_requires => {
        'Test::More' => 0,
        'Test::NoWarnings' => 0,
        'Test::Exception' => 0,
        'Moose' => 0.98,
        'URI' => 1.37,
        'WWW::Robot' => 0.026,
        'Storable' => 2.18,
        'DateTime' => 0.53,
        'MooseX::Types' => 0.21,
        'MooseX::MethodAttributes::Inheritable' => 0.20, 
        'LWP' => 5.831,
        'HTML::HeadParser' => 3.60,
        'DateTime' => 0.53,
        'Template' => 2.22,
        'Search::Sitemap' => 2.10,
    },
    add_to_cleanup      => [ 'WWW-Sitemapper-*' ],
    create_makefile_pl => 'traditional',
    create_licence => 1,
);

$builder->create_build_script();
