#!/usr/bin/perl -W
use HTML::Menu::TreeView qw(Tree css jscript style documentRoot preload);
use CGI qw(-compile :all  -private_tempfiles);
use strict;
my @tree = (
            {image => "tar.png", onclick => "alert('onclick');", text => "onclick",},
            {
             text    => 'Treeview',
             href    => "./index.html",
             target  => '_parent',
             subtree => [{text => 'treeview.tigris.org', href => 'http://treeview.tigris.org', target => '_parent', image => "tar.png"}, {text => 'Examples', subtree => [{text => 'OO Syntax', href => './oo.pl',},],},],
            },
            {image => "tar.png", ondblclick => "alert('ondblclick');", text => "ondblclick", title => "ondblclick",},
);
documentRoot("../httpdocs/");
style("Crystal");
print header, start_html(-title => 'Columns', -script => jscript() . preload(), -style => {-code => css()}), Tree(\@tree), end_html;

