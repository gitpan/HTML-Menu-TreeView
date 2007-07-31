#!/usr/bin/perl -w
# Be carefull with this script it is under construktion
use Pod::Usage;
use HTML::Menu::TreeView qw(:all);
use Getopt::Long;
use strict;
my $htdocs  = "/srv/www/httpdocs/";
my $outpath = undef;
my $style   = "Crystal";
my $size    = 16;
my $mod;
my $reverse = 0;
my @modules;
my $help   = 0;
my $sort   = 0;
my $prefix = undef;
my $result = GetOptions("module=s" => \$mod, "htdocs=s" => \$htdocs, "style=s" => \$style, "size=s" => \$size, "reverse=s" => \$reverse, 'help|?' => \$help, 'sort' => \$sort, 'prefix=s' => \$prefix, 'store=s' => \$outpath);
$help = 1 unless (defined $mod && $reverse);
pod2usage(1)    if $help;
sortTree(1)     if $sort;
prefix($prefix) if defined $prefix;
$outpath = defined $outpath ? $outpath : $htdocs;

if($reverse) {
        foreach my $key (@INC) {
                push @modules, &reverse($key);
        }
        my @t = ({text => "Installed Modules", subtree => [@modules],},);
        documentRoot($htdocs);
        style($style);
        size(48);
        open OUT, ">$outpath/index.html" or die "$!";
        print OUT "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
<title>Perldoc Navigation</title>
<style type=\"text/css\">" . css() . "</style>
<script language=\"JavaScript\" type=\"text/javascript\">
//<!--
" . jscript() . preload() . '
//-->
</script>
</head>
<body>
<table align="center" class="mainborder" cellpadding="0"  cellspacing="0" summary="mainLayout" width="100%" ><tr><td align="center" >' . Tree(\@t) . '</select><br><p></td></tr></table></body></html>';
        close(OUT);

} else {
        &module2treeview($mod, $mod);
}

sub module2treeview {
        my $module      = shift;
        my $modulname   = shift;
        my $module2path = $module;
        $module2path =~ s?::?/?g;
        my $module2html = $modulname ? $modulname : $module;
        $module2html =~ s?::?-?g;
        $module2html =~ s?/([^/])$?$1?g;
        my $infile = undef;

        if(-e $module) {
                $infile = $module;
                $module =~ s?.*/([^/]+)$?$1?;
                print "modulename :", $module, $/;
        }
        foreach my $key (@INC) {
                if(-e $key . "/" . $module2path . ".pm") {
                        $infile = $key . "/" . $module2path . ".pm";
                        last;
                }
        }
        my @t = ({text => $module, href => $module2html . "frame.html", target => 'rightFrame', subtree => [openTree($module, $infile, $module2html),],},);
        documentRoot($htdocs);
        style($style);
        size($size);
        open OUT, ">$outpath/navi$module2html.html" or die "$!";
        print OUT "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">
<html>
<head>
<title>Navigation</title>
<style type=\"text/css\">" . css() . "</style>
<script language=\"JavaScript\" type=\"text/javascript\">
//<!--
" . jscript() . preload() . '
//-->
</script>
</head>
<body>
<table align="center" class="mainborder" cellpadding="0"  cellspacing="0" summary="mainLayout" width="100%" ><tr><td align="center" >' . Tree(\@t) . '</select><br><p></td></tr></table></body></html>';
        close(OUT);
        open FRAME, ">$outpath/$module.html" or die "$!";
        print FRAME '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">
<html>
<head>
<title>' . $module . '</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta name="robots" content="index">
</head>
<frameset cols="300,*">
<frame src="navi' . $module2html . '.html" name="navi">
<frame src="' . $module2html . 'frame.html" name="rightFrame">
</frameset>
</html>';
        close(FRAME);
}

sub reverse {
        my $d = shift;
        my @DIR;
        chomp($d);
        opendir(IN, $d) or die "cant open $d $!:$/";
        my @files = readdir(IN);
        closedir(IN);
        for(my $i = 0 ; $i <= $#files ; $i++) {
                unless ($files[$i] =~ /^\./) {
                        if(-d $d . "/" . $files[$i]) {
                                push @DIR, {text => "$files[$i]", href => "$files[$i].pm.html", subtree => [&reverse($d . "/" . $files[$i])],};
                        } else {
                                if($files[$i] =~ /^.*\.pm$/) {
                                        &module2treeview("$d/$files[$i]", $files[$i]);
                                        my $ifex = $files[$i];
                                        $ifex =~ s/\.pm$//g;
                                        unless (-d $d . "/" . $ifex) {
                                                push @DIR, {text => "$files[$i]", href => "$files[$i].html",};
                                        }
                                }
                        }
                }
        }
        return @DIR;
}

sub openTree {
        my ($module, $infile, $m2) = @_;
        my @TREEVIEW;
        system("pod2html --noindex --title=$module --infile=$infile  --outfile=$outpath" . "$m2" . "frame.html");
        use Fcntl qw(:flock);
        use Symbol;
        my $fh   = gensym;
        my $file = "$outpath" . "$m2" . "frame.html";
        open $fh, "$file" or die "$!: $file";
        seek $fh, 0, 0;
        my @lines = <$fh>;
        close $fh;

        for(@lines) {
                if($_ =~ /<a href="#([^"]+)">(.+)<\/a>/) {
                        push @TREEVIEW, {text => "$2", href => $m2 . "frame.html#$1", target => 'rightFrame',};
                }
        }
        return @TREEVIEW;
}
 __END__

=head1 NAME

module2treeview.pl

=head1 SYNOPSIS

module2treeview.pl --module --htdocs --style --size --reverse --help

--module=HTML::Menu::TreeView the name of the modul that should be converted.

--htdocs=/path/to/your/document/root/

--size=16|32|48|64|128 #size of the treeview images

--style=Crystal|simple

--sort sort the TreeView.

--reverse=1  build documentation for all Perl modules found in your path.

Be carefull with this option it will write a lot of output.

--store /path/to store/Dokumentation 

dafault: htdocs path

--prefix=localpath/

--help print this message


=head1 DESCRIPTION

modul2treeview converts the pod from a Perl modul to a frame based html Dokumentation

which makes usage of HTML::Menu::TreeView.

=head1 Changes

0.1.3

--sort

--prefix # to create offline websites

--store /path/to store/Dokumentation

default: htpath

some fixes

=head1 AUTHOR

Dirk Lindner <lindnerei@o2online.de>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Hr. Dirk Lindner

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation;
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

=cut
