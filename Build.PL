use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Encode::Entity::NCR',
    license             => 'perl',
    dist_author         => 'Uchimata <cheap.sheep.u@gmail.com>',
    dist_version_from   => 'lib/Encode/Entity/NCR.pm',
    requires => {
        'Test::Simple' => 0,
        'Encode'    => 0,
    },
    add_to_cleanup      => [ 'Encode-Entity-NCR-*' ],
);

$builder->create_build_script();
