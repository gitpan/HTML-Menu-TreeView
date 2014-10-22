package HTML::Menu::TreeView;
use strict;
use warnings;
require Exporter;
use 5.00600;
use vars qw($DefaultClass %EXPORT_TAGS @EXPORT_OK @ISA %anker @TreeView %openArrays @caption $columns $clasic $ffirst $sort $border $orderby $size $style $orderbyColumn $prefix $bTrOver $desc %anker %ankerG $lang);
$HTML::Menu::TreeView::VERSION = '1.08';
@ISA                           = qw(Exporter);
@HTML::Menu::TreeView::EXPORT_OK =
  qw(border Tree css columns jscript setStyle setDocumentRoot getDocumentRoot setSize setClasic clasic preload help folderFirst size style Style documentRoot loadTree saveTree  %anker %ankerG sortTree orderBy orderByColumn prefix setModern border TrOver desc language);
%HTML::Menu::TreeView::EXPORT_TAGS = (
                                       'all'       => [qw(Tree css jscript clasic columns preload help folderFirst size documentRoot loadTree saveTree sortTree orderBy prefix Style orderByColumn border TrOver desc language)],
                                       'recommend' => [qw(Tree css jscript clasic preload folderFirst help size Style documentRoot loadTree saveTree sortTree prefix desc)],
                                       'standart'  => [qw(Tree css jscript preload size Style documentRoot clasic)],
                                       'backward'  => [qw(setDocumentRoot getDocumentRoot setSize setClasic setStyle style setModern)],
                                       'columns'   => [qw(border columns orderByColumn orderBy)],
);
$DefaultClass = 'HTML::Menu::TreeView' unless defined $HTML::Menu::TreeView::DefaultClass;
our $id       = 'a';
our $path     = '%PATH%';
our $saveFile = './TreeViewDump.pl';
$lang  = 'en';
$style = 'Crystal';
$size  = 16;
( $clasic, $ffirst, $sort, $border, $columns, $desc, $bTrOver ) = (0) x 7;
$orderby = 'text';
$prefix  = '';
%anker = (
           name        => 'The name of the Element',
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
           target      => 'target frame information',
           type        => 'advisory content type ',
           title       => 'element title',
           id          => 'This attribute assigns a name to an element. This name must be unique in a document.',
);
%ankerG = (
            name        => 'Name des Ankers',
            href        => 'Adresse die aufgerufen wird',
            accesskey   => 'Zugriffstaste',
            charset     => 'Zeichenkodierung',
            class       => 'Klassen Name',
            coords      => 'Imagemaps',
            dir         => 'Leserichtung',
            hreflang    => 'Basissprache des Ziels',
            lang        => 'Basissprache des Inhaltes',
            onblur      => 'Anker verliert den Fokus',
            ondblclick  => 'Maus wird Doppelgeklickt',
            onclick     => 'Maus wird geklickt',
            onfocus     => 'Anker erhaelt den Fokus',
            onkeydown   => 'Eine taste wird gedrueckt.',
            onkeypress  => 'Eine taste wird gedrueckt',
            onkeyup     => 'Eine taste wird los gelassen',
            onmousedown => 'Maus wird gedrückt',
            onmousemove => 'Maus wird bewegt',
            onmouseout  => 'Maus verlässt den Anker',
            onmouseover => 'Maus betritt den Anker',
            onmouseup   => 'Maus wird losgelassen',
            rel         => 'forward link types',
            rev         => 'reverse link types',
            shape       => 'Imagemaps',
            style       => 'Formatierungs Informationen',
            tabindex    => 'Tabstopp position',
            target      => 'Ziel Frame Angabe',
            type        => 'content-type',
            title       => 'Titel',
            id          => 'Identifikator. Muss einmalig im Dokument sein',
);

=head1 NAME

HTML::Menu::TreeView - Create a HTML TreeView from scratch

=head1 SYNOPSIS

     use HTML::Menu::TreeView qw(Tree);

     my @tree =( {

     text => 'Folder',

     subtree => [

          {

          text => 'treeview Homepage',

          href => 'http://treeview.lindnerei.de'

          }

            ],

     },);

     Tree(\@tree);

=head2 OO Syntax

     use HTML::Menu::TreeView;

     use strict;

     my @tree =(

          {

               image => 'tar.png',

               text => 'Node'
          },
     );

     my $Treeview = new HTML::Menu::TreeView();

     print $Treeview->css("/srv/www/httpdocs");

     print $Treeview->jscript();

     print $Treeview->preload();

     print $Treeview->Tree(\@tree);

=head2 FO Syntax

     use HTML::Menu::TreeView qw(css jscript preload Tree);

     print css();

     print jscript();

     print preload();

     print Tree(\@tree,"Crystal");


=head3 function sets

Here is a list of the function sets you can import:

:all

Tree css jscript clasic preload help folderFirst size documentRoot loadTree saveTree sortTree orderBy prefix Style orderByColumn border desc language

:recommend

Tree css jscript clasic preload folderFirst size Style documentRoot loadTree saveTree sortTree prefix desc

:standart

Tree css jscript preload size Style documentRoot clasic,

:backward

setDocumentRoot getDocumentRoot setSize setClasic setStyle style setModern

:columns

border columns orderByColumn orderBy

=head1 DESCRIPTION

HTML::Menu::TreeView is a Modul to build an Html TreeView.

=head1 Changes

1.08

delete one unnessesary file.

1.07

Drag & drop example edit.pl

new css class dropzone

Overwrought Documentation

Overwrought Images

1.06

svn moved to http://lindnerei.svn.sourceforge.net/viewvc/lindnerei/treeview/

new Images, german Help

language function set it to "de" for german help

german documentation droped

Build install_examples

=head1 Public

=head2 new

if you use the oo interface you can say:

     my $TreeView = new HTML::Menu::TreeView(\@tree, optional style);

and then call Tree without arguments.

     print $TreeView->Tree();

=cut

sub new {
    my ( $class, @initializer ) = @_;
    my $self = {tree => undef,};
    bless $self, ref $class || $class || $DefaultClass;
    $style    = $initializer[1] if( defined $initializer[1] );
    @TreeView = $initializer[0] if(@initializer);
    return $self;
}

=head2 css

return the necessary css part without <style></style> tag.

you can set the DocumentRoot if you pass a parameter

     css('/document/root/');

you can also include it with:

     <link href="/style/Crystal/16/html-menu-treeview/Crystal.css" rel="stylesheet" type="text/css">

for example.

=cut

sub css {
    my ( $self, @p ) = getSelf(@_);
    use Fcntl qw(:flock);
    use Symbol;
    $self->documentRoot( $p[0] ) if( defined $p[0] );
    my $fh   = gensym;
    my $file = "$path/style/$style/$size/html-menu-treeview/$style.css";
    open $fh, $file or warn "HTML::Menu::TreeView::css $/ no style '$style.css' $style.css found $/  in  $path/style/html-menu-treeview/$style/ $/ $! $/";
    seek $fh, 0, 0;
    my @lines = <$fh>;
    close $fh;
    my $css;

    foreach my $l (@lines) {
        $l =~ s?/style/?$prefix/style/?g;
        $css .= $l;
    }
    return $css;
}

=head2 documentRoot

set or get the Document Root.

default: this variable is set during make.

=cut

sub documentRoot {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] ) {
        if( -e $p[0] ) {$path = $p[0];}
        else {warn "HTML::Menu::TreeView::documentRoot $/ Document Root don't exits: $/ $! $/";}
    } else {
        return $path;
    }
}

=head2 jscript

return the necessary javascript without <script> tag.

you can also include it with:

     <script language="JavaScript" type="text/javascript" src="/style/treeview.js"></script>

you can set the Document Root if you pass a parameter

=cut

sub jscript {
    my ( $self, @p ) = getSelf(@_);
    use Fcntl qw(:flock);
    use Symbol;
    $self->documentRoot( $p[0] ) if( defined $p[0] );
    my $fh   = gensym;
    my $file = "$path/style/treeview.js";
    open $fh, $file or warn "HTML::Menu::TreeView::jscript $/ $! $/";
    seek $fh, 0, 0;
    my @js = <$fh>;
    close $fh;
    return "@js";
}

=head2 preload

return the necessary javascript for preloading images without <script> tag.

you can also include it with:

     <script language="JavaScript" type="text/javascript" src="/style/Crystal/16/html-menu-treeview/preload.js"></script>

or

     <script language="JavaScript" type="text/javascript" src="/style/Crystal/preload.js"></script>

if you use different images sizes.

you can set the DocumentRoot if you pass a parameter

=cut

sub preload {
    my ( $self, @p ) = getSelf(@_);
    use Fcntl qw(:flock);
    use Symbol;
    $self->documentRoot( $p[0] ) if( defined $p[0] );
    my $fh   = gensym;
    my $file = "$path/style/$style/$size/html-menu-treeview/preload.js";
    open $fh, $file or warn "HTML::Menu::TreeView::preload $/ $! $/";
    seek $fh, 0, 0;
    my @lines = <$fh>;
    close $fh;
    my $preload;

    foreach my $l (@lines) {
        $l =~ s?/style/?$prefix/style/?g;
        $preload .= $l;
    }
    return $preload;
}

=head2 size

only for Crystal styles

set or get the size.

16,32,48,64 and 128 are possible values.

=cut

sub size {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(16|22|32|48|64|128)/ ) {$size = $1;}
    else {return $size;}
}

=head2 Style

set the style in scalar context or get in void context.

     Style('simple');

simple = redmond like style.

Crystal = Crystal style (default).

=cut

sub Style {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] ) {
        if( -e $path . '/style/' . $p[0] ) {$style = $p[0];}
        else {warn "HTML::Menu::TreeView::Style $/ $path/style/$p[0] not found $/ $! $/";}
    } else {
        return $style;
    }
}

=head2 Tree

     Tree(\@tree,optional $style);

Returns the html part of the Treeview without javasript and css.

=cut

sub Tree {
    my ( $self, @p ) = getSelf(@_);
    $style = $p[1] if( defined $p[1] );
    @TreeView = @p ? @p : @TreeView;
    $self->initTree(@TreeView) if(@TreeView);
    my $r;
    if( defined $self->{subtree} ) {
        $r .= qq(<script type="text/javascript">\n//<!-- \nwindow.folders = new Array();\n);
        foreach my $key ( keys %{$self->{js}} ) {
            $r .= "folders['$key']= new Array(";
            for( my $i = 0 ; $i < @{$self->{js}{$key}} ; $i++ ) {
                $r .= '"' . $self->{js}{$key}[$i] . '"';
                $r .= ',' if( $i+ 1 != @{$self->{js}{$key}} );
            }
            $r .= ");\n";
        }
        $r .= "//-->\n</script>";
    }
    $r .= qq(<table border="0" cellpadding="0" cellspacing="0" summary="Tree"><tr><td><table cellpadding="0" cellspacing="0"  align="left" border="0" summary="Tree" width="100%" class="treeview$size"><colgroup><col width="$size"/></colgroup>);
    if( defined @caption ) {
        my $class = $border ? "captionBorder$size" : "caption$size";
        $r .= qq(<tr><td class="$class"></td><td class="$class">$caption[0]</td></tr>);
    }
    $r .= $self->{tree} . '</table></td>';
    if( defined $self->{subtree} ) {
        $r .= '<td><table align="left" border="0" cellpadding="0" cellspacing="0" summary="subTree" width="100%" >';
        if( defined @caption ) {
            my $class = $border ? "captionBorder$size" : "caption$size";
            $r .= '<tr>';
            for( my $i = 1 ; $i <= $#caption ; $i++ ) {$r .= qq(<td class="$class">$caption[$i]</td>);}
            $r .= '</tr>';
        }
        undef @caption;
        $r .= $self->{subtree} . '</table></td>';
    }
    $r .= '</tr></table>';
    return $r;
}

=head2 clasic

enable clasic node decoration:

     clasic(1);

disable clasic node decoration:

     clasic(0);

return the status in void context.

     $status = clasic();

=cut

sub clasic {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(0|1)/ ) {$clasic = $1;}
    else {return $clasic;}
}

=head2 columns

set number of columns

     columns(3);

return the count in void context.

     $count = columns();

or set the captions for the columns

     columns("Name","Column 1","Column 2","Column 3");

=cut

sub columns {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(\d+)/ && $#p== 0 ) {$columns = $1;}
    elsif ( $#p > 0 ) {
        $columns = $#p+ 1;
        @caption = @p;
    } else {
        return $columns;
    }
}

=head2 border

enable border for columns :

     border(1);

disable border for columns :

     border(0);

return the status in void context.

     $status = border();

=cut

sub border {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(0|1)/ ) {$border = $1;}
    else {return $border;}
}

=head2 desc

reverse sorting

enable desc :

     desc(1);

disable border:

     desc(0);

return the status in void context.

     $status = desc();

=cut

sub desc {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(0|1)/ ) {$desc = $1;}
    else {return $desc;}
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
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(0|1)/ ) {$sort = $1;}
    else {return $sort;}
}

=head2 orderBy

set the attribute which is used by sortTree and folderFirst.

=cut

sub orderBy {
    my ( $self, @p ) = getSelf(@_);
    $orderby = $p[0];
}

=head2 orderByColumn

sort the TreeView by Column

     orderByColumn(i);

-1 to disable;

=cut

sub orderByColumn {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(\d+)/ ) {$orderbyColumn = $1;}
    elsif ( $p[0]== -1 ) {$orderbyColumn = undef;}
    else {return $orderbyColumn;}
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
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] && $p[0] =~ /(0|1)/ ) {$ffirst = $1;}
    else {return $ffirst;}
}

=head2 prefix

prefix used by css.

use this if you want build a offline website

for example:

     prefix('.');

return the prefix in void context.

=cut

sub prefix {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] ) {$prefix = $p[0];}
    else {return $prefix;}
}

=head2 TrOver

enable mouseover

tr.trOver{}

=cut

sub TrOver {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] ) {$bTrOver = $p[0];}
    else {return $bTrOver;}
}

=head2 saveTree

     saveTree('filename',\@ref); # or saveTree()

default: ./TreeViewDump.pl

=cut

sub saveTree {
    my ( $self, @p ) = getSelf(@_);
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
        open $fh, ">$rsas.bak" or warn "HTML::Menu::TreeView::saveTree $/ $! $/ $rsas $/";
        flock $fh, 2;
        seek $fh, 0, 0;
        truncate $fh, 0;
        print $fh $content;
        close $fh;
    }
    if( -e "$rsas.bak" ) {
        rename "$rsas.bak", $rsas or warn "HTML::Menu::TreeView::saveTree $/ $! $/";
        do $rsas;
    }
}

=head2 loadTree

     loadTree('filename') or loadTree()

default: ./TreeViewDump.pl

=cut

sub loadTree {
    my ( $self, @p ) = getSelf(@_);
    my $do = ( defined $p[0] ) ? $p[0] : $saveFile;
    do $do if( -e $do );
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

if you want german help try

     language('de')

=cut

sub help {
    my ( $self, @p ) = getSelf(@_);
    if( defined $p[0] ) {
        if( $lang eq 'de' ) {return ( defined $ankerG{$p[0]} ) ? $ankerG{$p[0]} : "Unbekanntes Attribute !$/";}
        else {return ( defined $ankerG{$p[0]} ) ? $anker{$p[0]} : "Unknown attribute !$/";}
    } else {
        if( $lang eq 'de' ) {return \%ankerG;}
        else {return \%anker;}
    }
}

=head2 reserved attributes:

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

     subtree => [{
          text => 'Fo'},
          {text => 'Bar'}
     ]

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

folderGreen and folderRed

see http://treeview.lindnerei.de/cgi-bin/crystal.pl for a complete list of possible values for folderclass.

=item columns

an array of columns

columns => [ 1,2,3,4,5]

=item empty.

set it true if you ant a closed Folder,

which load a location onclick, you must additional set the href attribute.

=back

=head1 backward compatibility


=head2 getDocumentRoot

for backward compatibility.

use documentRoot instead.

=cut

sub getDocumentRoot {return $path;}

=head2 setClasic

use clasic() instead.

for backward compatibility.

use a classic node decoration

=cut

sub setClasic {$clasic = 1;}

=head2 setDocumentRoot

for backward compatibility.

use documentRoot instead.

set the local path to the style folder.

should be the Document Root of your webserver.

example:

     setDocumentRoot('/sv/www/htdocs/');

default: this property is set during make

=cut

sub setDocumentRoot {
    my ( $self, @p ) = getSelf(@_);
    $self->documentRoot( $p[0] );
}

=head2 setModern

use clasic() instead.

for backward compatibility.

use a modern node decoration

=cut

sub setModern {$clasic = 0;}

=head2 setSize

for backward compatibility.

use size instead.

only for Crystal styles

16,32,48,64 and 128 are possible values.

=cut

sub setSize {
    my ( $self, @p ) = getSelf(@_);
    $self->size( $p[0] );
}

=head2 setStyle

for backward compatibility.

use style instead.

     setStyle('style');

simple = redmond like style

Crystal = Crystal style

=cut

sub setStyle {
    my ( $self, @p ) = getSelf(@_);
    $self->Style( $p[0] );
}

=head2 style

set the style.

     style('simple');

simple = redmond like style.

Crystal = Crystal style (default).

=cut

sub style {
    my ( $self, @p ) = getSelf(@_);
    return $self->Style( $p[0] );
}

=head2 language

set the language in scalar context, or get in void context.

language('de');

simple = redmond like style.

Crystal = Crystal style (default).

=cut

sub language {
    my ( $self, @p ) = getSelf(@_);
    $lang = $p[0];
}

=head1 Private

=head2 initTree

construct the TreeView called by Tree, new or recursive by appendFolder.

=cut

sub initTree {
    my ( $self, @p ) = getSelf(@_);
    my $tree = $p[0];
    return if ref $tree ne "ARRAY";
  SWITCH: {
        if($ffirst) {
            my @tr = sort {&_ffolderFirst} @$tree;
            @tr = reverse @tr if $desc;
            $tree = \@tr;
            last SWITCH;
        }
        if($sort) {
            my @tr = sort {
                return -1 unless $a || $b;
                return -1 if ref $a ne "HASH";
                return +1 if ref $b ne "HASH";
                return lc( $a->{$orderby} ) cmp lc( $b->{$orderby} )
            } @$tree;
            @tr = reverse @tr if $desc;
            $tree = \@tr;
            last SWITCH;
        }
        if( defined $orderbyColumn && $orderbyColumn >= 0 ) {
            my @tr = sort {
                return -1 unless $a || $b;
                return -1 if ref $a ne "HASH";
                return +1 if ref $b ne "HASH";
                return lc( $a->{columns}[$orderbyColumn] ) cmp lc( $b->{columns}[$orderbyColumn] )
            } @$tree;
            @tr = reverse @tr if $desc;
            $tree = \@tr;
            last SWITCH;
        }
    }
    my $length = @$tree;
    for( my $i = 0 ; $i < @$tree ; $i++ ) {
        next if ref @$tree[$i] ne "HASH";
        $length--;
        if( defined @$tree[$i] ) {
            if( defined @{@$tree[$i]->{subtree}} ) {
                if( $length > 0 ) {$self->appendFolder( @$tree[$i], \@{@$tree[$i]->{subtree}} );}
                elsif ( $length eq 0 ) {$self->appendLastFolder( @$tree[$i], \@{@$tree[$i]->{subtree}} );}
            } elsif ( defined @$tree[$i]->{empty} ) {
                if( $length > 0 ) {$self->appendEmptyFolder( @$tree[$i] );}
                elsif ( $length eq 0 ) {$self->appendLastEmptyFolder( @$tree[$i] );}
            } else {
                if( $length > 0 ) {$self->appendNode( @$tree[$i] );}
                elsif ( $length eq 0 ) {$self->appendLastNode( @$tree[$i] );}
            }
        }
    }

=head2 _ffolderFirst

this function is used within initTree for sorting the TreeView if folderFirst(1) is set.

=cut

    sub _ffolderFirst {
        no warnings;
      SWITCH: {
            return -1 if ref $a ne "HASH";
            return +1 if ref $b ne "HASH";
            if( defined @{$a->{subtree}} and defined @{$b->{subtree}} ) {
                return lc( $a->{$orderby} ) cmp lc( $b->{$orderby} );
                last SWITCH;
            } elsif ( defined @{$a->{subtree}} ) {
                return -1;
                last SWITCH;
            } elsif ( defined @{$b->{subtree}} ) {
                return +1;
                last SWITCH;
            } else {
                return $sort ? ( lc( $a->{$orderby} ) cmp lc( $b->{$orderby} ) ) : -1;
            }
        }
    }
}

=head2 getSelf

HTML::Menu::TreeView Module make use of a Lincoln loader like class system.

if the first parameter is a HTML::Menu::TreeView object (oo syntax ) this function returns the given parameters.

or the first parameter it is not a object referenz (fo syntax) it create a new HTML::Menu::TreeView object,

return it as first value and  @_ as the second value .

my ($self, @p) = getSelf(@_);

=cut

sub getSelf {
    return @_ if defined( $_[0] ) && ( !ref( $_[0] ) ) && ( $_[0] eq 'HTML::Menu::TreeView' );
    return ( defined( $_[0] ) && ( ref( $_[0] ) eq 'HTML::Menu::TreeView' || UNIVERSAL::isa( $_[0], 'HTML::Menu::TreeView' ) ) ) ? @_ : ( $HTML::Menu::TreeView::DefaultClass->new, @_ );
}

=head2 appendFolder

called by initTree(), append a Folder to the treeView()

=cut

sub appendFolder {
    my $self    = shift;
    my $node    = shift;
    my $subtree = shift;
    ++$id;
    my ( $tmpref, $ty );
    if( $columns > 0 ) {
        $ty = $id;
        foreach my $key ( keys %openArrays ) {push @{$openArrays{$key}}, $id;}
        $tmpref = \@{$openArrays{$id}};
    }
    $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? '' : qq(ocFolder('$id');displayTree('$id');hideArray('$id');ocNode('$id.node','$size'););
    my $onclick = qq(ocFolder('$id');displayTree('$id');hideArray('$id');ocNode('$id.node','$size'););
    $node->{class} = defined $node->{class} ? $node->{class} : "treeviewLink$size";
    my $FolderClass = defined $node->{folderclass} ? $node->{folderclass} . $size : "folder$size";
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key ( keys %{$node} ) {$tt .= $key . '="' . $node->{$key} . '" ' if( $anker{$key} && $node->{$key} );}
    my $st = $node->{style} = ( ( $columns > 0 or defined $node->{addition} ) and not defined $node->{style} ) ? 'style="white-space:nowrap;"' : '';
    my $addon =
      defined $node->{addition}
      ? qq(<table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendFolder" width="100%"><tr><td $st>&#160;<a $tt>$node->{text}</a>&#160;</td><td $st>$node->{addition}</td></tr></table>)
      : "&#160;<a $tt >$node->{text}</a>&#160;";
    my $minusnode = $clasic ? "clasicMinusNode$size" : "minusNode$size";
    $self->{tree} .=
      ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tree$id">) : '<tr>' )
      . qq(<td id="$id.node" class="$minusnode"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" onclick="$onclick"/></td><td align="left" class="$FolderClass" id="$id.folder" ><table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendFolder" width="100%"><tr><td $st valign="top" width="$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" onclick="$onclick"/></td><td $st align="left">$addon</td></tr></table></td></tr><tr id="$id"><td class="submenuDeco$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" alt=""/></td><td><table align="left" border="0" cellpadding="0" cellspacing="0"   summary="appendFolder" width="100%"><colgroup><col width="$size"/></colgroup>);

    if( $columns > 0 ) {
        my $class = $border ? "columnsFolderBorder$size" : "columnsFolder$size";
        $self->{subtree} .= ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tr$id">) : qq(<tr id="tr$id">) );
        for( my $i = 0 ; $i < $columns ; $i++ ) {
            if( defined $node->{columns}[$i] ) {
                my $txt = $node->{columns}[$i];
                $self->{subtree} .= qq(<td class="$class">$txt</td>);
            }
        }
        $self->{subtree} .= '</tr>';
    }
    $self->initTree( \@$subtree );
    if( $columns > 0 ) {
        for( my $i = 0 ; $i < @$tmpref ; $i++ ) {$self->{js}{$ty}[$i] = $$tmpref[$i];}
        undef @$tmpref;
    }
    $self->{tree} .= '</table></td></tr>';
}

=head2 appendLastFolder

$self->appendLastFolder(\@tree);

called by initTree() if the last item of the (sub)Tree is a folder.

=cut

sub appendLastFolder {
    my $self    = shift;
    my $node    = shift;
    my $subtree = shift;
    $id++;
    my $tmpref;
    my $ty;
    if( $columns > 0 ) {
        $ty = $id;
        foreach my $key ( keys %openArrays ) {push @{$openArrays{$key}}, $id;}
        $tmpref = \@{$openArrays{$id}};
    }
    $node->{onclick} = defined $node->{onclick} ? $node->{onclick} : defined $node->{href} ? "" : qq(ocpNode('$id.node','$size');ocFolder('$id');displayTree('$id');hideArray('$id'););
    my $onclick = qq(ocFolder('$id');displayTree('$id');hideArray('$id');ocNode('$id.node','$size'););
    $node->{class} = defined $node->{class} ? $node->{class} : "treeviewLink$size";
    my $FolderClass = defined $node->{FolderClass} ? $node->{FolderClass} . $size : "folder$size";
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key ( keys %{$node} ) {$tt .= $key . '="' . $node->{$key} . '" ' if( $anker{$key} && $node->{$key} );}
    my $st = $node->{style} = ( ( $columns > 0 or defined $node->{addition} ) and not defined $node->{style} ) ? 'style="white-space:nowrap;"' : '';
    my $addon =
      defined $node->{addition}
      ? qq(<table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendLastFolder"  width="100%"><tr><td $st>&#160;<a $tt >$node->{text}</a>&#160;</td><td $st>$node->{addition}</td></tr></table>)
      : "&#160;<a $tt>$node->{text}</a>&#160;";
    my $lastminusnode = $clasic ? "clasicLastMinusNode$size" : "lastMinusNode$size";
    $self->{tree} .=
      ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tree$id">) : '<tr>' )
      . qq(<td id="$id.node" class="$lastminusnode" onclick="$onclick"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" /></td><td align="left" class="$FolderClass" id="$id.folder"><table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendLastFolder" width="100%"><tr><td $st valign="top" width="$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" alt="" onclick="$onclick"/></td><td $st align="left">$addon</td></tr></table></td></tr><tr id="$id"><td><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt=""/></td><td><table align="left" width="100%" cellpadding="0" cellspacing="0" border="0" summary="appendLastFolder"><colgroup><col width="$size"/></colgroup>);

    if( $columns > 0 ) {
        my $class = $border ? "columnsFolderBorder$size" : "columnsFolder$size";
        $self->{subtree} .= ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tr$id">) : qq(<tr id="tr$id">) );
        for( my $i = 0 ; $i < $columns ; $i++ ) {
            if( defined $node->{columns}[$i] ) {
                my $txt = $node->{columns}[$i];
                $self->{subtree} .= qq(<td class="$class">$txt</td>);
            }
        }
        $self->{subtree} .= '</tr>';
    }
    $self->initTree( \@$subtree );
    if( $columns > 0 ) {
        for( my $i = 0 ; $i < @$tmpref ; $i++ ) {$self->{js}{$ty}[$i] = $$tmpref[$i];}
        undef @$tmpref;
    }
    $self->{tree} .= '</table></td></tr>';
}

=head2 appendEmptyFolder

called by initTree(), append a empty Folder.

=cut

sub appendEmptyFolder {
    my $self = shift;
    my $node = shift;
    ++$id;
    my ( $tmpref, $ty );
    if( $columns > 0 ) {
        $ty = $id;
        foreach my $key ( keys %openArrays ) {push @{$openArrays{$key}}, $id;}
        $tmpref = \@{$openArrays{$id}};
    }
    my $onclick = qq(location.href='$node->{href}');
    $node->{class} = defined $node->{class} ? $node->{class} : "treeviewLink$size";
    my $FolderClass = defined $node->{folderclass} ? $node->{folderclass} . "Closed$size" : "folderClosed$size";
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key ( keys %{$node} ) {$tt .= $key . '="' . $node->{$key} . '" ' if( $anker{$key} && $node->{$key} );}
    my $st = $node->{style} = ( ( $columns > 0 or defined $node->{addition} ) and not defined $node->{style} ) ? 'style="white-space:nowrap;"' : '';
    my $addon =
      defined $node->{addition}
      ? qq(<table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendEmptyFolder" width="100%"><tr><td $st>&#160;<a $tt>$node->{text}</a>&#160;</td><td $st>$node->{addition}</td></tr></table>)
      : "&#160;<a $tt >$node->{text}</a>&#160;";
    my $plusnode = $clasic ? "clasicPlusNode$size" : "plusNode$size";
    $self->{tree} .=
      ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tree$id">) : '<tr>' )
      . qq(<td id="$id.node" class="$plusnode"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" onclick="$onclick"/></td><td align="left" class="$FolderClass" id="$id.folder"><table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendFolder" width="100%"><tr><td $st valign="top" width="$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" onclick="$onclick"/></td><td $st align="left">$addon</td></tr></table></td></tr>);

    if( $columns > 0 ) {
        my $class = $border ? "columnsFolderBorder$size" : "columnsFolder$size";
        $self->{subtree} .= ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tr$id">) : qq(<tr id="tr$id">) );
        for( my $i = 0 ; $i < $columns ; $i++ ) {
            if( defined $node->{columns}[$i] ) {
                my $txt = $node->{columns}[$i];
                $self->{subtree} .= qq(<td class="$class">$txt</td>);
            }
        }
        $self->{subtree} .= '</tr>';
        for( my $i = 0 ; $i < @$tmpref ; $i++ ) {$self->{js}{$ty}[$i] = $$tmpref[$i];}
        undef @$tmpref;
    }
}

=head2 appendLastEmptyFolder

$self->appendLastEmptyFolder($node);

called by initTree() if the last item of the (sub)Tree is a folder.

=cut

sub appendLastEmptyFolder {
    my $self = shift;
    my $node = shift;
    $id++;
    my $tmpref;
    my $ty;
    if( $columns > 0 ) {
        $ty = $id;
        foreach my $key ( keys %openArrays ) {push @{$openArrays{$key}}, $id;}
        $tmpref = \@{$openArrays{$id}};
    }
    my $onclick = qq(location.href='$node->{href}');
    $node->{class} = defined $node->{class} ? $node->{class} : "treeviewLink$size";
    my $FolderClass = defined $node->{folderclass} ? $node->{folderclass} . "Closed$size" : "folderClosed$size";
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    my $tt;
    foreach my $key ( keys %{$node} ) {$tt .= $key . '="' . $node->{$key} . '" ' if( $anker{$key} && $node->{$key} );}
    my $st = $node->{style} = ( ( $columns > 0 or defined $node->{addition} ) and not defined $node->{style} ) ? 'style="white-space:nowrap;"' : '';
    my $addon =
      defined $node->{addition}
      ? qq(<table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendLastFolder"  width="100%"><tr><td $st>&#160;<a $tt >$node->{text}</a>&#160;</td><td $st>$node->{addition}</td></tr></table>)
      : "&#160;<a $tt>$node->{text}</a>&#160;";
    my $lastpusnode = $clasic ? "clasicLastPlusNode$size" : "lastPlusNode$size";
    $self->{tree} .=
      ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tree$id">) : '<tr>' )
      . qq(<td id="$id.node" class="$lastpusnode" onclick="$onclick"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" /></td><td align="left" class="$FolderClass" id="$id.folder"><table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendLastFolder" width="100%"><tr><td $st valign="top" width="$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" alt="" onclick="$onclick"/></td><td $st align="left">$addon</td></tr></table></td></tr>);

    if( $columns > 0 ) {
        my $class = $border ? "columnsFolderBorder$size" : "columnsFolder$size";
        $self->{subtree} .= ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tr$id">) : qq(<tr id="tr$id">) );
        for( my $i = 0 ; $i < $columns ; $i++ ) {
            if( defined $node->{columns}[$i] ) {
                my $txt = $node->{columns}[$i];
                $self->{subtree} .= qq(<td class="$class">$txt</td>);
            }
        }
        $self->{subtree} .= '</tr>';
        for( my $i = 0 ; $i < @$tmpref ; $i++ ) {$self->{js}{$ty}[$i] = $$tmpref[$i];}
        undef @$tmpref;
    }
}

=head2 appendNode

$self->appendLastNode(\$node);

called by initTree() if the current item of the (sub)Tree is a node.

=cut

sub appendNode {
    my $self = shift;
    my $node = shift;
    $node->{image} = defined $node->{image} ? $node->{image} : 'link.gif';
    $node->{class} = defined $node->{class} ? $node->{class} : "treeviewLink$size";
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    $id++;
    if( $columns > 0 ) {
        foreach my $key ( keys %openArrays ) {push @{$openArrays{$key}}, $id;}
    }
    my $tt;
    foreach my $key ( keys %{$node} ) {$tt .= $key . '="' . $node->{$key} . '" ' if( $anker{$key} && $node->{$key} );}
    my $st = $node->{style} = ( ( $columns > 0 or defined $node->{addition} ) and not defined $node->{style} ) ? 'style="white-space:nowrap;"' : '';
    my $addon =
      defined $node->{addition}
      ? qq(<table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendNode" width="100%"><tr><td $st>&#160;<a $tt >$node->{text}</a>&#160;</td><td $st>$node->{addition}</td></tr></table>)
      : "&#160;<a $tt>$node->{text}</a>";
    my $paddingLeft = $size+ 2 . "px";
    $self->{tree} .=
      ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tree$id">) : '<tr>' )
      . qq(<td class="node$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt="" align="middle"/></td><td align="left"  style="background-image:url('$prefix/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft">$addon</td></tr>);
    if( $columns > 0 ) {
        $self->{subtree} .= ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tr$id">) : qq(<tr id="tr$id">) );
        my $class = $border ? "columnsNodeBorder$size" : "columnsNode$size";
        for( my $i = 0 ; $i < $columns ; $i++ ) {
            if( defined $node->{columns}[$i] ) {
                my $txt = $node->{columns}[$i];
                $self->{subtree} .= qq(<td class="$class">$txt</td>);
            }
        }
        $self->{subtree} .= '</tr>';
    }
}

=head2 appendLastNode

$self->appendLastNode(\$node);

called by initTree() if the last item of the current (sub)Tree is a node.

=cut

sub appendLastNode {
    my $self = shift;
    my $node = shift;
    $node->{image} = defined $node->{image} ? $node->{image} : 'link.gif';
    $node->{class} = defined $node->{class} ? $node->{class} : "treeviewLink$size";
    $node->{title} = defined $node->{title} ? $node->{title} : $node->{text};
    $id++;
    if( $columns > 0 ) {
        foreach my $key ( keys %openArrays ) {push @{$openArrays{$key}}, $id;}
    }
    my $tt;
    foreach my $key ( keys %{$node} ) {$tt .= $key . '="' . $node->{$key} . '" ' if( $anker{$key} && $node->{$key} );}
    my $st = $node->{style} = ( ( $columns > 0 or defined $node->{addition} ) and not defined $node->{style} ) ? 'style="white-space:nowrap;"' : '';
    my $addon =
      defined $node->{addition}
      ? qq(<table align="left" border="0" cellpadding="0" cellspacing="0" summary="appendLastNode" width="100%"><tr><td $st><a $tt>$node->{text}</a></td><td $st>$node->{addition}</td></tr></table>)
      : "&#160;<a $tt>$node->{text}</a>";
    my $paddingLeft = $size+ 2 . "px";
    $self->{tree} .=
      ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tree$id">) : '<tr>' )
      . qq(<td class="lastNode$size"><img src="$prefix/style/$style/$size/html-menu-treeview/spacer.gif" border="0" width="$size" height="$size" alt=""/></td><td align="left"  style="background-image:url('$prefix/style/$style/$size/mimetypes/$node->{image}');background-repeat:no-repeat;cursor:pointer;padding-left:$paddingLeft;">$addon</td></tr>);
    if( $columns > 0 ) {
        my $class = $border ? "columnsLastNodeBorder$size" : "columnsLastNode$size";
        $self->{subtree} .= ( $bTrOver ? qq(<tr onmouseover = "trOver('$id');" onmouseout="trUnder('$id');" id="tr$id">) : qq(<tr id="tr$id">) );
        for( my $i = 0 ; $i < $columns ; $i++ ) {
            if( defined $node->{columns}[$i] ) {
                my $txt = $node->{columns}[$i];
                $self->{subtree} .= qq(<td class="$class">$txt</td>);
            }
        }
        $self->{subtree} .= '</tr>';
    }
}

=head1 SEE ALSO

http://www.lindnerei.de, http://treeview.lindnerei.de,

http://lindnerei.svn.sourceforge.net/viewvc/lindnerei/treeview/

=head1 AUTHOR

Dirk Lindner <lze@cpan.org>

=head1 LICENSE

LGPL

Copyright (C) 2009 by Hr. Dirk Lindner

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public License
as published by the Free Software Foundation;
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

=cut

1;
