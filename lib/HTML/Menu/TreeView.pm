package HTML::Menu::TreeView;
use strict;
use warnings;
require Exporter;
use vars qw($DefaultClass %EXPORT_TAGS @EXPORT_OK @ISA %anker @TreeView);
$HTML::Menu::TreeView::VERSION     = '0.6.9';
@ISA                               = qw(Exporter);
@HTML::Menu::TreeView::EXPORT_OK   = qw(all Tree css jscript setStyle setDocumentRoot getDocumentRoot setSize setClasic clasic preload help folderFirst size style documentRoot loadTree saveTree  %anker sortTree orderBy);
%HTML::Menu::TreeView::EXPORT_TAGS = ('all' => [qw(Tree css jscript setStyle  setDocumentRoot getDocumentRoot setSize setClasic clasic preload help folderFirst  size style documentRoot  loadTree saveTree  %anker sortTree orderBy)]);
$DefaultClass                      = 'HTML::Menu::TreeView' unless defined $HTML::Menu::TreeView::DefaultClass;
our $id       = "a";
our $style    = "Crystal";
our $size     = "16";
our $path     = '.';
our $clasic   = 0;
our $ffirst   = 0;
our $sort     = 0;
our $saveFile = "./TreeViewDump.pl";
our $orderby  = 'text';

%anker = (
          href        => 'URI for linked resource',
          accesskey   => 'accessibility key character',
          charset     => 'char encoding of linked resource',
          class       => 'class name or set of class names to an element.',
          coords      => 'for use with client-side image maps',
          dir         => 'the base direction of directionally neutral text',
          hreflang    => 'language code',
          lang        => 'the base language of an elements attribute values and text content.',
          onblur      => 'the element lost the focus',
          ondblclick  => 'event occurs when the pointing device button is double clicked ',
          onclick     => 'event occurs when the pointing device button is clicked over an element',
          onfocus     => 'the element got the focus',
          onkeydown   => 'event occurs when a key is pressed down over an element.',
          onkeypress  => 'event occurs when a key is pressed and released over an element.',
          onkeyup     => 'event occurs when a key is released over an element.',
          onmousedown => 'event occurs when the pointing device button is pressed over an element.',
          onmousemove => 'event occurs when the pointing device is moved while it is over an element.',
          onmouseout  => 'event occurs when the pointing device is moved away from an element.',
          onmouseover => 'event occurs when the pointing device is moved onto an element.',
          onmouseup   => 'event occurs when the pointing device button is released over an element.',
          rel         => 'forward link types',
          rev         => 'reverse link types',
          shape       => 'for use with client-side image maps',
          style       => 'specifies style information for the current element.',
          tabindex    => 'position in tabbing order',
          target      => 'target frame information)',
          type        => 'advisory content type ',
          title       => 'element title',
          id          => 'This attribute assigns a name to an element. This name must be unique in a document.',
);

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

	Tree(\@tree);

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

					href => 'http://treeview.tigris.org',

				},

			],

		},

	);

	my $Treeview = new HTML::Menu::TreeView();

	print $Treeview->css("/srv/www/httpdocs");

	print $Treeview->jscript();
	
	print $Treeview->preload();

	print $Treeview->Tree(\@tree);


reserved attributes:

href  URI for linked resource.

accesskey  accessibility key character.

charset  char encoding of linked resource.

class  class name or set of class names to an element.

coords  for use with client-side image maps.

dir    the base direction of directionally neutral text.

hreflang  language code.

lang  the base language of an elements attribute values and text content.

onblur  the element lost the focus.

ondblclick  event occurs when the pointing device button is double clicked 

onclick   event occurs when the pointing device button is clicked over an element.

onfocus   the element got the focus.

onkeydown  event occurs when a key is pressed down over an element.

onkeypress  event occurs when a key is pressed and released over an element.

onkeyup  event occurs when a key is released over an element.

onmousedown  event occurs when the pointing device button is pressed over an element.

onmousemove  event occurs when the pointing device is moved while it is over an element.

onmouseout  event occurs when the pointing device is moved away from an element.

onmouseover  event occurs when the pointing device is moved onto an element.

onmouseup  event occurs when the pointing device button is released over an element.

rel  forward link types.

rev    reverse link types.

shape  for use with client-side image maps.

style  specifies style information for the current element.

tabindex  position in tabbing order.

target  target frame information.

type  advisory content type.

title    element title.

id    This attribute assigns a name to an element. This name must be unique in a document.

and subtree and image.

Possible values for folderclass :

folderMan, folderVideo,folderCrystal,

folderLocked , folderText, folderFavorite,

folderPrint,folderHtml,folderSentMail,

folderImage,folderSound,folderImportant,

folderTar,folderYellow ,folderGray,

folderGreen and  folderRed

see http://treeview.lindnerei.de/cgi-bin/crystal.pl for a complete list of possible values for folderclass.

=head2 FO Syntax

	use HTML::Menu::TreeView qw(:all);

	documentRoot("/srv/www/httpdocs");

	print css();

	print jscript();

	print Tree(\@tree,"Crystal");

=head1 DESCRIPTION

HTML::Menu::TreeView is a Modul to build an Html tree of an AoH.

=head1 Changes

0.6.9

preload returns the treeview without <script> tag.

new function folderFirst, documentRoot, size, style,loadTree,saveTree,sortTree,orderBy

new usage for clasic().

new example folderFirst.pl (sort the TreeView)

Overwrought Code,Examples, tests and Documentation.

more tests. (test pod and new functions).

=head1 Public

=head2 clasic()

enable clasic  node decoration:

clasic(1);

disable clasic  node decoration:

clasic(0);

return the status in void context.

$status = clasic();

=cut

sub clasic {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(01)/) {
                $clasic = $1;
        } else {
                return $clasic;
        }
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
        $self->documentRoot($p[0]) if(defined $p[0]);
        my $fh   = gensym;
        my $file = "$path/style/$style/$size/html-menu-treeview/$style.css";
        open $fh, "$file" or warn "no style '$style.css' $style.css found $/  in  $path/style/html-menu-treeview/$style/ $/ $! $/";
        seek $fh, 0, 0;
        my @lines = <$fh>;
        close $fh;
        my $css;

        for(@lines) {
                $css .= $_;
        }
        return $css;
}

=head2 documentRoot()

set the Document Root in scalar context, or get it in void context.

default: .

=cut

sub documentRoot {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0]) {
                if(-e $p[0]) {
                        $path = $p[0];
                } else {
                        warn "Document Root don't exits: $/ $! $/";
                }
        } else {
                return $path;
        }
}

=head2 folderFirst()

set or unset show folders first ?

default is false.

enable show folders first:

folderFirst(1);

disable show folders first:

folderFirst(0);

return the status of this property in void context.

$status = folderFirst();

=cut

sub folderFirst {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(0|1)/) {
                $ffirst = $1;
        } else {
                return $ffirst;
        }
}

=head2 getDocumentRoot()

for backward compatibility.

use documentRoot instead.

=cut

sub getDocumentRoot {
        return $path;
}

=head2 help()

help for link attributes.

return a hashref in void context,

	my $hashref =  help();

	foreach my $key (sort(keys %{$hashref})){

		print "$key : ", $hashref->{$key} ,$/;

	}

or a help Message.

	print help('href'),$/;

=cut

sub help {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0]) {
                return (defined $anker{$p[0]}) ? $anker{$p[0]} : "Unknown attribute !$/";
        } else {
                return \%anker;
        }
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

=head2 loadTree()

	loadTree('filename') or loadTree()

default: ./TreeViewDump.pl

=cut

sub loadTree {
        my ($self, @p) = getSelf(@_);
        my $do = (defined $p[0]) ? $p[0] : $saveFile;
        do $do if(-e $do);
}

=head2  new()

if you use the oo interface you can say:

	my @TreeView = new HTML::Menu::TreeView(\@tree, optional style);

and then call Tree without arguments.

	print @TreeView->Tree();

=cut

sub new {
        my ($class, @initializer) = @_;
        my $self = {tree => undef,};
        bless $self, ref $class || $class || $DefaultClass;
        $style    = $initializer[1] if(defined $initializer[1]);
        @TreeView = $initializer[0] if(@initializer);
        return $self;
}

=head2 orderBy()

set the attribute which is used by sortTree and folderFirst.

=cut

sub orderBy {
        my ($self, @p) = getSelf(@_);
        $orderby = $p[0];
}

=head2 preload()

return the necessary  javascript for preloading images  without <script> tag.

for example you can also include it with

<script language="JavaScript" type="text/javascript" src="/style/Crystal/16/html-menu-treeview/preload.js"></script>

or

<script language="JavaScript" type="text/javascript" src="/style/Crystal/preload.js"></script>

if you use different images sizes.

=cut

sub preload {
        my $preload = "
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
        return $preload;
}

=head2 saveTree()

	saveTree('filename') or saveTree()

default: ./TreeViewDump.pl

=cut

sub saveTree {
        my ($self, @p) = getSelf(@_);
        use Data::Dumper;
        my $content = Dumper(@TreeView);
        $content .= '@TreeView = $VAR1;';
        my $saveAs = defined $p[0] ? $p[0] : $saveFile;
        @TreeView = defined $p[1] ? $p[1] : @TreeView;
        use Fcntl qw(:flock);
        use Symbol;
        my $fh = gensym();
        my $rsas = $saveAs =~ /^(\S+)$/ ? $1 : 0;

        if($rsas) {
                open $fh, ">$rsas.bak" or warn "HTML::menu::TreeView::saveTree $/ $! $/ $rsas $/";
                flock $fh, 2;
                seek $fh, 0, 0;
                truncate $fh, 0;
                print $fh $content;
                close $fh;
        }
        if(-e "$rsas.bak") {
                rename "$rsas.bak", $rsas or warn "HTML::menu::TreeView::saveTree $/ $! $/";
                do $rsas;
        }
}

=head2 setClasic()

use clasic instead.

for backward compatibility.

use a classic node decoration

=cut

sub setClasic {
        my ($self, @p) = getSelf(@_);
        $clasic = 1;
}

=head2 setDocumentRoot()

for backward compatibility.

use documentRoot instead.

set the local path to the style folder.

should be the document root of the webserver.

example: setDocumentRoot('/srv/www/htdocs');

default: /srv/www/htdocs

=cut

sub setDocumentRoot {
        my ($self, @p) = getSelf(@_);
        $self->documentRoot($p[0]);
}

=head2 setModern()

use clasic instead.

for backward compatibility.

use a modern  node decoration

=cut

sub setModern {
        my ($self, @p) = getSelf(@_);
        $clasic = 0;
}

=head2 setSize()

for backward compatibility.

use size instead.

only for Crystal styles

16,32,48,64 and 128  are possible values.

=cut

sub setSize {
        my ($self, @p) = getSelf(@_);
        $size = $p[0];
}

=head2 setStyle()

for backward compatibility.

use style instead.

setStyle('style');

simple = redmond like style

Crystal = Crystal style

=cut

sub setStyle {
        my ($self, @p) = getSelf(@_);

        $style = $p[0];
}

=head2 size()

only for Crystal styles

set the size in scalar context, or get in void context.

16,32,48,64 and 128  are possible values.

=cut

sub size {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(16|32|48|64|128)/) {
                $size = $1;
        } else {
                return $size;
        }
}

=head2 sortTree()

set or unset sorting treeview Items.

default is false.

enable sorting:

	sortTree(1);

disable sorting:

	sortTree(0);

return the status in void context.

$status = sortTree();

=cut

sub sortTree {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(0|1)/) {
                $sort = $1;
        } else {
                return $sort;
        }
}

=head2 style()

set the style in scalar context, or get in void context.

	setStyle('simple');

simple = redmond like style.

Crystal = Crystal style (default).

=cut

sub style {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0]) {
                if(-e $path . '/style/' . $p[0]) {
                        $style = $p[0];
                } else {
                        warn "$path . '/style/' . $p[0] not found";
                }
        } else {
                return $style;
        }
}

=head2 Tree()

	Tree(\@tree,optional $style);

Returns the html part of the Treeview without javasript and css.

=cut

sub Tree {
        my ($self, @p) = getSelf(@_);
        $style = $p[1] if(defined $p[1]);
        @TreeView = @p ? @p : @TreeView;
        $self->initTree(@TreeView) if(@TreeView);
        return '<table align="left" class="TreeView" border="0" cellpadding="0" cellspacing="0" summary="treeTable"  ><colgroup><col width="' . $size . '"></colgroup>' . $self->{tree} . '</table>';
}

=head1 Private

=head2 initTree()

=cut

sub initTree {
        my ($self, @p) = getSelf(@_);
        my $tree = $p[0];

        if($ffirst) {
                my @tr = sort {&ffolderFirst} @$tree;
                $tree = \@tr;
        } elsif ($sort) {
                my @tr = sort {lc($a->{$orderby}) cmp lc($b->{$orderby})} @$tree;
                $tree = \@tr;
        }
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

=head2 ffolderFirst()

=cut

        # wegen use strict innerhalb von initTree
        sub ffolderFirst {
                no warnings;
              SWITCH: {
                        if(defined @{$a->{subtree}} and defined @{$b->{subtree}}) {
                                return lc($a->{$orderby}) cmp lc($b->{$orderby});
                                last SWITCH;
                        } elsif (defined @{$a->{subtree}}) {
                                return -1;
                                last SWITCH;
                        } elsif (defined @{$b->{subtree}}) {
                                return +1;
                                last SWITCH;
                        } else {
                                return $sort ? (lc($a->{$orderby}) cmp lc($b->{$orderby})) : -1;
                        }
                }
        }
}

=head2 getSelf()

=cut

sub getSelf {
        return @_ if defined($_[0]) && (!ref($_[0])) && ($_[0] eq 'HTML::Menu::TreeView');
        return (defined($_[0]) && (ref($_[0]) eq 'HTML::Menu::TreeView' || UNIVERSAL::isa($_[0], 'HTML::Menu::TreeView'))) ? @_ : ($HTML::Menu::TreeView::DefaultClass->new, @_);
}

=head2 appendFolder()

=cut

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
                $tt .= $key . '="' . $node->{$key} . '" ' if(exists $anker{$key});
        }
        my $minusnode = $clasic ? "clasicMinusNode" : "minusNode";
        $self->{tree} .=
          "<tr class=\"trSubtreeCaption\"><td  id=\"$id.node\" class=\"$minusnode\" onclick=\"displayTree('$id'); ocFolder('$id.folder');ocNode('$id.node');\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td align=\"left\" class=\"$FolderClass\" id=\"$id.folder\"><a $tt>$node->{text}</a></td></tr><tr id=\"$id\" class=\"trSubtree\"><td class=\"submenuDeco\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" alt=\"spacer\"/></td><td class=\"submenu\"><table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><colgroup><col width=\"$size\"></colgroup>";
        $self->initTree(\@$subtree);
        $self->{tree} .= "</table></td></tr>";
}

=head2 appendLastFolder()

=cut

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
                $tt .= $key . '="' . $node->{$key} . '" ' if(exists $anker{$key});
        }
        my $lastminusnode = $clasic ? "clasicLastMinusNode" : "lastMinusNode";
        $self->{tree} .=
          "<tr class=\"lastTreeViewItem\"><td id=\"$id.node\" class=\"$lastminusnode\" onclick=\"displayTree('$id');ocFolder('$id.folder');ocpNode('$id.node');\"></td><td align=\"left\" class=\"$FolderClass\" id=\"$id.folder\"><a $tt>$node->{text}</a></td></tr><tr id=\"$id\" class=\"trSubtree\"><td ><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td class=\"submenu\"><table align=\"left\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"subtreeTable\" summary=\"appendLastFolder\"><colgroup><col width=\"$size\"></colgroup>";
        $self->initTree(\@$subtree);
        $self->{tree} .= "</table></td></tr>";
}

=head2 appendNode()

=cut

sub appendNode {
        my $self = shift;
        my $node = shift;
        $node->{image} = defined $node->{image} ? $node->{image} : "link.gif";
        $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
        $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
        my $tt;
        foreach my $key (keys %{$node}) {
                $tt .= $key . '="' . $node->{$key} . '" ' if(exists $anker{$key});
        }
        my $paddingLeft = $size+ 2 . "px";
        $self->{tree} .=
          "<tr class=\"TreeViewItem\"><td  class=\"node\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\" align=\"middle\"/></td><td align=\"left\"  style=\"background-image:url('/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft\"><a $tt>$node->{text}</a></td></tr>";
}

=head2 appendLastNode()

=cut

sub appendLastNode {
        my $self = shift;
        my $node = shift;
        $node->{image} = defined $node->{image} ? $node->{image} : "link.gif";
        $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
        $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
        my $tt;
        foreach my $key (keys %{$node}) {
                $tt .= $key . '="' . $node->{$key} . '" ' if(exists $anker{$key});
        }
        my $paddingLeft = $size+ 2 . "px";
        $self->{tree} .=
          "<tr class=\"TreeViewItem\"><td  class=\"lastNode\"><img src=\"/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td align=\"left\"  style=\"background-image:url('/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft;\"><a $tt>$node->{text}</a></td></tr>";
}

=head1 SEE ALSO

http://www.lindnerei.de, http://treeview.lindnerei.de,

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
