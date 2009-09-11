#!/usr/bin/perl -w
use HTML::Menu::TreeView;
use CGI;
use strict;
my @tree = (
    {
     onclick => "alert('onclick');",
     text    => 'onclick',
    },
    {
     text  => 'Html::Menu::TreeView',
     href  => "./open.pl?open=1",
     empty => 1,                        # this is the important line
    }
);
my $TreeView = new HTML::Menu::TreeView();
my $q        = new CGI;
$tree[1]{subtree} = [
                     {
                      text   => 'treeview.tigris.org',
                      href   => 'http://treeview.tigris.org',
                      target => '_parent',
                     },
                     {
                      text    => 'Examples',
                      subtree => [
                                  {
                                   text => 'FO Syntax',
                                   href => './fo.pl',
                                  },
                      ],
                     },
  ]
  if( $q->param('open') );
print $q->header,
  $q->start_html(
                  -title  => 'OO',
                  -script => $TreeView->jscript() . $TreeView->preload(),
                  -style  => {-code => $TreeView->css()}
  ),
  $TreeView->Tree( \@tree ), $q->end_html;
