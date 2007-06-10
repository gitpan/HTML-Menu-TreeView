use lib qw(./lib);
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use HTML::Menu::TreeView qw(Tree jscript setStyle setDocumentRoot setSize setClasic);
# use 5.008006;
use Getopt::Long;
my $htdocs = "/srv/www/htdocs";
my $cgi           = new CGI;
my $style         = "Crystal";
my $prefix = "/";
my $size = 16;
my $result = GetOptions(
	"htdocs=s"  => \$htdocs,
	"style=s" =>\$style,
	"size=s" =>\$size,
);
use strict;
my $serversubtree = './';
my @t             = (
	{
	text    => 'Treeview.pm',
	href    => '/html-menu-treeview.html',
	target  => 'rightFrame',
	folderclass => 'folderOrange',
	subtree => [openTree(),],
	},
	{
	text   => 'Subversion',
	href   => 'http://treeview.tigris.org/',
	target => '_parent',
	image => 'deb.png'
	},
{
	text   => 'Treeview Homepage',
	href   => 'http://treeview.lindnerei.de/',
	target => '_parent',
},
);
setDocumentRoot($htdocs);
setStyle($style);
setSize($size);

open OUT , ">$htdocs/Treenavi.html" or die "$!";
print OUT "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
<title>Navigation</title>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/style/$style/$size/html-menu-treeview/$style.css\">
<script language=\"JavaScript\" type=\"text/javascript\">
//<!--
" . jscript() . '
//-->
</script>
</head>
<body>
<table align="center" class="mainborder" cellpadding="0"  cellspacing="0" summary="mainLayout" width="100%" ><tr><td align="center" >' . Tree(\@t).'</select><br><p></td></tr></table></body></html>';
close(OUT);
open FRAME , ">$htdocs/TreeView.html" or die "$!";
print FRAME  '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>Html::Menu::TreeView</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="robots" content="index">
<meta name="keywords" lang="de" content="Html::Menu::TreeView Treeview Treeview.pm Treeview.html">
</head>
<frameset cols="300,*">
<frame src="/Treenavi.html" name="navi">
<frame src="/html-menu-treeview.html" name="rightFrame">
</frameset>
</html>';
close(FRAME);

sub openTree {
    my @TREEVIEW;
    system("pod2html --noindex --title=Treeview.pm --infile=lib/HTML/Menu/TreeView.pm  --outfile=$htdocs/html-menu-treeview.html");
    use Fcntl qw(:flock);
    use Symbol;
    my $fh   = gensym;
    my $file = "$htdocs/html-menu-treeview.html";
    open $fh, "$file" or die "$!: $file";
    seek $fh, 0, 0;
    my @lines = <$fh>;
    close $fh;
    for(@lines) {
        if($_ =~ /<a href="#([^"]+)">(.+)<\/a>/) {
            push @TREEVIEW,
              {
                text   => "$2",
                href   => "/html-menu-treeview.html#$1",
                target => 'rightFrame',
              };
        }
    }
    return @TREEVIEW;
}
