use ExtUtils::MakeMaker;
use strict;
my $htd =  "/srv/www/htdocs";
$htd = prompt("Where is your Document root ?" ,$htd);

WriteMakefile(
    NAME              => 'HTML::Menu::TreeView',
    VERSION_FROM      => 'lib/HTML/Menu/TreeView.pm', # finds $VERSION
    INSTALLDIRS => 'perl',
    INSTALLBIN => "\$(PERLPREFIX)$htd",
   PL_FILES => {'extra/release.pl' =>"-release blib/bin  -readdir htdocs/"},
#     PREREQ_PM         => {"Module::Signature" => 0.55}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (AUTHOR         => 'Dirk Lindner <lindnerei@o2online.de>') : ()),
#     'NO_META' => 1,
    SIGN => 1,
#     NOECHO => '',
);