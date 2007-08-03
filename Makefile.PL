use ExtUtils::MakeMaker;
use strict;
my $htd = "/srv/www/httpdocs";
$htd = prompt("Where is your Document root ?", $htd);

WriteMakefile(
        NAME         => 'HTML::Menu::TreeView',
        VERSION_FROM => 'lib/HTML/Menu/TreeView.pm',
        INSTALLDIRS  => 'perl',
        INSTALLBIN   => "$htd",
        PL_FILES     => {'extra/release.pl' => "-release blib/bin  -readdir httpdocs/ -htpath $htd"},
        PREREQ_PM    => {'Module::Signature' => 0.55, 'Data::Dumper' => 2.121_08, 'Pod::Escapes' => 1.04, 'Test::Pod' => 1.26, 'Pod::Coverage' => 0.18, 'Test::Pod::Coverage' => 1.08,},
        ($] >= 5.005 ? (AUTHOR => 'Dirk Lindner <lindnerei@o2online.de>') : ()),

        #               SIGN => 1,
);
