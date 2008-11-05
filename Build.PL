use strict;
use Module::Build;
use vars qw($skip);

my $class = Module::Build->subclass(class => "Module::Build::Custom", code => <<'SUBCLASS' );
       use File::Copy;
       use File::Path;
       my $release = 'blib/rhtml/';
       my $dir     = 'httpdocs/';
       my $path    = '.';

       sub ACTION_build {
       my $self = shift;
       $path = $self->{'properties'}{htd};
       &change($dir);
       $self->SUPER::ACTION_build;
       &replacePath('blib/lib/HTML/Menu/TreeView.pm');
       }

       sub change {
       my $d = shift;
       chomp($d);
       opendir(IN, $d) or die "Install failed: $d $!:$/";
       my @files = readdir(IN);
       closedir(IN);
       for(my $i = 0 ; $i <= $#files ; $i++) {
              unless ($files[$i] =~ /^\./) {
              my $c = "$d/$files[$i]";
              my $e = $c;
              $e =~ s/^$dir(.*)/$1/;
              unless (-d $c) {
                     copy($c, "$release/$e") or die "Install failed: $!$c  $release/$e/$files[$i]";
              } else {
                     mkpath("$release/$e") unless (-d "$release/$e");
                     &change("$d/$files[$i]") unless $files[$i] =~ /^\./;
              }
              }
       }
       }

       sub replacePath {
       my $f = shift;
       chmod 0644, $f;
       open(EDIT, "+<$f") or die "replacePath $f $! $/";
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
my $inctance = $class->new(
    get_options => {skip => {store => \$skip},},
    module_name => 'HTML::Menu::TreeView',
    requires    => {
        'Test::More'    => ">=0.7",
        'Module::Build' => ">=0.2808",
#         'perl'				 => '>=5.006000',
    },
    ($] >= 5.005 ? (AUTHOR => 'Dirk Lindner <lze@cpan.org>') : ()),
    dist_abstract      => "Create a HTML TreeView from scratch",
    license            => "lgpl",
    create_makefile_pl => 'passthrough',

    #   sign =>1,
);
# $inctance->{properties}{htd} = "/srv/www/htdocs";
eval 'use HTML::Menu::TreeView qw(documentRoot)';
$inctance->{properties}{htd} = documentRoot() unless $@;
$inctance->{properties}{htd} = $inctance->args('htd') if defined $inctance->args('htd');

unless ($skip) {
    $inctance->{properties}{htd} = Module::Build->prompt("Where is your Document root ?", $inctance->{properties}{htd});
} else {
    print "Document root: $inctance->{properties}{htd}$/";
}
$inctance->{properties}{install_path}{rhtml} = $inctance->{properties}{htd};
$inctance->create_build_script;
