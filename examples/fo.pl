#!/usr/bin/perl -w
use HTML::Menu::TreeView qw(Tree css jscript setStyle setDocumentRoot);
use strict;
my @tree = (
    {
        image   => "tar.png",
        onclick => "alert('onclick');",
        text    => "onclick",
    },
    {
        text    => 'Treeview',
        href    => "./index.html",
        target  => '_parent',
        subtree => [
            {
                text   => 'treeview.tigris.org',
                href   => 'http://treeview.tigris.org',
                target => '_parent',
                image  => "tar.png"
            },
            {
                text    => 'Examples',
                subtree => [
                    {
                        text => 'OO Syntax',
                        href => './oo.pl',
                    },
                ],
            },
        ],
    },
    {
        image      => "tar.png",
        ondblclick => "alert('ondblclick');",
        text       => "ondblclick",
        title      => "ondblclick",
    },
);
setDocumentRoot("/srv/www/htdocs/");
setStyle("Crystal");

print "Content-Type: text/html\n\n

<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\" \"http://www.w3.org/TR/html4/loose.dtd\">

<html>

<head>

<title>treeview  FO Syntax</title>

<style type=\"text/css\">" . css() . "</style>

<script language=\"JavaScript\" type=\"text/javascript\">

//<!--

" . jscript() . "

//-->
</script>

</head>

<body>
<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" summary=\"Table\"  ><tr><td>
" . Tree(\@tree)."</td></tr><tr><td>";
print '</td></tr></table></body></html>';

