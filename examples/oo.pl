#!/usr/bin/perl -WT
use HTML::Menu::TreeView;
use CGI;
use strict;
my @tree = (
            {image => 'tar.png', onclick => "alert('onclick');", text => 'onclick',},
            {
             text    => 'Treeview',
             href    => './index.html',
             target  => '_parent',
             subtree => [{text => 'treeview.tigris.org', href => 'http://treeview.tigris.org', target => '_parent', image => 'tar.png'}, {text => 'Examples', subtree => [{text => 'FO Syntax', href => './fo.pl',},],},],
            },
            {image => "tar.png", ondblclick => "alert('ondblclick');", text => "ondblclick", title => "ondblclick",},
);
my $TreeView = new HTML::Menu::TreeView();
$TreeView->documentRoot("../httpdocs/");
$TreeView->style('simple');
my $q = new CGI;
print $q->header, $q->start_html(-title => 'Columns', -script => $TreeView->jscript() . $TreeView->preload(), -style => {-code => $TreeView->css()}), $TreeView->Tree(\@tree), $q->end_html;

