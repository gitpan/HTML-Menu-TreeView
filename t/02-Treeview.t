#use lib("../lib");
use HTML::Menu::TreeView qw(css setDocumentRoot jscript setStyle getStyle setDocumentRoot getDocumentRoot);
my @tree =(
	{
	text => 'News',
	href => 'TreeView.pl',
	subtree => [
		{
			text => 'TreeView',
			href => 'attribute',
			image => "news.gif"
		},
	],
	},
	{
		text => "Help",
		onclick => 'attribute',
		image =>"help.gif"
	},
);
my @tree2 =(
	{
	text => 'News',
	href => 'TreeView.pl',
	subtree => [
		{
			text => 'TreeView',
			href => 'attribute',
			image => "news.gif",
		},
	],
	},
);
use Cwd;
my $path = getcwd;
use Test::More tests =>5;
my $TreeView = new HTML::Menu::TreeView();
my $js =  $TreeView->jscript();
my $js2 =  jscript();
ok(length($js2) eq length($js));
my $style =  getStyle();
my $TreeView2 = new HTML::Menu::TreeView(\@tree2);
my $style2 = $TreeView2->getStyle();
ok(length($style) eq length($style2));
setStyle("Crystal");
ok($TreeView2->getStyle() eq "Crystal");
$TreeView2->setDocumentRoot("$path/htdocs");
ok(getDocumentRoot() eq "$path/htdocs");
ok(length(css()) > 0);
1;