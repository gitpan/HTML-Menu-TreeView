#!/usr/bin/perl -w
use HTML::Menu::TreeView qw(Tree css jscript preload);
use CGI qw(-compile :all  -private_tempfiles);
use strict;
my @tree = (
            {image => 'tar.png', onclick => "alert('onclick');", text => 'onclick',},
            {
             text    => 'Html::Menu::TreeView',
             target  => '_parent',
             subtree => [{text => 'treeview.tigris.org', href => 'http://treeview.tigris.org', target => '_parent', image => 'tar.png'}, {text => 'Examples', subtree => [{text => 'OO Syntax', href => './oo.pl',},],},],
            },
            {image => 'tar.png', ondblclick => "alert('ondblclick');", text => 'ondblclick', title => 'ondblclick',},
);
print header(), start_html(-title => 'Fo', -script => jscript() . preload(), -style => {-code => css()}), Tree(\@tree), end_html;
