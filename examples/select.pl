#!/usr/bin/perl -w
use HTML::Menu::TreeView;
use CGI qw (Vars);
use strict;
my $q = new CGI ;
my @tree = (
            {
             text    => $q->checkbox(-name=>'First',
                       -value=>'what',
                       -label=>'First'),
                       title => 'must be set', #if you dont set a title the item text will be used

             },
            {
             text    => $q->checkbox(-name=>'Whatever',
                       -value=>'whatever',
                       ),
                       title => 'must be set', #if you dont set a title the item text will be used
            }
);
my $TreeView = new HTML::Menu::TreeView();

print $q->header,
    $q->start_html(-title => 'Select', -script => $TreeView->jscript() . $TreeView->preload(), -style => {-code => $TreeView->css()}),
    $q->start_form(-method => "get", -action => "$ENV{SCRIPT_NAME}",),
    $q->hidden({-name => 'action'}, 'select'),
    $TreeView->Tree(\@tree),
    $q->submit(-name=> 'submit',-value => 'Select'),
    $q->end_form;
    if($q->param('submit')){
        print "submit",$q->br() ;
        my %params = Vars();
    foreach my $key (sort(keys %params)) {
        print $params{$key},$q->br() unless $key eq 'submit';
    }
  }
print $q->end_html;