#!/usr/bin/perl -w
use strict;
use HTML::Menu::TreeView qw(:all);
use URI::Escape;
use Encode;
use Fcntl qw(:flock);
use Symbol;
use vars qw(@adrFile $folderId $currentOpen @openFolders @operaTree $fh $fsrc $treeTempRef);
$fh   = gensym;
$fsrc = "./opera6.adr";
open $fh, $fsrc or die "$!: $fsrc";
seek $fh, 0, 0;
@adrFile = <$fh>;
close $fh;
($folderId, $currentOpen) = (0) x 2;
$operaTree[0] = {text => "Bookmarks", subtree => []};
$treeTempRef = \@{$operaTree[0]->{subtree}};
$openFolders[0][0] = $treeTempRef;

for(my $line = 0 ; $line < $#adrFile ; $line++) {
        chomp $adrFile[$line];
        if($adrFile[$line] =~ /^#FOLDER/) {    #neuer Folder
                $folderId++;
                my $text = $1 if($adrFile[$line+ 2] =~ /NAME=(.*)$/);
                Encode::from_to($text, "utf-8", "iso-8859-1");
                push @{$treeTempRef}, {text => $text, subtree => []};
                my $l = @$treeTempRef;
                $treeTempRef               = \@{@{$treeTempRef}[$l- 1]->{subtree}};    #aktuelle referenz setzen.
                $openFolders[$folderId][0] = $treeTempRef;                             #referenz auf den parent Tree speichern
                $openFolders[$folderId][1] = $currentOpen;                             #rücksprung speichern
                $currentOpen               = $folderId;
        }
        if($adrFile[$line] =~ /^-/) {                                                  #wenn folder geschlossen wird
                $treeTempRef = $openFolders[$openFolders[$currentOpen][1]][0];         #aktuelle referenz auf parent referenz setzen
                $currentOpen = $openFolders[$currentOpen][1];                          #rücksprung zu parent
        }
        if($adrFile[$line] =~ /^#URL/) {                                               #Node anhängen
                my $text = $1 if($adrFile[$line+ 2] =~ /NAME=(.*)$/);
                my $href = $1 if($adrFile[$line+ 3] =~ /URL=(.*)$/);
                Encode::from_to($text, "utf-8", "iso-8859-1");
                if(defined $text && defined $href) {
                        push @{$treeTempRef}, {text => $text, href => $href,};
                }
        }
}
use CGI qw(-compile :all  -private_tempfiles);
use CGI::Carp qw(fatalsToBrowser);
print header(), start_html(-title => 'Bookmarks', -script => jscript() . preload(), -style => {-code => css()});
print Tree(\@operaTree);
