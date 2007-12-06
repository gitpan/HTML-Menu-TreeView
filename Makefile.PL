use ExtUtils::MakeMaker;
use strict;
my $htd = "/srv/www/httpdocs";
eval 'use HTML::Menu::TreeView qw(documentRoot)';
$htd = documentRoot() unless $@;
$htd = prompt("Where is your Document root ?", $htd);
my @scripts = qw();
WriteMakefile(
        NAME          => 'HTML::Menu::TreeView',
        VERSION_FROM  => 'lib/HTML/Menu/TreeView.pm',
        INSTALLDIRS   => 'perl',
        INSTALLBIN    => $htd,
        INSTALLSCRIPT => $htd,
        PL_FILES      => {'extra/release.pl' => "-release blib/bin  -readdir httpdocs/ -htpath $htd"},
        PREREQ_PM     => {'Test::More' => 0,'Test::Signature' => 1.10},
        ($] >= 5.005 ? (AUTHOR => 'Dirk Lindner <lindnerei@o2online.de>') : ()),

                      SIGN => 1,
);
