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
              PREREQ_PM    => {'Test::More' => 0,},
              ($] >= 5.005 ? (AUTHOR => 'Dirk Lindner <lindnerei@o2online.de>') : ()),
              SIGN => 1,
);
