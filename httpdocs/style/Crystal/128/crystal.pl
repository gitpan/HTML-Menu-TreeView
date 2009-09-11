#!/usr/bin/perl -w
use strict;
use GD;

opendir(DIR,"./") or die $!;
my @files = grep{ /^(folder.*).png/} readdir(DIR);
closedir DIR;

foreach my $file(@files) {
# if($file=~ /^folder_([a-z]+)_open.png/){
        GD::Image->trueColor(1);
        open( PNG, "$file" ) || die;
        my $myImage = newFromPng GD::Image( \*PNG ) || die;
        $myImage->saveAlpha(1);
        close PNG;
        my ( $breite, $hoehe ) = $myImage->getBounds();
        my $h = $hoehe/ 2;
        my $color =  $myImage->colorClosest(128,128,128);
        open( OUT, ">$file" ) || die $!;
        $myImage->setPixel(0,72,$color);
        $myImage->setPixel(2,72,$color);
        $myImage->setPixel(4,72,$color);
#         $myImage->setPixel(4,72,$color);
#         $myImage->setPixel($breite/2,$hoehe-8,$color);
#         $myImage->setPixel($breite/2,$hoehe-6,$color);
#         $myImage->setPixel($breite/2,$hoehe-4,$color);
#         $myImage->setPixel($breite/2,$hoehe-2,$color);
#         $myImage->setPixel($breite/2,$hoehe,$color);
        binmode OUT;
        print OUT $myImage->png;
        close OUT;
# }
}
