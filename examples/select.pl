#!/usr/bin/perl -w
use HTML::Menu::TreeView;
use CGI;
use strict;
my $q = new CGI;
my @tree = ( {  text => 'what',
                addition =>
                    $q->checkbox( -name  => 'what',
                                  -value => 'what',
                                  -label => ''
                    ),
             },
             {  text => 'Whatever',
                addition =>
                    $q->checkbox( -name  => 'Whatever',
                                  -value => 'Whatever',
                                  -label => ''
                    ),
             }
);
my $TreeView = new HTML::Menu::TreeView();
print( $q->header,
       $q->start_html( -title  => 'Select',
                       -script => $TreeView->jscript() . $TreeView->preload(),
                       -style  => { -code => $TreeView->css() }
       ),
       $q->start_form( -method => "get",
                       -action => "$ENV{SCRIPT_NAME}",
       ),
       $q->hidden( { -name => 'action' }, 'select' ),
       $TreeView->Tree( \@tree ),
       $q->submit( -name  => 'submit',
                   -value => 'Select'
       ),
       $q->end_form
);
if ( $q->param('submit') ) {
    my %params = $q->Vars();
    foreach my $key ( sort( keys %params ) ) {
        print $q->br() . $params{$key} unless $key eq 'submit';
    }
}
print $q->end_html;
