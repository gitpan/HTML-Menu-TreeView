package HTML::Menu::TreeView;
use 5.008006;
use strict;
use warnings;
require Exporter;
use vars qw($DefaultClass @EXPORT @ISA);
@ISA                             = qw(Exporter);
@HTML::Menu::TreeView::EXPORT_OK = qw(Tree css jscript setStyle getStyle setDocumentRoot getDocumentRoot setSize setClasic clasic preload);
$HTML::Menu::TreeView::VERSION   = '0.6.3';
$DefaultClass                    = 'HTML::Menu::TreeView' unless defined $HTML::Menu::TreeView::DefaultClass;
our $id     = "a";
our $style  = "Crystal";
our $size   = "16";
our $path   = '.';
our $clasic = 0;

=head1 NAME

HTML::Menu::TreeView

=head1 SYNOPSIS

	use HTML::Menu::TreeView qw(Tree);

	my @tree =( {
	
	text => 'Folder',
	
	folderclass => 'folderMan',

	subtree => [

		{

                text => 'TreeView.tigris.org',

                href => 'http://TreeView.tigris.org',

		}

            ],

	},);

	Tree(\tree);

Possible values for folderclass :

folderMan, folderVideo,folderCrystal, folderLocked , folderText, folderFavorite, folderPrint,folderHtml,folderSentMail,folderImage,folderSound,folderImportant,folderTar,folderYellow ,folderGray folderGreen

folderSentMail is only in 16 px avaible.

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

			href => "http://www.google.de",

			text => 'Node',

		},

		{

			text => 'Folder',

			folderclass => 'folderMan', # only for Crystal styles
	
			subtree => [

				{

					text => 'TreeView.tigris.org',

					href => 'http://TreeView.tigris.org',

				},

			],

		},

	);

	my $TreeView = new HTML::Menu::TreeView();

	$TreeView->setStyle("bw");

	print $TreeView->css("/srv/www/httpdocs");

	print TreeView->jscript();

	print $TreeView->Tree(\@tree);

=head2 FO Syntax

	use HTML::Menu::TreeView qw(Tree css jscript setStyle setDocumentRoot);

	setDocumentRoot("/srv/www/httpdocs");

	print css();

	print jscript();

	print Tree(\@tree,"Crystal");

=head1 DESCRIPTION

HTML::Menu::TreeView is a Modul to build an Html tree of an AoH.

=head1 Changes

0.6.3	

-new Styles Cyrstal 64, 128 ( In the future no more styles will be added to this Modul, if there a different ones they will be avaible as a standalone package).

-preload.js files for preloading images.

0.6.2

-size lastNode 16 & 32 px

0.6.1

- new Styles Cyrstal 22, 48

- new function preload();

- Overwrought Dokumentation.

- Some fixes in installdocs and width ocpNode

- remove some unnecessary files.

0.6

- setClasic, setModern clasic ( alternate node decoration ).

- setSize ( new Style Cyrstal 32 ) 16 or 32 are possible.

- make installdocs 
  (install html documentation vor HTML::Menu::TreeView like http://treeview.lindnerei.de.
  Open /TreeView.html on your host into your browser after installation.)

- include some styles into Cyrstal.

- preload images for ie etc.

- delete unessesary files.

- new path for images

- make uninstalldocs

- Overwrought css


=head2  new()

my $TreeView = new HTML::Menu::TreeView(optional \@tree);

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

setStyle("style");

bw = Black & White Style

simple = redmond like style

Crystal = Crystal style

=cut

sub setStyle {
    my ($self, @p) = getSelf(@_);
    $style = $p[0];
}

=head2 setSize()

setSize(16);

currently 16 an 32 are possible values.

only for Crystal styles

=cut

sub setSize {
    my ($self, @p) = getSelf(@_);
    $size = $p[0];
}

=head2 setClasic()

use a classic node decoration 

(not for bw avaible).

=cut

sub setClasic {
    my ($self, @p) = getSelf(@_);
    $clasic = 1;
}

=head2 setModern()

use a classic node decoration 

(not for bw avaible).

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

sub setDocumentRoot{
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
    $path =  $p[0] if(defined $p[0]);
    my $fh   = gensym;
    my $file = "$path/style/$style/$size/html-menu-treeview/$style.css";
    open $fh, "$file" or warn "no style '$style.css' $style.css found \n  in  $path/style/html-menu-treeview/$style/ \n $!";
    seek $fh, 0, 0;
    my @lines = <$fh>;
    close $fh;
    my $css;
    for(@lines){
        $css .= $_;
    }
    return $css;
}

=head2 jscript()

return the necessary  javascript  without <script> tag.

You can also include it with

<script language="JavaScript1.5" type="text/javascript" src="/style/treeview.js"></script>

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


=cut

sub preload{
 my $preload = "
<script language=\"JavaScript\" type=\"text/javascript\">
//<!--
folderClosed = new Image($size,$size);
folderClosed.src='/style/$style/$size/html-menu-treeview/folderClosed.gif';
plusNodeClosed = new Image($size,$size);
plusNodeClosed.src='/style/$style/$size/html-menu-treeview/plusNodeClosed.gif';
lastPlusNodeClosed = new Image($size,$size);
lastPlusNodeClosed.src='/style/$style/$size/html-menu-treeview/lastPlusNodeClosed.gif';
clasicPlusNodeClosed = new Image($size,$size);
clasicPlusNodeClosed.src='/style/$style/$size/html-menu-treeview/clasicPlusNodeClosed.gif';
clasicLastPlusNodeClosed = new Image($size,$size);
clasicLastPlusNodeClosed.src='/style/$style/$size/html-menu-treeview/clasicLastPlusNodeClosed.gif';
";
if ($style eq "Crystal"){
$preload .= "
folderManClosed = new Image($size,$size);
folderManClosed.src='/style/$style/$size/html-menu-treeview/folderManClosed.gif';
folderGray = new Image($size,$size);
folderGray.src='/style/$style/$size/html-menu-treeview/folderGray.gif';
folderGreen = new Image($size,$size);
folderGreen.src='/style/$style/$size/html-menu-treeview/folderGreen.gif';
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

sub Tree{
    my ($self, @p) = getSelf(@_);
    $style = $p[1] if(defined $p[1]);
    $self->initTree(@p) if(@p);
    return '<table align="left" class="TreeView" border="0" cellpadding="0" cellspacing="0" summary="treeTable"  ><colgroup><col width="' . $size . '"></colgroup>' . $self->{tree} . '</table>';
}

sub initTree{
    my ($self, @p) = getSelf(@_);
    my $tree   = $p[0];
    my $length = @$tree;
    for(my $i = 0 ; $i < @$tree ; $i++){
        $length--;
        if(defined @{@$tree[$i]->{subtree}}) {
            if($length > 0){
                $self->appendFolder(@$tree[$i], \@{@$tree[$i]->{subtree}});
            }elsif($length eq 0){
                $self->appendLastFolder(@$tree[$i], \@{@$tree[$i]->{subtree}});
            }
        }else{
            if($length > 0){
                $self->appendNode(@$tree[$i]);
            } elsif ($length eq 0){
                $self->appendLastNode(@$tree[$i]);
            }
        }
    }
}

sub getSelf {
    return @_ if defined($_[0]) && (!ref($_[0])) && ($_[0] eq 'HTML::Menu::TreeView');
    return (defined($_[0]) && (ref($_[0]) eq 'HTML::Menu::TreeView' || UNIVERSAL::isa($_[0], 'HTML::Menu::TreeView'))) ? @_ : ($HTML::Menu::TreeView::DefaultClass->new, @_);
}

sub appendFolder{
    my $self    = shift;
    my $node    = shift;
    my $subtree = shift;
    ++$id;
    $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? "" : "displayTree('$id'); ocFolder('$id.folder');ocNode('$id.node');";
    $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
    my $FolderClass = defined $node->{folderclass} ? $node->{folderclass} : 'folderOpen';
    my $tt;
    foreach my $key (keys %{$node}) {
        $tt .= $key . '="' . $node->{$key} . '" ' unless ($key =~ /image|text|subtree|folderclass/);
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
    my $tt;
    foreach my $key (keys %{$node}) {
        $tt .= $key . '="' . $node->{$key} . '" ' unless ($key =~ /image|text|subtree|folderclass/);
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
    my $tt;
    foreach my $key (keys %{$node}) {
        $tt .= $key . '="' . $node->{$key} . '" ' unless ($key =~ /image|text|subtree|folderclass/);
    }
    my $paddingLeft = $size+ 2 . "px";
    $self->{tree} .=
      "<tr class=\"TreeViewItem\"><td  class=\"node\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\" align=\"middle\"/></td><td align=\"left\"  style=\"background-image:url('/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft\"><a $tt>$node->{text}</a></td></tr>";
}

sub appendLastNode{
    my $self = shift;
    my $node = shift;
    $node->{image} = defined $node->{image} ? $node->{image} : "link.gif";
    $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
    my $tt;
    foreach my $key (keys %{$node}) {
        $tt .= $key . '="' . $node->{$key} . '" ' unless ($key =~ /image|text|subtree|folderclass/);
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
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330,
Boston, MA  02111-1307, USA.

=cut

1;
