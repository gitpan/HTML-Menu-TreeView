#!/usr/bin/perl -w
use HTML::Menu::TreeView qw(Tree css jscript setStyle setDocumentRoot setSize setClasic preload);
use CGI::Carp qw(fatalsToBrowser);
use CGI qw(param);
my $htpath = "/srv/www/htdocs/";

my $size =  (param('size') eq 16 or  param('size') eq 22 or param('size') eq 32  or param('size') eq 48 or param('size') eq 64 or param('size') eq 128 )? param('size') : 16;
use strict;
my @tree;
opendir(DIR, "$htpath/style/Crystal/$size/mimetypes") or die ":$htpath/style/Crystal/$size/mimetypes$!";
my @lines = readdir(DIR);
closedir(DIR);
open(IN, "$htpath/style/Crystal/$size/html-menu-treeview/Crystal.css") or die ": $!";
while (my $line = <IN>){
	if($line =~/td\.(folder.+)Closed{/){
	my $classname = $1;
	my $img = shift @lines;
	$img = 'link.gif' if($img=~/^\..*/);
	push @tree ,     {
        text        => $classname,
        folderclass => $classname,
        subtree     => [
		{
                text   => $img,
                image  => $img
		},
        ],
	};
	next;
	}
}
close(IN);
for(my $i = 0; $i < $#lines;++$i){
	my $img = shift @lines;
	unless($img =~/^\..*$/){
	push @tree ,{
                text   => $img,
                image  => $img,
	};
}
}

setDocumentRoot($htpath);
setStyle("Crystal");

setSize($size);
setClasic() if (defined param('clasic'));
my $zoom =  '<a href="./crystal.pl?style=Crystal&amp;size=16" class="treeviewLink">16</a>|<a href="./crystal.pl?style=Crystal&amp;size=22" class="treeviewLink" >22</a>|<a href="./crystal.pl?style=Crystal&amp;size=32" class="treeviewLink">32</a>|<a href="./crystal.pl?style=Crystal&amp;size=48" class="treeviewLink">48</a>|<a href="./crystal.pl?style=Crystal&amp;size=64" class="treeviewLink">64</a>|<a href="./crystal.pl?style=Crystal&amp;size=128" class="treeviewLink">128</a>';
print "Content-Type: text/html\n\n
<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">

<html>

<head>

<title>Crystal</title>

<style type=\"text/css\">" . css() . "</style>

<script language=\"JavaScript\" type=\"text/javascript\">

//<!--

" . jscript() . "

//if(parent.location.href.length == location.href.length)
  //       location.href = './';
//-->

</script>

</head>

<body>".preload()."
<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" summary=\"Table\"><tr><td>$zoom<br/>". Tree(\@tree).'</td></tr><tr><td>';
print '</td></tr></table></body></html>';
