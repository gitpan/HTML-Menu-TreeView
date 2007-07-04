#use lib("../lib");
use HTML::Menu::TreeView qw(:all);
my @tree =(
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

use Test::More tests =>2;
my $TreeView = new HTML::Menu::TreeView();
my $js =  $TreeView->jscript();
my $js2 =  jscript();
ok(length($js2) eq length($js));
my $TreeView2 = new HTML::Menu::TreeView(\@tree);
my $t1 = Tree(\@tree);
my $t2 = $TreeView2->Tree();
ok(length($t1) eq length($t2));
1;