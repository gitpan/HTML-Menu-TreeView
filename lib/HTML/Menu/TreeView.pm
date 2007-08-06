package HTML::Menu::TreeView;
use strict;
use warnings;
require Exporter;
use vars qw($DefaultClass %EXPORT_TAGS @EXPORT_OK @ISA %anker @TreeView);
$HTML::Menu::TreeView::VERSION   = '0.7.3';
@ISA                             = qw(Exporter);
@HTML::Menu::TreeView::EXPORT_OK = qw(all Tree css jscript setStyle setDocumentRoot getDocumentRoot setSize setClasic clasic preload help folderFirst size style documentRoot loadTree saveTree  %anker sortTree orderBy prefix);
%HTML::Menu::TreeView::EXPORT_TAGS = (
                                      'all'       => [qw(Tree css jscript setStyle  setDocumentRoot getDocumentRoot setSize setClasic clasic preload help folderFirst  size style documentRoot  loadTree saveTree  %anker sortTree orderBy prefix)],
                                      'recommend' => [qw(Tree css jscript clasic preload folderFirst size style documentRoot  loadTree saveTree sortTree orderBy prefix)],
                                      'standart'  => [qw(Tree css jscript preload size style documentRoot )],
);
$DefaultClass = 'HTML::Menu::TreeView' unless defined $HTML::Menu::TreeView::DefaultClass;
our $id       = 'a';
our $style    = 'Crystal';
our $size     = 16;
our $path     = '%PATH%';
our $clasic   = 0;
our $ffirst   = 0;
our $sort     = 0;
our $saveFile = './TreeViewDump.pl';
our $orderby  = 'text';
our $pref     = '';
our $columns  = 0;

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

=head2 FO Syntax

	use HTML::Menu::TreeView qw(:all);

	documentRoot("/srv/www/httpdocs");

	print css();

	print jscript();

	print Tree(\@tree,"Crystal");


=head3 function sets 

Here is a list of the function sets you can import:

:all

:recommend

Tree css jscript clasic preload folderFirst size style documentRoot  loadTree saveTree sortTree orderBy prefix

:standart

Tree css jscript preload size style documentRoot

=head3 reserved attributes:

=over

=item href

URI for linked resource.

=item accesskey

accessibility key character.

=item charset

char encoding of linked resource.

=item class

class name or set of class names to an element.

=item coords

for use with client-side image maps.

=item dir

the base direction of directionally neutral text.

=item hreflang

language code.

=item lang

the base language of an elements attribute values and text content.

=item onblur

the element lost the focus.

=item ondblclick

event occurs when the pointing device button is double clicked 

=item onclick

event occurs when the pointing device button is clicked over an element.

=item onfocus

the element got the focus.

=item onkeydown

event occurs when a key is pressed down over an element.

=item onkeypress

event occurs when a key is pressed and released over an element.

=item onkeyup

event occurs when a key is released over an element.

=item onmousedown

event occurs when the pointing device button is pressed over an element.

=item onmousemove

event occurs when the pointing device is moved while it is over an element.

=item onmouseout

event occurs when the pointing device is moved away from an element.

=item onmouseover

event occurs when the pointing device is moved onto an element.

=item onmouseup

event occurs when the pointing device button is released over an element.

=item rel

forward link types.

=item rev

reverse link types.

=item shape

for use with client-side image maps.

=item style

specifies style information for the current element.

=item tabindex

position in tabbing order.

=item target

target frame information.

=item type

advisory content type.

=item title

element title.

=item id

This attribute assigns a name to an element. This name must be unique in a document.

=item addition

additional text behind the link

=item subtree

an array of TreeView Items

subtree => {{text => 'Fo'},{text => 'Bar'} ],

=item image.

a image name, must be placed into /style/mimetypes directory.

=item folderclass :

only for Crystal styles

possible values:

folderMan, folderVideo,folderCrystal,

folderLocked , folderText, folderFavorite,

folderPrint,folderHtml,

folderImage,folderSound,folderImportant,

folderTar,folderYellow ,folderGray,

folderGreen and  folderRed

see http://treeview.lindnerei.de/cgi-bin/crystal.pl for a complete list of possible values for folderclass.

=item columns

an array of columns

columns => [ 1,2,3,4,5]

=back

=head1 DESCRIPTION

HTML::Menu::TreeView is a Modul to build an Html tree of an AoH.

=head1 Changes

0.7.3

Cleanup TreeView.pm

=head1 Public

=head2 clasic

enable clasic  node decoration:

clasic(1);

disable clasic  node decoration:

clasic(0);

return the status in void context.

$status = clasic();

=cut

sub clasic {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(0|1)/) {
                $clasic = $1;
        } else {
                return $clasic;
        }
}

=head2 columns

set number of columns

columns(3);

return the count in void context.

$count = columns();

=cut

sub columns {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(\d+)/) {
                $columns = $1;
        } else {
                return $columns;
        }
}

=head2 css

return the  necessary css part without <style></style> tag.

you can set the DocumentRoot if you pass a parameter

css('/document/root/');

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

        foreach my $l (@lines) {
                $l =~ s?/style/?$pref/style/?g;
                $css .= $l;
        }
        return $css;
}

=head2 documentRoot

set the Document Root in scalar context, or get it in void context.

default: this variable is set during make.

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

=head2 folderFirst

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

=head2 getDocumentRoot

for backward compatibility.

use documentRoot instead.

=cut

sub getDocumentRoot {
        return $path;
}

=head2 help

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

=head2 jscript

return the necessary  javascript  without <script> tag.

You can also include it with:

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
if(document.getElementById(id)){
var e = document.getElementById(id);
var display = e.style.display;
if(display == \"none\"){
e.style.display = \"\";
}else if(display == \"\"){
e.style.display = \"none\";
}
}
}
function replaceClass(mid){
var obj;
if(document.all){
obj = document.all;
}else if(document.getElementsByTagName && !document.all){
obj = document.getElementsByTagName('*');
}
for(i=0; i < obj.length; i++){
if(obj[i].className == 'columnsFolderClosed' && obj[i].id.indexOf('td'+mid)!=-1 ){
obj[i].className = 'columnsFolder';
}else if(obj[i].className == 'columnsFolder' && obj[i].id.indexOf('td'+mid)!=-1 ){
obj[i].className = 'columnsFolderClosed';
}
}
}
";
}

=head2 loadTree

loadTree('filename') or loadTree()

default: ./TreeViewDump.pl

=cut

sub loadTree {
        my ($self, @p) = getSelf(@_);
        my $do = (defined $p[0]) ? $p[0] : $saveFile;
        do $do if(-e $do);
}

=head2  new

if you use the oo interface you can say:

my $TreeView = new HTML::Menu::TreeView(\@tree, optional style);

and then call Tree without arguments.

print $TreeView->Tree();

=cut

sub new {
        my ($class, @initializer) = @_;
        my $self = {tree => undef,};
        bless $self, ref $class || $class || $DefaultClass;
        $style    = $initializer[1] if(defined $initializer[1]);
        @TreeView = $initializer[0] if(@initializer);
        return $self;
}

=head2 orderBy

set the attribute which is used by sortTree and folderFirst.

=cut

sub orderBy {
        my ($self, @p) = getSelf(@_);
        $orderby = $p[0];
}

=head2 prefix

prefix used by css.

set this if you want to build offline websites.

for example:

prefix('.');

return the prefix in void context.

=cut

sub prefix {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0]) {
                $pref = $p[0];
        } else {
                return $pref;
        }
}

=head2 preload

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
folderClosed.src='$pref/style/$style/$size/html-menu-treeview/folderClosed.gif';
plusNode = new Image($size,$size);
plusNode.src='$pref/style/$style/$size/html-menu-treeview/plusNode.gif';
lastPlusNode = new Image($size,$size);
lastPlusNode.src='$pref/style/$style/$size/html-menu-treeview/lastPlusNode.gif';
clasicplusNode = new Image($size,$size);
clasicplusNode.src='$pref/style/$style/$size/html-menu-treeview/clasicPlusNode.gif';
clasicLastplusNode = new Image($size,$size);
clasicLastplusNode.src='$pref/style/$style/$size/html-menu-treeview/clasicLastPlusNode.gif';
";
        if($style eq "Crystal") {
                $preload .= "
folderGrayClosed = new Image($size,$size);
folderGrayClosed.src='$pref/style/$style/$size/html-menu-treeview/folderGrayClosed.gif';
folderGreenClosed = new Image($size,$size);
folderGreenClosed.src='$pref/style/$style/$size/html-menu-treeview/folderGreenClosed.gif';
folderRedClosed = new Image($size,$size);
folderRedClosed.src='$pref/style/$style/$size/html-menu-treeview/folderRedClosed.gif';
folderViolet = new Image($size,$size);
folderViolet.src='$pref/style/$style/$size/html-menu-treeview/folderViolet.gif';
folderYellowClosed = new Image($size,$size);
folderYellowClosed.src='$pref/style/$style/$size/html-menu-treeview/folderYellowClosed.gif';
folderOrangeClosed = new Image($size,$size);
folderOrangeClosed.src='$pref/style/$style/$size/html-menu-treeview/folderOrangeClosed.gif';
folderPrintClosed = new Image($size,$size);
folderPrintClosed.src='$pref/style/$style/$size/html-menu-treeview/folderPrintClosed.gif';";
                $preload .= "
folderManClosed = new Image($size,$size);
folderManClosed.src='$pref/style/$style/$size/html-menu-treeview/folderManClosed.gif';
folderHtmlClosed = new Image($size,$size);
folderHtmlClosed.src='$pref/style/$style/$size/html-menu-treeview/folderHtmlClosed.gif';
folderFavoriteClosed = new Image($size,$size);
folderFavoriteClosed.src='$pref/style/$style/$size/html-menu-treeview/folderFavoriteClosed.gif';
folderTextClosed = new Image($size,$size);
folderTextClosed.src='$pref/style/$style/$size/html-menu-treeview/folderTextClosed.gif';
folderLockedClosed = new Image($size,$size);
folderLockedClosed.src='$pref/style/$style/$size/html-menu-treeview/folderLockedClosed.gif';
folderCrystalClosed = new Image($size,$size);
folderCrystalClosed.src='$pref/style/$style/$size/html-menu-treeview/folderCrystalClosed.gif';
folderVideoClosed = new Image($size,$size);
folderVideoClosed.src='$pref/style/$style/$size/html-menu-treeview/folderVideoClosed.gif';
folderManClosed = new Image($size,$size);
folderManClosed.src='$pref/style/$style/$size/html-menu-treeview/folderManClosed.gif';
folderImageClosed = new Image($size,$size);
folderImageClosed.src='$pref/style/$style/$size/html-menu-treeview/folderImageClosed.gif';
folderSoundClosed = new Image($size,$size);
folderSoundClosed.src='$pref/style/$style/$size/html-menu-treeview/folderSoundClosed.gif';
folderImportantClosed = new Image($size,$size);
folderImportantClosed.src='$pref/style/$style/$size/html-menu-treeview/folderImportantClosed.gif';
folderTarClosed = new Image($size,$size);
folderTarClosed.src='$pref/style/$style/$size/html-menu-treeview/folderTarClosed.gif';
" if($size != 22);
        }
        return $preload;
}

=head2 saveTree

saveTree('filename',\@ref) or saveTree()


default: this property is set during make

=cut

sub saveTree {
        my ($self, @p) = getSelf(@_);
        my $saveAs = defined $p[0] ? $p[0] : $saveFile;
        @TreeView = defined $p[1] ? $p[1] : @TreeView;
        use Data::Dumper;
        my $content = Dumper(@TreeView);
        $content .= '@TreeView = $VAR1;';
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

=head2 setClasic

use clasic instead.

for backward compatibility.

use a classic node decoration

=cut

sub setClasic {
        $clasic = 1;
}

=head2 setDocumentRoot

for backward compatibility.

use documentRoot instead.

set the local path to the style folder.

should be the Document Root of your webserver.

example: setDocumentRoot('%PATH%');

dafault: this property is set during make

=cut

sub setDocumentRoot {
        my ($self, @p) = getSelf(@_);
        $self->documentRoot($p[0]);
}

=head2 setModern

use clasic instead.

for backward compatibility.

use a modern  node decoration

=cut

sub setModern {
        $clasic = 0;
}

=head2 setSize

for backward compatibility.

use size instead.

only for Crystal styles

16,32,48,64 and 128  are possible values.

=cut

sub setSize {
        my ($self, @p) = getSelf(@_);
        $self->size($p[0]);
}

=head2 setStyle

for backward compatibility.

use style instead.

setStyle('style');

simple = redmond like style

Crystal = Crystal style

=cut

sub setStyle {
        my ($self, @p) = getSelf(@_);
        $self->style($p[0]);
}

=head2 size

only for Crystal styles

set the size in scalar context, or get in void context.

16,32,48,64 and 128  are possible values.

=cut

sub size {
        my ($self, @p) = getSelf(@_);
        if(defined $p[0] && $p[0] =~ /(16|22|32|48|64|128)/) {
                $size = $1;
        } else {
                return $size;
        }
}

=head2 sortTree

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

=head2 style

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

=head2 Tree

Tree(\@tree,optional $style);

Returns the html part of the Treeview without javasript and css.

=cut

sub Tree {
        my ($self, @p) = getSelf(@_);
        $style = $p[1] if(defined $p[1]);
        @TreeView = @p ? @p : @TreeView;
        $self->initTree(@TreeView) if(@TreeView);
        my $r =
          '<table align="left" class="TreeView" border="0" cellpadding="2" cellspacing="1" summary="treeTable"  ><tr><td><table align="left" class="TreeView" border="0" cellpadding="0" cellspacing="0" summary="treeTable" width="100%" ><colgroup><col width="'
          . $size
          . '"></colgroup>'
          . $self->{tree}
          . '</table></td>';
        $r .= '<td><table align="left" class="TreeView" border="0" cellpadding="0" cellspacing="0" summary="treeTable" width="100%" >' . $self->{subtree} . '</table></td>' if(defined $self->{subtree});
        $r .= '</tr></table>';
        return $r;
}

=head1 Private

=head2 initTree

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
                if(defined @$tree[$i]) {
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

=head2 ffolderFirst

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

=head2 getSelf

HTML::Menu::TreeView Module use a Lincoln loader like class system.

if the first parameter is a HTML::Menu::TreeView object (oo syntax ) this function returns the given parameters.

or the first parameter it is not a object referenz (fo syntax) it create a new HTML::Menu::TreeView object,

return it as first value  and  @_  as the second value .

my ($self, @p) = getSelf(@_);

=cut

sub getSelf {
        return @_ if defined($_[0]) && (!ref($_[0])) && ($_[0] eq 'HTML::Menu::TreeView');
        return (defined($_[0]) && (ref($_[0]) eq 'HTML::Menu::TreeView' || UNIVERSAL::isa($_[0], 'HTML::Menu::TreeView'))) ? @_ : ($HTML::Menu::TreeView::DefaultClass->new, @_);
}

=head2 appendFolder

=cut

sub appendFolder {
        my $self    = shift;
        my $node    = shift;
        my $subtree = shift;
        ++$id;
        $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? "" : "displayTree('$id');displayTree('columns$id'); ocFolder('$id.folder');ocNode('$id.node');replaceClass('$id');";
        $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
        my $FolderClass = defined $node->{folderclass} ? $node->{folderclass} : 'folderOpen';
        $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
        my $tt;

        foreach my $key (keys %{$node}) {
                $tt .= $key . '="' . $node->{$key} . '" ' if(exists $anker{$key});
        }
        my $addon =
          defined $node->{addition}
          ? "<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><td><a $tt>$node->{text}</a></td><td>" . $node->{addition} . '</td></tr></table>'
          : "<a $tt>$node->{text}</a>";
        my $minusnode = $clasic ? "clasicMinusNode" : "minusNode";
        $self->{tree} .=
          "<tr class=\"trSubtreeCaption\"><td  id=\"$id.node\" class=\"$minusnode\" onclick=\"displayTree('$id');displayTree('columns$id'); ocFolder('$id.folder');ocNode('$id.node');replaceClass('$id');\"><img src=\"$pref/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td align=\"left\" class=\"$FolderClass\" id=\"$id.folder\">$addon</td></tr><tr id=\"$id\" class=\"trSubtree\"><td class=\"submenuDeco\"><img src=\"$pref/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" alt=\"spacer\"/></td><td class=\"submenu\"><table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><colgroup><col width=\"$size\"></colgroup>";
        if($columns > 0) {
                $self->{subtree} .= "<tr>";
                for(my $i = 0 ; $i < $columns ; $i++) {
                        my $txt = $node->{columns}[$i];
                        $txt =~ s/ /&#160;/g;
                        $self->{subtree} .= '<td class="columnsFolder" id="td' . $id . 'td' . $i . '">' . $txt . '</td>';
                }
                $self->{subtree} .= '</tr>';
                $self->{subtree} .= "<tr id=\"columns$id\" ><td colspan=\"$columns\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\">";
        }
        $self->initTree(\@$subtree);
        $self->{subtree} .= "</table></td></tr>" if($columns > 0);
        $self->{tree} .= "</table></td></tr>";
}

=head2 appendLastFolder

=cut

sub appendLastFolder {
        my $self    = shift;
        my $node    = shift;
        my $subtree = shift;
        $id++;
        $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? "" : "displayTree('$id');displayTree('columns$id'); ocFolder('$id.folder');ocpNode('$id.node');replaceClass('$id');";
        $node->{class} = defined $node->{class} ? $node->{class} : 'treeviewLink';
        my $FolderClass = defined $node->{FolderClass} ? $node->{FolderClass} : 'folderOpen';
        $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
        my $tt;

        foreach my $key (keys %{$node}) {
                $tt .= $key . '="' . $node->{$key} . '" ' if(exists $anker{$key});
        }
        my $addon =
          defined $node->{addition}
          ? "<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><td><a $tt>$node->{text}</a></td><td>" . $node->{addition} . '</td></tr></table>'
          : "<a $tt>$node->{text}</a>";
        my $lastminusnode = $clasic ? "clasicLastMinusNode" : "lastMinusNode";
        $self->{tree} .=
          "<tr class=\"lastTreeViewItem\"><td id=\"$id.node\" class=\"$lastminusnode\" onclick=\"displayTree('$id');displayTree('columns$id');ocFolder('$id.folder');ocpNode('$id.node');replaceClass('$id');\"></td><td align=\"left\" class=\"$FolderClass\" id=\"$id.folder\">$addon</td></tr><tr id=\"$id\" class=\"trSubtree\"><td ><img src=\"$pref/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td class=\"submenu\"><table align=\"left\" width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"subtreeTable\" summary=\"appendLastFolder\"><colgroup><col width=\"$size\"></colgroup>";
        if($columns > 0) {
                $self->{subtree} .= "<tr>";
                for(my $i = 0 ; $i < $columns ; $i++) {
                        my $txt = $node->{columns}[$i];
                        $txt =~ s/ /&#160;/g;
                        $self->{subtree} .= '<td class="columnsFolder" id="td' . $id . 'td' . $i . '">' . $txt . '</td>';
                }
                $self->{subtree} .= "</tr><tr id=\"columns$id\" ><td colspan=\"$columns\"><table border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\">";
        }
        $self->initTree(\@$subtree);
        $self->{subtree} .= "</table></td></tr>" if($columns > 0);
        $self->{tree} .= "</table></td>";
}

=head2 appendNode

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
        my $addon =
          defined $node->{addition}
          ? "<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><td><a $tt>$node->{text}</a></td><td>" . $node->{addition} . '</td></tr></table>'
          : "<a $tt>$node->{text}</a>";
        my $paddingLeft = $size+ 2 . "px";
        $self->{tree} .=
          "<tr class=\"TreeViewItem\"><td  class=\"node\"><img src=\"$pref/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\" align=\"middle\"/></td><td align=\"left\"  style=\"background-image:url('$pref/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft\">$addon</td></tr>";
        if($columns > 0) {
                $self->{subtree} .= "<tr >";
                for(my $i = 0 ; $i < $columns ; $i++) {
                        my $txt = $node->{columns}[$i];
                        $txt =~ s/ /&#160;/g;
                        $self->{subtree} .= '<td class="columnsNode">' . $txt . '</td>';
                }
                $self->{subtree} .= "</tr>";
        }
}

=head2 appendLastNode

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
        my $addon =
          defined $node->{addition}
          ? "<table align=\"left\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"  class=\"subtreeTable\" summary=\"appendFolder\" width=\"100%\"><td><a $tt>$node->{text}</a></td><td>" . $node->{addition} . '</td></tr></table>'
          : "<a $tt>$node->{text}</a>";
        my $paddingLeft = $size+ 2 . "px";
        $self->{tree} .=
          "<tr class=\"TreeViewItem\"><td  class=\"lastNode\"><img src=\"$pref/style/$style/$size/html-menu-treeview/spacer.gif\" border=\"0\" width=\"$size\" height=\"$size\" alt=\"spacer\"/></td><td align=\"left\"  style=\"background-image:url('$pref/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft;\">$addon</td></tr>";
        if($columns > 0) {
                $self->{subtree} .= "<tr >";
                for(my $i = 0 ; $i < $columns ; $i++) {
                        my $txt = $node->{columns}[$i];
                        $txt =~ s/ /&#160;/g;
                        $self->{subtree} .= '<td class="columnsLastNode">' . $txt . '</td>';
                }
                $self->{subtree} .= "</tr>";
        }
}

=head1 SEE ALSO

http://www.lindnerei.de, http://treeview.lindnerei.de,

=head1 AUTHOR

Dirk Lindner <lindnerei@o2online.de>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Hr. Dirk Lindner

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation;
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

=cut

1;
