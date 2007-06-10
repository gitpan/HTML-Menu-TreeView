# use 5.008006;
use Getopt::Long;
my $cgi    = undef;
my $htdocs =  undef;
my $prefix =  "/";;
my $result = GetOptions(
	"cgidir=s"  => \$cgi,
	"htdocs=s"  => \$htdocs,
	"prefix=s" =>\$prefix,
);
unless( defined  $cgi && defined  $htdocs  ){
$cgi    = "/srv/www/cgi-bin";
$htdocs = "/srv/www/htdocs";
$prefix = "/";

GOTO:;
print "Where is your Document root($htdocs?)\n";
my $in = <STDIN>;
chomp($in);
$htdocs =  -e $in ? $in :$htdocs;
goto GOTO unless -e $htdocs;
print "Where is your cgi-bin directory ($cgi)?\n";
my $stdin = <STDIN>;
chomp($stdin);
$cgi =  -e $stdin ? $stdin :$cgi;
goto GOTO  unless -e $cgi;

print "Document root: $htdocs \n cgi-bin directory: $cgi \n  You have set up the follow Options, Continue ?\n (Yes/No/exit) default:yes\n";
my $k = <STDIN>;
goto GOTO if($k=~/No/i);
exit if($k=~/exit/i);
}
use lib("./lib");

my $makefile = "
NAME         = HTML-Menu-TreeView
VERSION      = 0.6.6
DISTVNAME    = \$(NAME)-\$(VERSION)
PREFIX       = $prefix
INST_CGI     = blib$cgi
INSTALLCGI   = \$(PREFIX)$cgi

INST_LIB     = blib$cgi
INSTALLLIB   = \$(PREFIX)$cgi

INST_HTDOCS    = blib$htdocs
INSTALLHTDOCS  = \$(PREFIX)$htdocs


UNINST   = 0
VERBINST = 0
#Tools
PERL = /usr/bin/perl
DOINSTALL = \$(PERL) extra/release.pl
RM_D = rm  -R

#dist
TAR = tar
TARFLAGS = cvf
COMPRESS = gzip -9

make:
	@\$(DOINSTALL) -release \$(INST_LIB)     -readdir lib/
	@\$(DOINSTALL) -release \$(INST_HTDOCS)  -readdir htdocs/


clean:
	@\$(RM_D) blib/

manifest :
	\$(PERL) \"-MExtUtils::Manifest=mkmanifest\" -e mkmanifest

dist:
	\$(PERL) \"-MExtUtils::Manifest=manicopy,maniread\" -e \"manicopy(maniread(),'\$(NAME)-\$(VERSION)','best') \";
	\$(TAR) \$(TARFLAGS) \$(NAME)-\$(VERSION)\.tar  \$(NAME)-\$(VERSION)
	@\$(RM_D \$(NAME)-\$(VERSION)
	\$(COMPRESS) \$(NAME)-\$(VERSION).tar

disttest :
	cd \$(DISTVNAME) && \$(PERL) Makefile.PL
	cd \$(DISTVNAME) && \$(MAKE)
	cd \$(DISTVNAME) && \$(MAKE) test

distclean :
	@\$(RM_D) \$(DISTVNAME)

install ::
	@\$(DOINSTALL) -release \$(PREFIX) -readdir blib/

installdocs ::
	\$(PERL) extra/Treenavi.pl -htdocs \$(INSTALLHTDOCS) 
	rm pod2htmd.tmp
	rm pod2htmi.tmp


uninstall ::
	@\$(RM_D) \$(INSTALLLIB)/HTML/Menu/TreeView.pm
	@\$(RM_D) \$(INSTALLHTDOCS)/style

uninstalldocs ::
	rm \$(INSTALLHTDOCS)/TreeView.html
	rm \$(INSTALLHTDOCS)/Treenavi.html
	rm \$(INSTALLHTDOCS)/html-menu-treeview.html

TEST_VERBOSE=0
TEST_FILES = t/*.t

test ::
	\$(PERL) \"-MExtUtils::Command::MM\" \"-e\" \"test_harness(\$(TEST_VERBOSE), '\$(INST_LIB)')\" \$(TEST_FILES)
";
open  OUT, ">./Makefile"  or die " $!\n";
print OUT $makefile;
close OUT;