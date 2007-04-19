#use lib("../lib");
use HTML::Menu::TreeView qw(Tree);
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

my $TreeView = new HTML::Menu::TreeView();
my $tree =  $TreeView->Tree(\@tree);
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

use Test::More tests =>3;
my $tree2 =  Tree(\@tree);
ok(length($tree2) eq length($tree));
my $tree3 =  Tree(\@tree2);
ok(length($tree3) < length($tree));
my $TreeView2 = new HTML::Menu::TreeView(\@tree2,$style);
my $tree4 = $TreeView2->Tree();
ok(length($tree3) == length($tree4));
1;