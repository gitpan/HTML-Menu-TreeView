#use lib("../lib");
use HTML::Menu::TreeView qw(css setDocumentRoot jscript setStyle getStyle setDocumentRoot getDocumentRoot);
my @tree =(
	{
	text => '<a href="TreeView.pl" class="link">News</a>',
	dir => [
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
	text => '<a href="TreeView.pl" class="link">News</a>',
	dir => [
		{
			text => 'TreeView',
			href => 'attribute',
			image => "news.gif"
		},
	],
	},
);

use Test::More tests =>5;
my $TreeView = new HTML::Menu::TreeView();
my $js =  $TreeView->jscript();
my $js2 =  jscript();
ok(length($js2) eq length($js));
my $style =  getStyle();
my $TreeView2 = new HTML::Menu::TreeView(\@tree2);
my $style2 = $TreeView2->getStyle();
ok(length($style) eq length($style2));
setStyle("system");
ok($TreeView2->getStyle() eq "system");
$TreeView2->setDocumentRoot("$ENV{PWD}/htdocs");
ok(getDocumentRoot() eq "$ENV{PWD}/htdocs");
ok(length(css()) > 0);
1;
