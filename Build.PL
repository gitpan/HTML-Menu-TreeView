use strict;
use Module::Build;
my $class = Module::Build->subclass(class => "Module::Build::Custom", code => <<'SUBCLASS' );
my $release = 'blib/html/';
my $dir     = 'httpdocs/';
my $path = '.';
sub ACTION_build {
my $self = shift;
&change($dir);
# &replacePath('blib/lib/HTML/Menu/TreeView.pm');
$self->SUPER::ACTION_build;
}
sub change {
my $d = shift;
chomp($d);
opendir(IN, $d) or warn "cant open $d $!:$/";
my @files = readdir(IN);
closedir(IN);
for(my $i = 0 ; $i <= $#files ; $i++) {
unless ($files[$i] =~ /^\./) {
my $c = $d . $files[$i];
my $e = $c;
$e =~ s/^$dir(.*)/$1/;
unless (-d $d . $files[$i]) {
system(" cp " . $c . " $release/$e") unless (-e $release . "/" . $e && $files[$i] =~ /\~$/);
} else {
system("mkdir -p $release/$e") unless (-e $release . "/" . $e);
&change($d . $files[$i] . "/");
}
}
}
}
sub replacePath {
my $f = shift;
chmod 0644, $f;
open(EDIT, "+<$f") or die "$! $/";
my $file = '';
while(<EDIT>) {
s/%PATH%/$path/;
$file .= $_;
}
seek(EDIT, 0, 0);
print EDIT $file;
truncate(EDIT, tell(EDIT));
close(EDIT);
}
SUBCLASS
my $htd = "/srv/www/httpdocs";
my $prefix;
$prefix = $1 if "@ARGV"=~/--prefix (\S+)/ ;
eval 'use HTML::Menu::TreeView qw(documentRoot)';
$htd = documentRoot() unless $@;
$htd =  Module::Build->prompt("Where is your Document root ?", $htd);
$class->new(
module_name => 'HTML::Menu::TreeView',
requires => {
'Test::More' => 0,
'Test::Signature' => 1.10,
'Module::Build' => 0.2808,
'Test::Pod::Coverage' => 0.55,
'Test::Pod' => 1.00,
},
($] >= 5.005 ? (AUTHOR => 'Dirk Lindner <lindnerei@o2online.de>') : ()),
dist_abstract => "Tool for Building a HTML TreeView",
license => "lgpl",
install_path => { html => $prefix.$htd },
create_makefile_pl => 'passthrough',
sign => 1,
)->create_build_script;
