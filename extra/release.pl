use strict;
use Getopt::Long;
my $release = 'blib/';
my $dir     = 'httpdocs/';
my $path    = '.';
my $result  = GetOptions("release=s" => \$release, "readdir=s" => \$dir, "htpath=s" => \$path,);
system("mkdir -p $release") unless -e $release;

&change($dir);

sub change {
        my $d = shift;
        chomp($d);
        opendir(IN, $d) or die "cant open $d $!:$/";
        my @files = readdir(IN);
        closedir(IN);
        for(my $i = 0 ; $i <= $#files ; $i++) {
                unless ($files[$i] =~ /^\./) {
                        my $c = $d . $files[$i];
                        my $e = $c;
                        $e =~ s/^$dir(.*)/$1/;
                        unless (-d $d . $files[$i]) {

                                #                                 if($files[$i] =~ /\.css$/) {
                                #                                         removeEmtyLines($d . $files[$i]);
                                #                                 }
                                system(" cp " . $c . " $release/$e") unless (-e $release . "/" . $e && $files[$i] =~ /\~$/);
                        } else {
                                unless ($files[$i] =~ /CVS/) {
                                        system("mkdir -p $release/$e") unless (-e $release . "/" . $e);
                                        &change($d . $files[$i] . "/");
                                }
                        }
                }
        }
}
&replacePath('blib/lib/HTML/Menu/TreeView.pm');

sub replacePath {
        my $file = shift;
        chmod 0644, $file;
        open(EDIT, "+<$file") or die "$! $/";
        my $file = '';
        while(<EDIT>) {
                s/%PATH%/$path/;
                $file .= $_;
        }
        seek(EDIT, 0, 0);
        print EDIT $file;
        truncate(EDIT, tell(EDIT));
        close(EDIT);
}

# sub removeEmtyLines {
#         my $file = shift;
#         chmod 0644, $file;
#         open(EDIT, "+<$file") or die "$! $/";
#         my $file = '';
#         while(<EDIT>) {
#                 $file .= $_ unless ($_ =~ /^$/);
#         }
#         seek(EDIT, 0, 0);
#         print EDIT $file;
#         truncate(EDIT, tell(EDIT));
#         close(EDIT);
# }
1;
