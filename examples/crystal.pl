#!/usr/bin/perl -w
use HTML::Menu::TreeView qw(Tree css jscript Style documentRoot size clasic preload);
use CGI qw(-compile :all  -private_tempfiles);
use strict;
my $htpath = documentRoot();
my $size = defined param('size') ? param('size') : 16;
$size = ($size== 22 or $size== 32 or $size== 48 or $size== 64 or $size== 128) ? $size : 16;
my @tree;
opendir(DIR, "$htpath/style/Crystal/$size/mimetypes") or die ":$htpath/style/Crystal/$size/mimetypes$!";
my @lines = readdir(DIR);
closedir(DIR);
open(IN, "$htpath/style/Crystal/$size/html-menu-treeview/Crystal.css") or die ": $!";

while(my $line = <IN>) {
        if($line =~ /td\.(folder.+)Closed{/) {
                my $classname = $1;
                my $img       = shift @lines;
                $img = shift @lines while($img =~ /^\..*/);
                push @tree, {text => $classname, folderclass => $classname, subtree => [{text => $img, image => $img},],};
                next;
        }
}
close(IN);
for(my $i = 0 ; $i < $#lines ; ++$i) {
        my $img = shift @lines;
        unless ($img =~ /^\..*$/) {
                push @tree, {text => $img, image => $img,};
        }
}
documentRoot($htpath);
Style("Crystal");
size($size);
clasic(1) if(defined param('clasic'));
my $zoom =
  '<a href="./crystal.pl?style=Crystal&amp;size=16" class="treeviewLink">16</a>|<a href="./crystal.pl?style=Crystal&amp;size=22" class="treeviewLink" >22</a>|<a href="./crystal.pl?style=Crystal&amp;size=32" class="treeviewLink">32</a>|<a href="./crystal.pl?style=Crystal&amp;size=48" class="treeviewLink">48</a>|<a href="./crystal.pl?style=Crystal&amp;size=64" class="treeviewLink">64</a>|<a href="./crystal.pl?style=Crystal&amp;size=128" class="treeviewLink">128</a>';
print header(),
start_html(
	-title => 'Crystal',
	-script => jscript() . preload(),
	-style => {-code => css()}
),
"$zoom<br/>",
Tree(\@tree),
end_html;