#!/usr/bin/perl -w
use CGI;
use HTML::Menu::TreeView;
my $q        = new CGI;
my $TreeView = new HTML::Menu::TreeView();
my @tree = (
		{
		text => 'News',
		columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
		},
		{
		text    => 'Folder',
		columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
		subtree => [
				{
				text => 'News',
				columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
				},
				{
				text    => 'Folder',
				subtree => [
						{
						text    => 'Test',
						columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
						},
					],
				columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
				},
				{
				text => 'Test',
				columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
				},
			],
		},
		{
		text => 'Test',
		columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
		subtree => [
				{
				text => 'Test',
				columns => [' a&#160;', ' b  jjjjj kkkkk llll iiiiiiiii ', ' c ', ' d ', ' e '],
				},
			],
		},
);
 $TreeView->columns("Column1 ","Column2 ","Column3 ","Column4 ","Column5 ");
my $size = defined $q->param('size') ? $q->param('size') : 16;
$TreeView->size($size);
$TreeView->clasic(1) if(defined $q->param('clasic'));
$TreeView->Style($q->param('style')) if(defined $q->param('style'));
my $zoom =
  '<a href="./columns.pl?style=Crystal&amp;size=16" class="treeviewLink">16</a>|<a href="./columns.pl?style=Crystal&amp;size=22" class="treeviewLink" >22</a>|<a href="./columns.pl?style=Crystal&amp;size=32" class="treeviewLink">32</a>|<a href="./columns.pl?style=Crystal&amp;size=48" class="treeviewLink">48</a>|<a href="./columns.pl?style=Crystal&amp;size=64" class="treeviewLink">64</a>|<a href="./columns.pl?style=Crystal&amp;size=128" class="treeviewLink">128</a>|<a href="./columns.pl?style=simple&amp;size=16" class="treeviewLink">Simple</a>';
print $q->header,
$q->start_html(
	-title => 'Columns',
	-script => $TreeView->jscript() . $TreeView->preload(),
	-style => {-code => $TreeView->css()}
),
"$zoom<br/>",
$TreeView->Tree(\@tree),
$q->end_html;

1;
