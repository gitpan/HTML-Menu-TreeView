#!/usr/bin/perl -w
use CGI;
use HTML::Menu::TreeView;
my $q        = new CGI;
my $TreeView = new HTML::Menu::TreeView();
my @tree = (
        {text => 'News', columns => [a, b, c, d, e],},
        {
         text    => 'Folder',
         subtree => [{text => 'Test', columns => [e, d, c, b, a],},],
         columns => [a, b, c, d, e],
         subtree => [
                 {text => 'News', columns => [a, b, c, d, e],},
                 {
                  text    => 'Folder',
                  subtree => [{
                               text    => 'Test',
                               columns => [e, d, c, b, a],
                              },
                  ],
                  columns => [a, b, c, d, e],
                 },
                 {text => 'Test', columns => [a, b, c, d, e],},

         ],
        },
        {text => 'Test', columns => [a, b, c, d, e],},
);

$TreeView->columns(5);
my $size = defined $q->param('size') ? $q->param('size') : 16;
$size = ($size== 22 or $size== 32 or $size== 48 or $size== 64 or $size== 128) ? $size : 16;
$TreeView->size($size);
my $zoom =
  '<a href="./columns.pl?style=Crystal&amp;size=16" class="treeviewLink">16</a>|<a href="./columns.pl?style=Crystal&amp;size=22" class="treeviewLink" >22</a>|<a href="./columns.pl?style=Crystal&amp;size=32" class="treeviewLink">32</a>|<a href="./columns.pl?style=Crystal&amp;size=48" class="treeviewLink">48</a>|<a href="./columns.pl?style=Crystal&amp;size=64" class="treeviewLink">64</a>|<a href="./columns.pl?style=Crystal&amp;size=128" class="treeviewLink">128</a>';
print $q->header, $q->start_html(-title => 'Columns', -script => $TreeView->jscript() . $TreeView->preload(), -style => {-code => $TreeView->css()}), "$zoom<br/>", $TreeView->Tree(\@tree), $q->end_html;
1;
