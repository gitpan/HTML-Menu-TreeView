package HTML::Menu::TreeView;
# use 5.008006;
use strict;
use warnings;
require Exporter;
use vars qw($DefaultClass %EXPORT_TAGS @EXPORT_OK @ISA %anker);
$HTML::Menu::TreeView::VERSION     = '0.6.7';
@ISA                               = qw(Exporter);
@HTML::Menu::TreeView::EXPORT_OK   = qw(all Tree css jscript setStyle getStyle setDocumentRoot getDocumentRoot setSize setClasic clasic preload);
%HTML::Menu::TreeView::EXPORT_TAGS = ('all' => [qw(Tree css jscript setStyle getStyle setDocumentRoot getDocumentRoot setSize setClasic clasic preload )]);
$DefaultClass                      = 'HTML::Menu::TreeView' unless defined $HTML::Menu::TreeView::DefaultClass;
our $id     = "a";
our $style  = "Crystal";
our $size   = "16";
our $path   = '.';
our $clasic = 0;
%anker = (href=>'',accesskey=>'',charset=>'',class=>'',coords=>'',mdir=>'',hreflang=>'',mid=>'',lang=>'',onblur=>'',ondblclick=>'',onclick=>'',onfocus=>'',onkeydown=>'',onkeypress=>'',onkeyup=>'',onmousedown=>'',onmousemove=>'',onmouseout=>'',onmouseover=>'',onmouseup=>'',rel=>'',shape=>'',mstyle=>'',tabindex=>'',target=>'',title=>'',type=>'');

=head1 NAME

HTML::Menu::TreeView

=head1 SYNOPSIS

	use HTML::Menu::TreeView qw(Tree);

	my @tree =( {
	
	text => 'Folder',
	
	subtree => [

		{

                text => 'treeview Homepage',

                href => 'http://treeview.lindnerei.de',

		}

            ],

	},);

	Tree(\tree);

=head2 OO Syntax

	use HTML::Menu::TreeView qw(Tree);

	use strict;

	my @tree =(

		{

			image => 'tar.png',

			onclick => "alert('onclick');",

			text => 'Node',

		},

		{

			href => "http://www.lindnerei.de",

			text => 'Lindnerei.de',

		},

		{

			text => 'Folder',

			folderclass => 'folderMan', # only for Crystal styles
	
			subtree => [

				{

					text => 'subversion',

					href => 'http://TreeView.tigris.org',

				},

			],

		},

	);

	my $TreeView = new HTML::Menu::TreeView();

	$TreeView->setStyle("simple");

	print $TreeView->css("/srv/www/httpdocs");

	print TreeView->jscript();

	print $TreeView->Tree(\@tree);


allowed attributes:

 href, accesskey,charset,class,coords,

mdir, hreflang,mid,lang,onblur,ondblclick,

onclick,onfocus,onkeydown,onkeypress,

onkeyup,onmousedown,onmousemove,onmouseout,

onmouseover,onmouseup,rel,shape,mstyle,

tabindex,target,title,type,image and text.

Possible values for folderclass :

folderMan, folderVideo,folderCrystal, 

folderLocked , folderText, folderFavorite,
 
folderPrint,folderHtml,folderSentMail,

folderImage,folderSound,folderImportant,

folderTar,folderYellow ,folderGray,

folderGreen and  folderRed

show http://treeview.lindnerei.de/cgi-bin/crystal.pl for a complete list of possible values for folderclass.

=head2 FO Syntax

	use HTML::Menu::TreeView qw(:all);

	setDocumentRoot("/srv/www/httpdocs");

	print css();

	print jscript();

	print Tree(\@tree,"Crystal");

=head1 DESCRIPTION

HTML::Menu::TreeView is a Modul to build an Html tree of an AoH.

=head1 Changes

0.6.7

some bugs with preloading 

make use of  ExtUtils::MakeMaker.

more tests.

Overwrought Documentation.

remove bw style from package, you can download it from treeview.lindnerei.de.

remove installdocs.

=head2  new()

if you use the oo interface you can say:

my $TreeView = new HTML::Menu::TreeView(\@tree);

and then call Tree without arguments.

print $TreeView->Tree();

=cut

sub new {
    my ($class, @initializer) = @_;
    my $self = {tree => undef,};
    bless $self, ref $class || $class || $DefaultClass;
    $style = $initializer[1] if(defined $initializer[1]);
    $self->initTree(@initializer) if(@initializer);
    return $self;
}

=head2 setStyle()

setStyle('style');

simple = redmond like style

Crystal = Crystal style

=cut

sub setStyle {
    my ($self, @p) = getSelf(@_);
    $style = $p[0];
}

=head2 setSize()

only for Crystal styles

16,32,48,64 and 128  are possible values.

=cut

sub setSize {
    my ($self, @p) = getSelf(@_);
    $size = $p[0];
}

=head2 setClasic()

use a classic node decoration 

=cut

sub setClasic {
    my ($self, @p) = getSelf(@_);
    $clasic = 1;
}

=head2 setModern()

use a classic node decoration 

is the dafault decoration.

=cut

sub setModern {
    my ($self, @p) = getSelf(@_);
    $clasic = 0;
}

=head2 clasic()

bool clasic() ( node decoration)

=cut

sub clasic {
    return $clasic;
}

=head2 getStyle()

mainly for testing.

=cut

sub getStyle {
    my ($self, @p) = getSelf(@_);
    return $style;
}

=head2 setDocumentRoot()

set the local path to the style folder.

should be the DocumentRoot of the webserver.

example: setDocumentRoot('/srv/www/htdocs');

default: /srv/www/htdocs

=cut

sub setDocumentRoot {
    my ($self, @p) = getSelf(@_);
    $path = $p[0];
}

=head2 getDocumentRoot()

mainly for testing.

=cut

sub getDocumentRoot {
    my ($self, @p) = getSelf(@_);
    return $path;
}

=head2 css()

return the  necessary css part without <style></style> tag.

you can set the DocumentRoot if you pass a parameter

css('/srv/www/htdocs');

You can also include it with

<link href="/style/Crystal/16/html-menu-treeview/Crystal.css" rel="stylesheet" type="text/css">

for example.

=cut

sub css {
    my ($self, @p) = getSelf(@_);
    use Fcntl qw(:flock);
    use Symbol;
    $path = $p[0] if(defined $p[0]);
    my $fh   = gensym;
    my $file = "$path/style/$style/$size/html-menu-treeview/$style.css";
    open $fh, "$file" or warn "no style '$style.css' $style.css found \n  in  $path/style/html-menu-treeview/$style/ \n $!";
    seek $fh, 0, 0;
    my @lines = <$fh>;
    close $fh;
    my $css;

    for(@lines) {
        $css .= $_;
    }
    return $css;
}

=head2 jscript()

return the necessary  javascript  without <script> tag.

You can also include it with

<script language="JavaScript" type="text/javascript" src="/style/treeview.js"></script>

=cut

sub jscript {
    return "
function ocFolder(id){
var  folder = document.getElementById(id).className;
if(folder == 'folderOpen'){
 document.getElementById(id).className = 'folderClosed';
}else if(folder == 'folderClosed'){
document.getElementById(id).className = 'folderOpen';
}else{
var mclass = /(folder.*)Closed/;
var isclosed = mclass.test(folder);
if (isclosed == true){
document.getElementById(id).className = folder.replace(/(folder.*)Closed/, '\$1');
}else{
document.getElementById(id).className = folder.replace(/(folder.*)/, '\$1Closed')
}
}
}
function ocNode(id){
var folder = document.getElementById(id).className;
if(folder == \"minusNode\"){
document.getElementById(id).className = 'plusNode';
}else if(folder == \"plusNode\"){
document.getElementById(id).className = 'minusNode';
}else if(folder == \"clasicPlusNode\"){
document.getElementById(id).className = 'clasicMinusNode';
}else if(folder == \"clasicMinusNode\"){
document.getElementById(id).className = 'clasicPlusNode';
}
}
function ocpNode(id){
var folder = document.getElementById(id).className;
if(folder == \"lastMinusNode\"){
document.getElementById(id).className = 'lastPlusNode';
}else if(folder == \"lastPlusNode\"){
document.getElementById(id).className = 'lastMinusNode';
}else if(folder == \"clasicLastPlusNode\"){
document.getElementById(id).className = 'clasicLastMinusNode';
}else if(folder == \"clasicLastMinusNode\"){
document.getElementById(id).className = 'clasicLastPlusNode';
}
}
function displayTree(id){
var e = document.getElementById(id);
var display = e.style.display;
if(display == \"none\"){
e.style.display = \"\";
}else if(display == \"\"){
e.style.display = \"none\";
}
}
";
}

=head2 preload()

return a javascript for preloading images.

for example you can also include it with

<script language="JavaScript" type="text/javascript" src="/style/Crystal/16/html-menu-treeview/preload.js"></script>

or

<script language="JavaScript" type="text/javascript" src="/style/Crystal/preload.js"></script>

if you use different images sizes.

=cut

sub preload {
    my $preload = "
<script language=\"JavaScript\" type=\"text/javascript\">
//<!--
folderClosed = new Image($size,$size);
folderClosed.src='/style/$style/$size/html-menu-treeview/folderClosed.gif';
plusNode = new Image($size,$size);
plusNode.src='/style/$style/$size/html-menu-treeview/plusNode.gif';
lastPlusNode = new Image($size,$size);
lastPlusNode.src='/style/$style/$size/html-menu-treeview/lastPlusNode.gif';
clasicplusNode = new Image($size,$size);
clasicplusNode.src='/style/$style/$size/html-menu-treeview/clasicPlusNode.gif';
clasicLastplusNode = new Image($size,$size);
clasicLastplusNode.src='/style/$style/$size/html-menu-treeview/clasicLastPlusNode.gif';
";
    if($style eq "Crystal") {
        $preload .= "
folderManClosed = new Image($size,$size);
folderManClosed.src='/style/$style/$size/html-menu-treeview/folderManClosed.gif';
folderGrayClosed = new Image($size,$size);
folderGrayClosed.src='/style/$style/$size/html-menu-treeview/folderGrayClosed.gif';
folderGreenClosed = new Image($size,$size);
folderGreenClosed.src='/style/$style/$size/html-menu-treeview/folderGreenClosed.gif';
folderRedClosed = new Image($size,$size);
folderRedClosed.src='/style/$style/$size/html-menu-treeview/folderRedClosed.gif';
folderViolet = new Image($size,$size);
folderViolet.src='/style/$style/$size/html-menu-treeview/folderViolet.gif';
folderYellowClosed = new Image($size,$size);
folderYellowClosed.src='/style/$style/$size/html-menu-treeview/folderYellowClosed.gif';
folderOrangeClosed = new Image($size,$size);
folderOrangeClosed.src='/style/$style/$size/html-menu-treeview/folderOrangeClosed.gif';
folderManClosed = new Image($size,$size);
folderManClosed.src='/style/$style/$size/html-menu-treeview/folderManClosed.gif';
folderHtmlClosed = new Image($size,$size);
folderHtmlClosed.src='/style/$style/$size/html-menu-treeview/folderHtmlClosed.gif';
folderFavoriteClosed = new Image($size,$size);
folderFavoriteClosed.src='/style/$style/$size/html-menu-treeview/folderFavoriteClosed.gif';
folderTextClosed = new Image($size,$size);
folderTextClosed.src='/style/$style/$size/html-menu-treeview/folderTextClosed.gif';
folderLockedClosed = new Image($size,$size);
folderLockedClosed.src='/style/$style/$size/html-menu-treeview/folderLockedClosed.gif';
folderCrystalClosed = new Image($size,$size);
folderCrystalClosed.src='/style/$style/$size/html-menu-treeview/folderCrystalClosed.gif';
folderVideoClosed = new Image($size,$size);
folderVideoClosed.src='/style/$style/$size/html-menu-treeview/folderVideoClosed.gif';
folderPrintClosed = new Image($size,$size);
folderPrintClosed.src='/style/$style/$size/html-menu-treeview/folderPrintClosed.gif';
folderImageClosed = new Image($size,$size);
folderImageClosed.src='/style/$style/$size/html-menu-treeview/folderImageClosed.gif';
folderSoundClosed = new Image($size,$size);
folderSoundClosed.src='/style/$style/$size/html-menu-treeview/folderSoundClosed.gif';
folderImportantClosed = new Image($size,$size);
folderImportantClosed.src='/style/$style/$size/html-menu-treeview/folderImportantClosed.gif';
folderTarClosed = new Image($size,$size);
folderTarClosed.src='/style/$style/$size/html-menu-treeview/folderTarClosed.gif';
";
    }
    $preload .= "//-->
</script>
";
    return $preload;
}

=head2 Tree()

Tree(\@tree,optional $style);

Returns the Html part of the TreeView without javasript and css.

=cut

sub Tree {
    my ($self, @p) = getSelf(@_);
    $style = $p[1] if(defined $p[1]);
    $self->initTree(@p) if(@p);
    return '<table align="left" class="TreeView" border="0" cellpadding="0" cellspacing="0" summary="treeTable"  ><colgroup><col width="' . $size . '"></colgroup>' . $self->{tree} . '</table>';
}

sub initTree {
    my ($self, @p) = getSelf(@_);
    my $tree   = $p[0];
    my $length = @$tree;
    for(my $i = 0 ; $i < @$tree ; $i++) {
        $length--;
        if(defined @{@$tree[$i]->{subtree}}) {
            if($length > 0) {
                $self->appendFolder(@$tree[$i], \@{@$tree[$i]->{subtree}});
            } elsif ($length eq 0) {
                $self->appendLastFolder(@$tree[$i], \@{@$tree[$i]->{subtree}});
            }
        } else {
            if($length > 0) {
                $self->appendNode(@$tree[$i]);
            } elsif ($length eq 0) {
                $self->appendLastNode(@$tree[$i]);
            }
        }
    }
}

sub getSelf {
    return @_ if defined($_[0]) && (!ref($_[0])) && ($_[0] eq 'HTML::Menu::TreeView');
    return (defined($_[0]) && (ref($_[0]) eq 'HTML::Menu::TreeView' || UNIVERSAL::isa($_[0], 'HTML::Menu::TreeView'))) ? @_ : ($HTML::Menu::TreeView::DefaultClass->new, @_);
}

sub appendFolder {
    my $self    = shift;
    my $node    = shift;
    my $subtree = shift;
    ++$id;
    $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? "" : "displayTree('$id'); ocFolder('$id.folder');ocNode('$id.node');";
    $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
    my $FolderClass = defined $node->{folderclass} ? $node->{folderclass} : 'folderOpen';
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;

    foreach my $key (keys %{$node}) {
        if(exists $anker{$key}) {
            $tt .= $key . '="' . $node->{$key} . '" ';
        } else {
            warn "unknown attribute $key \n" unless ($key =~ /image|text|subtree|folderclass/);
        }
    }
    my $minusnode = $clasic ? "clasicMinusNode" : "minusNode";
    $self->{tree} .=
      "<tr class=\"trSubtreeCaption\"><td  id=\"$id.node\" class=\"$minusnode\" onclick=\"displayTree('$id'); ocFolder('$id.folder');ocNode('$id.node');\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td align=\"left\" class=\"$FolderClass\" id=\"$id.folder\"><a $tt>$node->{text}</a></td></tr><tr id=\"$id\" class=\"trSubtree\"><td class=\"submenuDeco\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" alt=\"spacer\"/></td><td class=\"submenu\"><table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><colgroup><col width=\"$size\"></colgroup>";
    $self->initTree(\@$subtree);
    $self->{tree} .= "</table></td></tr>";
}

sub appendLastFolder {
    my $self    = shift;
    my $node    = shift;
    my $subtree = shift;
    $id++;
    $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? "" : "displayTree('$id'); ocFolder('$id.folder');ocpNode('$id.node');";
    $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
    my $FolderClass = defined $node->{FolderClass} ? $node->{FolderClass} : 'folderOpen';
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key (keys %{$node}) {
        if(exists $anker{$key}) {
            $tt .= $key . '="' . $node->{$key} . '" ';
        } else {
            warn "unknown attribute $key \n" unless ($key =~ /image|text|subtree|folderclass/);
        }
    }
    my $lastminusnode = $clasic ? "clasicLastMinusNode" : "lastMinusNode";
    $self->{tree} .=
      "<tr class=\"lastTreeViewItem\"><td id=\"$id.node\" class=\"$lastminusnode\" onclick=\"displayTree('$id');ocFolder('$id.folder');ocpNode('$id.node');\"></td><td align=\"left\" class=\"$FolderClass\" id=\"$id.folder\"><a $tt>$node->{text}</a></td></tr><tr id=\"$id\" class=\"trSubtree\"><td ><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td class=\"submenu\"><table align=\"left\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"subtreeTable\" summary=\"appendLastFolder\"><colgroup><col width=\"$size\"></colgroup>";
    $self->initTree(\@$subtree);
    $self->{tree} .= "</table></td></tr>";
}

sub appendNode {
    my $self = shift;
    my $node = shift;
    $node->{image} = defined $node->{image} ? $node->{image} : "link.gif";
    $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key (keys %{$node}) {
        if(exists $anker{$key}) {
            $tt .= $key . '="' . $node->{$key} . '" ';
        } else {
            warn "unknown attribute $key \n" unless ($key =~ /image|text|subtree|folderclass/);
        }
    }
    my $paddingLeft = $size+ 2 . "px";
    $self->{tree} .=
      "<tr class=\"TreeViewItem\"><td  class=\"node\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\" align=\"middle\"/></td><td align=\"left\"  style=\"background-image:url('/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft\"><a $tt>$node->{text}</a></td></tr>";
}

sub appendLastNode {
    my $self = shift;
    my $node = shift;
    $node->{image} = defined $node->{image} ? $node->{image} : "link.gif";
    $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key (keys %{$node}) {
        if(exists $anker{$key}) {
            $tt .= $key . '="' . $node->{$key} . '" ';
        } else {
            warn "unknown attribute $key \n" unless ($key =~ /image|text|subtree|folderclass/);
        }
    }
    my $paddingLeft = $size+ 2 . "px";
    $self->{tree} .=
      "<tr class=\"TreeViewItem\"><td  class=\"lastNode\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td align=\"left\"  style=\"background-image:url('/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft;\"><a $tt>$node->{text}</a></td></tr>";
}

=head1 AUTHOR

Dirk Lindner <lindnerei@o2online.de>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006 by Hr. Dirk Lindner

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation; 
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

=cut

1;
