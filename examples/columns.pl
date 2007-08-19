#!/usr/bin/perl -w
use CGI;
use strict;
use HTML::Menu::TreeView;
my $q         = new CGI;
my $TreeView  = new HTML::Menu::TreeView();
my $subfolder = defined $q->param('subfolder') ? $q->param('subfolder') : '/srv/www/httpdocs/';
my $style     = $q->param('style') ? $q->param('style') : 'Crystal';
my $size      = defined $q->param('size') ? $q->param('size') : 16;
my @tree      = recursiveReadDir($subfolder);
$TreeView->Style($style);
$TreeView->columns(
                   "<a href=\"./columns.pl?style=$style&amp;size=$size&sort=1\" class=\"treeviewLink\">Name</a>&#160;",
                   "<a href=\"./columns.pl?style=$style&amp;size=$size&byColumn=0\" class=\"treeviewLink\">Size</a>&#160;",
                   "<a href=\"./columns.pl?style=$style&amp;size=$size&byColumn=1\" class=\"treeviewLink\">Permission</a>&#160;",
                   "<a href=\"./columns.pl?style=$style&amp;size=$size&byColumn=2\" class=\"treeviewLink\">Last Modified</a>&#160;",
);

if(defined $q->param('byColumn')) {
        $TreeView->orderByColumn($q->param('byColumn'));
} elsif ($q->param('sort')) {
        $TreeView->sortTree(1);
}
$TreeView->size($size);
$TreeView->border(1);
$TreeView->clasic(1) if(defined $q->param('clasic'));

my $zoom =
  '<a href="./columns.pl?style=Crystal&amp;size=16" class="treeviewLink">16</a>|<a href="./columns.pl?style=Crystal&amp;size=22" class="treeviewLink" >22</a>|<a href="./columns.pl?style=Crystal&amp;size=32" class="treeviewLink">32</a>|<a href="./columns.pl?style=Crystal&amp;size=48" class="treeviewLink">48</a>|<a href="./columns.pl?style=Crystal&amp;size=64" class="treeviewLink">64</a>|<a href="./columns.pl?style=Crystal&amp;size=128" class="treeviewLink">128</a>|<a href="./columns.pl?style=simple&amp;size=16" class="treeviewLink">Simple</a>';
print $q->header, $q->start_html(-title => 'Columns', -script => $TreeView->jscript() . $TreeView->preload(), -style => {-code => $TreeView->css()},), "<div align=\"center\">$zoom<br/>", $TreeView->Tree(\@tree), '</div>', $q->end_html;

sub recursiveReadDir {
        my $dir = shift;
        chomp($dir);
        opendir(DIR, "$dir") or die ":$dir $!";
        my @files = readdir(DIR);
        closedir(DIR);
        my @t;
        for(my $i = 0 ; $i < $#files ; $i++) {
                unless ($files[$i] =~ /^\./) {
                        use File::stat;
                        my $sb = stat($dir . $files[$i]);
                        unless (-d $dir . $files[$i]) {
                                push @t, {text => $files[$i], columns => [sprintf("%s", $sb->size), sprintf("%04o", $sb->mode & 07777), sprintf("%s", scalar localtime $sb->mtime)],};
                        } else {
                                my @st = recursiveReadDir("$dir$files[$i]/");
                                push @t,
                                  {
                                    text    => "$files[$i]",
                                    subtree => [@st],
                                    href    => "./columns.pl?style=$style&amp;size=$size&subfolder=$dir$files[$i]/",
                                    columns => [sprintf("%s", $sb->size), sprintf("%04o", $sb->mode & 07777), sprintf("%s", scalar localtime $sb->mtime)]
                                  };
                        }
                }
        }
        return @t;
}
1;
