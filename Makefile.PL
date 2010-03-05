use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Encode::Entity::NCR',
    AUTHOR              => 'Uchimata <cheap.sheep.u@gmail.com>',
    VERSION_FROM        => 'lib/Encode/Entity/NCR.pm',
    ABSTRACT_FROM       => 'lib/Encode/Entity/NCR.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::Simple' => 0,
        'Encode'       => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Encode-Entity-NCR-*' },
);
