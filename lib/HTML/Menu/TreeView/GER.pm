package HTML::Menu::TreeView::GER;
use strict;
use warnings;
$HTML::Menu::TreeView::GER::VERSION = '1.03';

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

     use HTML::Menu::TreeView;

     use strict;

     my @tree =(

          {

               image => 'tar.png',

               onclick => "alert('onclick');",

               text => 'Node',

          },

          {

               text => 'Folder',

               folderclass => 'folderMan', # Nur für Crystal Styles.

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

     print css();

     print jscript();

     print preload();

     print Tree(\@tree,"Crystal");


=head3 Funktions- Sets

Hier die liste der möglichen Import Sets

:all

Tree css jscript clasic preload help folderFirst size documentRoot loadTree saveTree sortTree orderBy prefix Style orderByColumn border

:recommend

Tree css jscript clasic preload folderFirst size Style documentRoot loadTree saveTree sortTree orderBy prefix

:standart

Tree css jscript preload size Style documentRoot clasic,

:backward

setDocumentRoot getDocumentRoot setSize setClasic setStyle style setModern %anker

:columns

border columns orderByColumn

=head1 DESCRIPTION

HTML::Menu::TreeView ist ein Module um ein HTML TreeView zu erstellen.

=head1 Changes

1.02

Deutsche Umlaute wurden falsch dargestellt.

Einige Ergänzungen in der Deutschen Dokumentation.

=head1 Public

=head2 new

     Bei der Objektorientierten Schnittstelle kann man die Array Referenz direkt an new übergeben

     ms $TreeView = new HTML::Menu::TreeView(\@tree, optional style);

     und Tree dann ohne Argumente aufrufen.

     print $TreeView->Tree();

=head2 css

Gibt den benötigten Stylesheet(css) zurück, der In die Seite eingebunden werden muss.

Mann kann den Document Root setzen wenn man ein Argument übergibt.

     css('/document/root/');

Man kann den benötigten Stylesheet natürlich per Hand einbinden:

     <link href="/style/Crystal/16/html-menu-treeview/Crystal.css" rel="stylesheet" type="text/css">

=head2 documentRoot

Setzt den Document Root im Scalar Context, gibt Ihn in void Context zurück.

default: Diese Variable wird durch make gesetzt.

=head2 jscript

Gibt den benötigten Javascript zurück, der In die Seite eingebunden werden muss.

Mann kann den Document Root setzen wenn man ein Argument übergibt.

Man kann den benötigten Javascript natürlich per Hand einbinden:

     <script language="JavaScript" type="text/javascript" src="/style/treeview.js"></script>

=head2 preload

Gibt den benötigten javascript zurück um Bilder per Javascript in Vorhinein zu laden.

Mann kann den document root setzen wenn man ein Argument übergibt.

Man kann den benötigten javascript natürlich auch per Hand einbinden.

Für eine Größe:

     <script language="JavaScript" type="text/javascript" src="/style/Crystal/16/html-menu-treeview/preload.js"></script>

Oder für alle Größen:

     <script language="JavaScript" type="text/javascript" src="/style/Crystal/preload.js"></script>

=head2 size

Verschiedene Größen sind nur für den Crystal Style verfügbar.

Setzt die Größe im Scalar Context, gibt Sie in void Context zurück.

16,32,48,64 und 128 sind mögliche Werte.

=head2 Style

Setzt den Style im Scalar Context, gibt Ihn in void Context zurück.

     Style('simple');

simple = Redmond mäßiger style.

Crystal = Kde Crystal style (default).

=head2 Tree

     Tree(\@tree,optional $style);

Gibt den HTML teil des Treeviews ohne Javascript und Css zurück.

=head2 clasic

Klassische Knoten Dekoration einschalten

     clasic(1);

klassische Knoten Dekoration ausschalten

     clasic(0);

gibt den Status in void Context zurück.

     $status = clasic();

=head2 columns

Anzahl der Spalten setzen.

     columns(3);

Gibt die Anzahl in void Context zurück.

     $anzahl = columns();

Oder man kann die Titel für die Spalten Setzen

     columns("Name","Column 1","Column 2","Column 3");

=head2 border

Spalten Rahmen ein- oder ausschalten.

=head2 sortTree

Spalten nach Name oder dem Attribute das von orderBy gesetzt wurde sortieren.

=head2 orderBy

Setzt das Attribute das von sortTree und folderFirst benutzt wird.

=head2 orderByColumn

Nach Spalte Sortieren.

     orderByColumn(i)

=head2 folderFirst

Verzeichnisse zuerst anzeigen.

=head2 prefix

Wenn man eine offline Webseite erstellen will kann man

z.Bsp:

     prefix('.');

setzen.

=head2 saveTree

     saveTree('filename',\@ref); # oder saveTree()

default: ./TreeViewDump.pl

=head2 loadTree

     loadTree('filename')  oder loadTree()

default: ./TreeViewDump.pl


=head2 help

Die Hilfe für die Link Attribute

gibt eine Referenz auf ein hash zurück (void Context),

     my $hashref =  help();

     foreach my $key (sort(keys %{$hashref})){

          print "$key : ", $hashref->{$key} ,$/;

     }

oder eine Hilfe Nachricht.

     print help('href'),$/;

(Nur auf Englisch verfügbar)

=head3 reservierte Attribute:

=over

=item href

Dieses Attribut gibt die Position einer Web-Ressource an und definiert so einen Link zwischen dem

aktuellen Element (dem Quellanker) und dem durch dieses Attribut definierten Zielanker.

=item accesskey

Dieses Attribut weist einem Element eine Zugriffstaste zu.

=item charset

Gibt die Zeichenkodierungen an.

=item class

Name der Klasse des Elements.

=item coords

Für Image maps.

=item dir

Leserichtung.

=item hreflang

Sprache vom Link Ziel.

=item lang

Basis-Sprache der Attribute und des Inhalts.

=item onblur

Element verliert die Auswahl.

=item ondblclick

Wenn mit der Maus auf das Element doppelt angeklickt wird.

=item onclick

Wenn mit der Maus auf das Element geklickt wird.

=item onfocus

Element wird ausgewählt.

=item onkeydown

Wenn eine taste gedrückt wird.

=item onkeypress

Wenn eine taste gedrückt und wieder losgelassen wird.

=item onkeyup

Wenn die taste wieder losgelassen wird.

=item onmousedown

Wenn eine Maustaste gedrückt wird.

=item onmousemove

Maus wird bewegt.

=item onmouseout

Maus verlässt den link.

=item onmouseover

Maus über den link

=item onmouseup

Wenn die Maustaste wieder losgelassen wird.

=item rel

Dieses Attribut beschreibt die Beziehung vom aktuellen Dokument zu dem durch das href-Attribut angegebenen Anker.

=item rev

Dieses Attribut gibt die Zeichenkodierung der durch den Link bezeichneten Ressource an.

=item shape

Für image maps.

=item style

Stylesheet Informationen.

=item tabindex

Position in der tab Reihenfolge.

=item target

Mit dem Attribut target im einleitenden <a>-Tag können Sie ein Zielfenster für den Verweis festlegen. Der im Wert zugewiesene Name muss mit einem Buchstaben (A-Z, a-z) beginnen, außer in den folgenden

Ausnahmen, die durch einen führenden Unterstrich gekennzeichnet sind:

_blank, um den Verweis in einem neuen Fenster zu öffnen,

 _self, um den Verweis im aktuellen Fenster zu öffnen,

 _parent, um bei verschachtelten Framesets das aktuelle Frameset zu sprengen,

 _top, um bei verschachtelten Framesets alle Framesets zu sprengen.


=item type

Content type.

=item title

Titel.

=item id

Die id des links. Wird gesetzt.

=item addition

Zusätzlicher text hinter dem link.

=item subtree

     subtree => [{

          text => 'Fo'},

          {text => 'Bar'}

     ]

=item image.

Bild Name, muss im /style/mimetypes Verzeichnis liegen

=item folderclass :

Nur für Crystal styles

Mögliche Werte:

folderMan, folderVideo,folderCrystal,

folderLocked , folderText, folderFavorite,

folderPrint,folderHtml,

folderImage,folderSound,folderImportant,

folderTar,folderYellow ,folderGray,

folderGreen und folderRed

Auf  http://treeview.lindnerei.de/cgi-bin/crystal.pl gibt es eine komplette liste möglicher werte.

=item columns

Ein Array mit den Spalten.

=item empty.

Auf wahr setzen wenn man einen geschlossenes Verzeichnis haben möchte.

=back

=head1 backward compatibility

=head2 getDocumentRoot

siehe documentRoot()

=head2 setClasic

siehe clasic()

=head2 setDocumentRoot

siehe documentRoot()

=head2 setModern

siehe clasic()

=head2 setSize

siehe size()

=head2 setStyle

siehe Style()

=head2 style

siehe Style()

=head1 Private

=head2 initTree

Erzeugt den Treeview, wird von initTree, new  oder rekursive von appendFolder aufgerufen.

=head2 ffolderFirst

Wird innerhalb von initTree zum sortieren benutzt wenn Verzeichnisse zuerst angezeigt werden sollen.

=head2 getSelf

Dieses Module benutzt ein Lincoln loader mäßiges Klassen System.

Wenn der erste übergebene Parameter von ein HTML::Menu::TreeView Objekt ist (oo syntax). werden einfach die übergebenen Parameter zurück gegeben.

Ansonsten (fo syntax)  wird ein neues HTML::Menu::TreeView Objekt erzeugt und als erster wert gefolgt von den übergeben Parametern zurückgegeben.

=head2 appendFolder

Wird von initTree aufgerufen wenn ein item vom aktuellen (sub)tree ein Verzeichnis ist.

=head2 appendLastFolder

$self->appendLastFolder(\@tree);

Wird von initTree aufgerufen wenn das letzte item vom aktuellen (sub)tree ein Verzeichnis ist.

=head2 appendEmptyFolder

$self->appendEmptyFolder(\$node);

Wird von initTree aufgerufen wenn ein item vom aktuellen (sub)tree ein ein leeres Verzeichnis ist.

=head2 appendLastEmptyFolder

$self->appendEmptyFolder(\$node);

Wird von initTree aufgerufen wenn das letzte item vom aktuellen (sub)tree ein leeres Verzeichnis ist.

=head2 appendNode

$self->appendNode(\$node);

Wird von initTree aufgerufen wenn ein item vom aktuellen (sub)tree ein Knoten ist.

=head2 appendLastNode

$self->appendLastNode(\$node);

wir von initTree aufgerufen wenn das letzte item vom aktuellen (sub)tree ein Knoten ist.

=head1 SEE ALSO

http://www.lindnerei.de, http://treeview.lindnerei.de,

L<HTML::Menu::TreeView>, http://treeview.tigris.org,

=head1 AUTHOR

Dirk Lindner <lze@cpan.org>

=head1 LICENSE

LGPL

Copyright (C) 2008  Dirk Lindner

Diese Bibliothek ist freie Software. Sie dürfen sie unter den Bedingungen
der GNU Lesser General Public License, wie von der Free Software Foundation veröffentlicht,
weiterverteilen und/oder modifizieren; entweder gemäß Version 2.1 der Lizenz oder (nach Ihrer
Option) jeder späteren Version. Diese Bibliothek wird in der Hoffnung weiterverbreitet,
daß sie nützlich sein wird, jedoch OHNE IRGENDEINE GARANTIE,
auch ohne die implizierte Garantie der MARKTREIFE oder der VERWENDBARKEIT FÜR EINEN BESTIMMTEN ZWECK.
Mehr Details finden Sie in der GNU Lesser General Public License.
Sie sollten eine Kopie der GNU Lesser General Public License zusammen mit dieser Bibliothek erhalten haben.
falls nicht,
schreiben Sie an die Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110, USA.

=cut

1;
