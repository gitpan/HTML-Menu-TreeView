#!/usr/bin/perl -W
use CGI;
use CGI::Carp qw(fatalsToBrowser);
use HTML::Menu::TreeView qw(Tree jscript style documentRoot size preload folderFirst);
use strict;
my $cgi           = new CGI;
my $style         = $cgi->param('style') ? $cgi->param('style') : "Crystal";
my $serversubtree = './';
my $size          = defined $cgi->param('size') ? $cgi->param('size') : 16;
size($size);
my $htpath   = "../httpdocs/";
my $treeview = new HTML::Menu::TreeView;
$treeview->documentRoot($htpath);
my $changeState = $cgi->param('folderFirst') ? 0 : 1;
$treeview->folderFirst($cgi->param('folderFirst') ? 1 : 0);
$treeview->sortTree($cgi->param('sort')           ? 1 : 0);
$treeview->style($style);
my $folderfirst = $treeview->folderFirst();
my $sort        = $cgi->param('sort') ? 0 : 1;
my $isSorted    = $treeview->sortTree();
my @t = (
         {text => 'Folderfirst', href    => "./folderFirst.pl?folderFirst=$changeState&amp;sort=$isSorted",},
         {text => 'Sort',        href    => "./folderFirst.pl?folderFirst=$folderfirst&amp;sort=$sort",},
         {text => 'Kontakt',     href    => 'mailto:dirk.lindner@gmx.de',},
         {text => 'Treeview.pm', href    => '/html-menu-treeview.html', target => 'rightFrame', onclick => '', subtree => [{text => 'Source Code', href => 'treeviewsource.pl', target => 'rightFrame',},],},
         {text => 'Examples',    subtree => [{text => 'OO Syntax', href => 'oo.pl', target => 'rightFrame',}, {text => 'FO Syntax', href => './fo.pl', target => 'rightFrame',}, {text => 'Crystal', href => './crystal.pl', target => 'rightFrame',},],},
         {
          text    => 'Related Sites',
          subtree => [
                      {text => 'search.cpan.org', href => 'http://search.cpan.org/dist/HTML-Menu-TreeView/',   target => '_parent',},
                      {text => 'Forum',           href => 'http://www.cpanforum.com/dist/HTML-Menu-TreeView/', target => '_parent',},
                      {text => 'Subversion',      href => 'http://treeview.tigris.org/',                       target => '_parent',},
                      {text => 'Lindnerei.de',    href => 'http://www.lindnerei.de',                           target => '_parent',},
                      {text => 'Treeview.pm',     href => 'http://treeview.lindnerei.de/',                     target => 'rightFrame', onclick => '', subtree => [{text => 'Source Code', href => 'treeviewsource.pl', target => 'rightFrame',},],},
                      {
                       text    => 'Examples',
                       subtree => [{text => 'OO Syntax', href => 'oo.pl', target => 'rightFrame',}, {text => 'FO Syntax', href => './fo.pl', target => 'rightFrame',}, {text => 'Crystal', href => './crystal.pl', target => 'rightFrame',},],
                      },
          ]
         },
         {text => 'Kontakt', href => 'mailto:dirk.lindner@gmx.de',}
);

my $src     = $size== 16 ? "plus.png" : "minus.png";
my $newsize = $size== 16 ? 32         : 16;
my $zoom = ($style eq "Crystal") ? "<img src=\"/$src\" style=\"cursor:pointer;\" alt=\"zoom\" align=\"MIDDLE\" border=\"0\"/ onclick=\"location.href='./Treenavi.pl?style=$style&amp;size=$newsize';\">" : '';
print "Content-Type: text/html$/$/
<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
<title>Sort TreeView</title>
<link rel=\"stylesheet\" type=\"text/css\" href=\"/style/$style/$size/html-menu-treeview/$style.css\">
<script language=\"JavaScript\" type=\"text/javascript\">
//<!--
" . $treeview->jscript() . $treeview->preload() . '
//-->
</script>
</head>
<body>
<table align="center" class="mainborder" cellpadding="0"  cellspacing="0" summary="mainLayout" width="100%"><tr><td align="left">' . $treeview->Tree(\@t) . '</td></tr></table></body></html>';

1;
