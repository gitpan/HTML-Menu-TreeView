#!/usr/bin/perl -w
use CGI;
use HTML::Menu::TreeView;
use strict;
my $cgi           = new CGI;
my $TreeView      = new HTML::Menu::TreeView;
my $serversubtree = './';
my $style         = $cgi->param('style') ? $cgi->param('style') : "Crystal";
my $folderfirst   = $TreeView->folderFirst();
my $changeState   = $cgi->param('folderFirst') ? 0 : 1;
my $sort          = $cgi->param('sort') ? 0 : 1;
my $isSorted      = $TreeView->sortTree();
$TreeView->folderFirst($cgi->param('folderFirst') ? 1 : 0);
$TreeView->sortTree($cgi->param('sort')           ? 1 : 0);
$TreeView->style($style);
my @tree = (
		{
		text => 'Folderfirst',
		href => "./folderFirst.pl?folderFirst=$changeState&amp;sort=$isSorted",
		},
		{
		text => 'Sort',
		href => "./folderFirst.pl?folderFirst=$folderfirst&amp;sort=$sort",
		},
		{
		text => 'Kontakt',
		href => 'mailto:dirk.lindner@gmx.de',
		},
		{
		text => 'Treeview.pm',
		href => '/html-menu-treeview.html',
		onclick => '',
		subtree => [
				{
				text => 'Source Code',
				href => 'treeviewsource.pl',
				},
			],
		},
		{
		text => 'Examples',
		subtree => [
				{
				text => 'OO Syntax',
				href => 'oo.pl',
				},
				{
				text => 'FO Syntax',
				href => './fo.pl',
				},
				{
				text => 'Crystal',
				href => './crystal.pl',
				},
			],
		},
		{
		text    => 'Related Sites',
		subtree => [
				{
				text => 'search.cpan.org',
				href => 'http://search.cpan.org/dist/HTML-Menu-TreeView/',
				target => '_parent',
				},
				{
				text => 'Forum',
				href => 'http://www.cpanforum.com/dist/HTML-Menu-TreeView/',
				target => '_parent',
				},
				{
				text => 'Subversion',
				href => 'http://treeview.tigris.org/',
				target => '_parent',
				},
				{
				text => 'Lindnerei.de',
				href => 'http://www.lindnerei.de',
				target => '_parent',
				},
				{
				text => 'Treeview.pm',
				href => 'http://treeview.lindnerei.de/',
				subtree => [
						{
						text => 'Source Code',
						href => 'treeviewsource.pl',
						},
					],
				},
				{
				text    => 'Examples',
				subtree => [
					{
					text => 'OO Syntax',
					href => 'oo.pl',
					},
					{
					text => 'FO Syntax',
					href => './fo.pl',
					},
					{
					text => 'Crystal',
					href => './crystal.pl',
					},
				],
				},
			]
		},
		{
		text => 'Kontakt',
		href => 'mailto:dirk.lindner@gmx.de',
		}
);
print $cgi->header,
$cgi->start_html(
	-title => 'Print Folders First',
	-script => $TreeView->jscript() . $TreeView->preload(),
	-style => {-code => $TreeView->css()}
),
$TreeView->Tree(\@tree),
$cgi->end_html;

