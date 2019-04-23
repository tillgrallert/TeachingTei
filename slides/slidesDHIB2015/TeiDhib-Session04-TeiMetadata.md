# Topic: TEI Metadata

The slides are based on those supplied by the various [Digital Humanities Summer Schools at the University of Oxford](http://digital.humanities.ox.ac.uk/dhoxss/) under the [Creative Commons Attribution](http://creativecommons.org/licenses/by/3.0/) license and have been adopted to the example of Arabic newspapers.

Slides were produced using [MultiMarkdown](http://fletcherpenney.net/multimarkdown/), [Pandoc](http://johnmacfarlane.net/pandoc/), [Slidy JS](https://www.w3.org/Talks/Tools/Slidy/slidy.js), and the [Snippet](http://steamdev.com/snippet/) jQuery Syntax highlighter.


# What is metadata?

- often called "data about data"
- term originally used with electronic data but its meaning has broadened
- data about the content, context, and structure of information resources

# General purposes of metadata

- supports the identification, retrieval, use, re-use, management, and preservation of information resources
- enriches the informational value of an object
- can describe a collection, a single resource, or a component part of a larger resource


# TEI metadata

TEI requires metadata to be stored inside the XML document, prefixed to the content. This information comprises the TEI header although, as we will see, some can be included inside the `<body>`.

- used to store bibliographical information about both the electronic version(s) of the text as well as any physical, or analogue, source(s)
- basic information is similar to library cataloguing and supports interroperability with other metadata standards
- much like an electronic version of a title page attached to a printed work

# The TEI header: `<teiHeader>`

The TEI header was designed with two goals in mind

- needs of bibliographers and librarians trying to document ‘electronic books’
- needs of text analysts trying to document ‘coding practices’ within digital resources

The result is that discussion of the header tends to be pulled in two directions...

# The librarian's header

- Conforms to standard bibliographic model, using similar terminology
- Organized as a single source of information for bibliographic description of a digital resource, with established mappings to other such records (e.g. MARC, EAD, etc.)
- General consensus on 'Best Practical for TEI for Libraries' from TEI-LIB SIG
- Pressure for greater and more exact constraints to improve precision of description: **preference for structured data over loose prose**

# Everywoman's header

- Gives a polite nod to common bibliographic practice, but has a far wider scope
- Supports a (potentially) huge range of very miscellaneous information, organized in fairly ad hoc or individualistic ways
- Many different codes of practice in different user communities
- Unpredictable combinations of narrowly encoded documentation systems and loose prose descriptions

# TEI header structure

The TEI header has four main components:

- `<fileDesc>` (file description) contains a full bibliographic description of a computer file. ("computer file" may actually correspond with several files across different operating system.)
- `<encodingDesc>` (encoding description) documents the relationship between an electronic text and the source or sources from which it was derived.
- `<profileDesc>` (text-profile description) provides a detailed description of non-bibliographic aspects of a text, specifically the languages and sublanguages used, the situation in which it was produced, the participants and their setting. (just about everything not covered in the other header elements
- `<revisionDesc>` (revision description) summarizes the revision history for a file.

Only `<fileDesc>` is required; the others are optional.

# Example header: minimal required header

    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>A title?</title>
            </titleStmt>
            <publicationStmt>
                <p>Who published?</p>
            </publicationStmt>
            <sourceDesc>
                <p>Where from?</p>
            </sourceDesc>
        </fileDesc>
    </teiHeader>

# Two levels of TEI headers

- *corpus level* metadata sets default properties for everything in a corpus
- *text level* metadata sets specific properties for one component text of a corpus

# Corpus header example

    <teiCorpus xmlns="http://www.tei-c.org/ns/1.0">
        <!-- Add xmlns and version in <teiCorpus>-->
        <teiHeader type="corpus">
            <!-- corpus-level metadata here -->
            <!-- Must contain one TEI header for the corpus. -->
        </teiHeader>
        <TEI>
            <teiHeader type="text">
                <!-- metadata specific to this text here -->
                <!-- Must contain a series of TEI elements, one for each text. -->
            </teiHeader>
            <text>
                <!-- ... -->
            </text>
        </TEI>
        <TEI>
            <teiHeader type="text">
                <!-- metadata specific to this text here -->
            </teiHeader>
            <text>
                <!-- ... -->
            </text>
        </TEI>
    </teiCorpus>

# Types of content in the TEI header

- free prose
    + prose description: series of paragraphs
    + phrase: character data, interspersed with phrase-level elements, but not paragraphs
- grouping elements: specialised elements recording some structured information
- declarations: Elements whose names end with the suffix Decl (e.g. `<subjectDecl>`, `<refsDecl>`) enclose information about specific encoding practices applied in the electronic text.
- descriptions: Elements whose names end with the suffix Desc (e.g. `<settingDesc>`, `<projectDesc>`) contain a prose description, possibly, but not necessarily, organised under some specific headings by suggested sub-elements.

# Example source: al-Iqbāl #257, 27 July 1908

![Front page of al-Iqbāl #257, 27 July 1908](../images/iqbal/small/mic164_alikbal_1908-1909_0118_150dpi.jpg)

# Example header: minimal required header

    <teiHeader xml:lang="en">
        <fileDesc>
            <titleStmt>
                <title level="j" xml:lang="ar-Latn-x-ijmes">al-Iqbāl</title>
                <title type="sub">Digital Edition</title>
            </titleStmt>
            <publicationStmt>
                <p>Unpublished example edition for the DHI Beirut 2015</p>
            </publicationStmt>
            <sourceDesc>
                <p>Transcribed from microfilm copies (classmark Mic-Na:164) located in the AUB library</p>
            </sourceDesc>
        </fileDesc>
    </teiHeader>

# File description `<fileDesc>` 1

- has some **mandatory** elements:
    + `<titleStmt>`: provides a title for the resource and any associated statements of responsibility
    + `<sourceDesc>`: documents the sources from which the encoded text derives (if any)
    + `<publicationStmt>`: documents how the encoded text is published or distributed
- and some **optional** ones:
    + `<editionStmt>`: yes, digital texts have editions too
    + `<seriesStmt>`: and they also fit into "series".
    + `<extent>`: how many CDs, gigabytes, files?
    + `<notesStmt>`: notes of various types

# File description `<fileDesc>` 2

- `<titleStmt>`: contains a mandatory `<title>` which identifies the electronic file (not its source!)
- optionally followed by additional titles, and by ‘statements of responsibility’, as appropriate, using `<author>`, `<editor>`, `<sponsor>`, `<funder>`, `<principal>` or the generic `<respStmt>`
- `<publicationStmt>`: may contain
    + plain text (e.g. to say the text is unpublished)
    + one or more `<publisher>`, `<distributor>`, `<authority>`, each followed by `<pubPlace>`, `<address>`, `<availability>`, `<idno>`

# Title and responsibility statements

Within `<titleStatement>`, you can repeat any of these elements as necessary, and document additional responsbilities with a generic `<respStmt>`

    <titleStmt xml:lang="en">
        <title level="j" xml:lang="ar-Latn-x-ijmes">al-Iqbāl</title>
        <title type="sub">Digital Edition</title>
        <author xml:lang="ar-Latn-x-ijmes">ʿAbd al-Bāsiṭ al-Unsī</author>
        <author xml:lang="ar-Latn-x-ijmes">Muḥammad al-Jisr</author>
        <respStmt>
            <resp>created the TEI files</resp>
            <name>Till Grallert</name>
        </respStmt>
    </titleStmt>

<!-- - The title of the electronic work should be derived from the source text, but clearly distinguishable from it.
- At a minimum, identify the author of the text and (where appropriate) the creator of the file or corpus -->

# Edition and extent statements

- `<editionStmt>`
    + can be used to document the details of this particular edition
    + optional for the first release, but is mandatory for each later release
- `<extent>`
    + approximate size of a text stored on some carrier medium or of some other object, digital or non-digital
    + is sometimes used to document number of words in a corpus

# The publication statement `<publicationStmt>`

- mandatory element
- `<publisher>`, `<distributor>` and/or `<authority>` must be present unless the entire publication statement is given as prose
- If the creation date is different than the date of publication, creation date should be given within `<profileDesc>`, not in the `<publicationStmt>`
- formal license may be entered in `<licence>` included in `<availability>`

# Example: publication statement

    <publicationStmt>
        <publisher>AUB</publisher>
        <distributor>Digital Humanities Institute Beirut</distributor>
        <authority>Till Grallert</authority>
        <pubPlace>Beirut</pubPlace>
        <date from="2015-03-02" to="2015-03-06">2-6 March 2015</date>
        <availability>
            <licence>Licensed with a
                <ref target="http://creativecommons.org/licenses/by/3.0/">Creative Commons Attribution</ref>
                licence.</licence>
        </availability>
    </publicationStmt>

# Series statement: `<seriesStmt>`

These include

- separate items that share a collective title applicable to the group
- two or more volumes of items, similar in character and issued in sequence
- separately numbered sequence of volumes within a serial or serials

# Example: series statement

    <seriesStmt>
        <title level="s">Machine-Readable Texts for the Study of Indian Literature</title>
        <respStmt>
            <resp>ed. by</resp>
            <name>Jan Gonda</name>
        </respStmt>
        <biblScope unit="vol">1.2</biblScope>
        <idno type="ISSN">0 345 6789</idno>
    </seriesStmt>

# Notes statement: `<notesStmt>`

The optional `<notesStmt>` can contain notes on almost any aspect
of the file or its contents:

    <notesStmt>
        <note>Transcribed for DHI Beirut TEI Workshop</note>
    </notesStmt>

These notes can be short statements, or many parargaphs long. Take care to encode such information with more precise elements elsewhere in the TEI header, when such elements are available. For example, text types, such as reportage or detective stories, should be described under `<profileDesc>`

# The source description statement: `<sourceDesc>`

All electronic works need to document their source, **even 'born digital' ones**! There are variety of elements you may draw from:

- prose description, just a `<p>`
- `<bibl>` (bibliographic citation): contains free text and/or any mixture of bibliographic elements such as `<author>`, `<publisher>` etc.
- `<biblStruct>` (structured) contains similar elements but constrained in various ways according to bibliographic standards
- `<biblFull>` (fully-structured) special-cases texts which were born TEI by replicating an embedded `<fileDesc>`
- `<listBibl>` may be used for lists of such descriptions, e.g. bibliographies
- Specialised elements for spoken texts (`<recordingStmt>` etc.) and for manuscripts (`<msDesc>`) <!-- Discussed later! -->
- Authority lists: `<listPerson>`, `<listPlace>`, `<listOrg>`

# Example source: al-Iqbāl #257, 27 July 1908

![Front page of al-Iqbāl #257, 27 July 1908](../images/iqbal/small/mic164_alikbal_1908-1909_0118_150dpi.jpg)

# Example: `<sourceDesc>`

    <sourceDesc xml:lang="en">
        <biblStruct>
            <monogr>
                <title level="j" xml:lang="ar-Latn-x-ijmes">al-Iqbāl</title>
                <title level="j" xml:lang="ar">الاقبال </title>
                <title level="j" type="sub" xml:lang="ar">جريدة اسبوعية تصدر كل يوم الاثنين في <placeName>بيروت</placeName></title>
                <imprint>
                    <publisher xml:lang="ar-Latn-x-ijmes">ʿAbd al-Bāsiṭ al-Unsī</publisher>
                    <publisher xml:lang="ar-Latn-x-ijmes">Muḥammad al-Jisr</publisher>
                    <date when="1908-07-27">Mon, 27 July 1908</date>
                    <pubPlace>Beirut</pubPlace>
                    <biblScope type="vol">7</biblScope>
                    <biblScope type="issue">257</biblScope>
                    <biblScope type="pp">1-8</biblScope>
                </imprint>
            </monogr>
            <idno type="class-mark">Mic-Na:164</idno>
        </biblStruct>
    </sourceDesc>

# Association between header and text

By default everything asserted by a header is true of the text to which it is prefixed. This can be over-ridden:

- as when a text header over-rides or amplifies a corpus-header setting
- when model.declarable elements are selected by means of the @decls attribute (available on all model.declaring elements)
- using special purpose selection/definition elements e.g. `<catRef>` and `<taxonomy>`

Most components of the encoding description are declarable.

# Encoding description: `<encodingDesc>`

`<encodingDesc>` groups notes about the procedures used when the text was encoded, either summarised in prose or within specific elements such as

- `<projectDesc>`: goals of the project
- `<samplingDecl>`: sampling principles
- `<editorialDecl>`: editorial principals, e.g. `<correction>`, `<normalization>`, `<quotation>`, `<hyphenation>`, `<segmentation>`, `<interpretation>`
- `<classDecl>`: classification system/s used
- `<tagsDecl>`: specifics about usage of particular elements

Detailed notes in `<encodingDesc>` could be used to generate section of an editorial description.

# Example: `<encodingDesc>` 1

    <encodingDesc xml:lang="en">
        <projectDesc>
            <p>Creation of a digital corpus of Arabic newspapers from Beirut published in the aftermath of the Young Turk Revolution</p>
        </projectDesc>
        <editorialDecl>
            <correction>
                <p>Apparent errors have been marked as <sic>sic</sic> but correct readings are not provided</p>
            </correction>
            <hyphenation>
                <p>Hyphenation is not common to Arabic texts</p>
            </hyphenation>
        </editorialDecl>
    </encodingDesc>

# Example: `<encodingDesc>` 1

    <encodingDesc>
        <classDecl>
            <taxonomy xml:id="part-of-speech">
                <category xml:id="adje">
                    <catDesc>adjectives</catDesc>
                    <category xml:id="AJ0">
                        <catDesc>adjective (unmarked) (e.g. GOOD, OLD)</catDesc>
                    </category>
                    <category xml:id="AJC">
                        <catDesc>comparative adjective (e.g. BETTER, OLDER)</catDesc>
                    </category>
                    <category xml:id="AJS">
                        <catDesc>superlative adjective (e.g. BEST, OLDEST)</catDesc>
                    </category>
                </category>
                <category xml:id="AT0">
                    <catDesc>article (e.g. THE, A, AN)</catDesc>
                </category>
                <!-- ... -->
            </taxonomy>
        </classDecl>
    </encodingDesc>

# The tagging declaration: `<tagsDecl>`

The `<tagsDecl>` records elements namespace, tag frequency, information about the usage of particular tags not specified elsewhere, and default text appearance in source

# The `<rendition>` element

- `<rendition>`: structured information about appearance in the source document
- rendered using informal prose description, standard stylesheet language (CSS, XSL-FO), or project-defined language.

consider this example:

    <tagsDecl>
        <rendition scheme="css" xml:id="r-center">text-align: center;</rendition>
        <rendition scheme="css" xml:id="r-small">font-size: small;</rendition>
        <rendition scheme="css" xml:id="r-large">font-size: large;</rendition>
    </tagsDecl>

which you can easily point to from the text

    <hi rendition="#r-center #r-large">this bit of text was large and centred</hi>

But compare:

    <hi rend="large center">this bit of text was large and centred</hi>


# The profile description: `<profileDesc>`

A collection of descriptions, categorised only as ‘non-bibliographic’. Default members of the model.profileDescPart class include:

- `<creation>`: information about the origination of the intellectual content of the text, e.g. time and place
- `<langUsage>`: information about languages, registers, writing systems etc. used in the text; **this is particularly important to our example**
- `<calendarDesc>`: information about calendars and dating methods as used in the text; **this is particularly important to our example**
- `<textDesc>` and `<textClass>`: classifications applied to the text by means of a list of specified criteria or by means of a collection of pointers, respectively
- `<particDesc>` and `<settingDesc>`: information about the ‘participants’, either real or depicted, in the text
- `<handNotes>`: information about the particular style or hand distinguished within a manuscript

# Example `<creation>`

    <creation>
        <date when="1918-05"/>
        <placeName>Ripon</placeName>
        <listChange ordered="true">
            <change xml:id="CHG-1">First stage, written in pencil in Owen's hand </change>
            <change xml:id="CHG-2">Second stage, revised in pencil in Owen's hand</change>
            <change xml:id="CHG-3">Fixation of the revised passages and further minor revisions by Owen using ink</change>
            <change xml:id="CHG-4">Addition of another stanza with a different ink, probably at a later stage</change>
        </listChange>
    </creation>

Here `<listChange>` records stages in changes to the document. Further down, in `<revisionDesc>` the same element is used to record changes to the electronic file.

# Language and character set usage

The `<langUsage>` element is provided to document usage of languages and writing systems in the text. Languages are identified by their ISO codes:

    <langUsage>
        <language ident="ar">Arabic</language>
        <language ident="ar-Latn-x-ijmes">Arabic transcribed into Latin script following the IJMES conventions</language>
        <language ident="ar-Latn-EN">Arabic transcribed into Latin script following common English practices</language>
        <language ident="ar-Latn-FR">Arabic transcribed into Latin script following common French practices</language>
        <language ident="en">English</language>
        <language ident="fa">Farsi</language>
        <language ident="fa-Latn-x-ijmes">Farsi transcribed into Latin script following the IJMES conventions</language>
        <language ident="fr">French</language>
        <language ident="ota">Ottoman</language>
        <language ident="ota-Latn-x-ijmes">Ottoman transcribed into Latin script following the IJMES conventions</language>
        <language ident="tr">Turkish</language>
    </langUsage>

# The calendar description

- The `<calendarDesc>` contains a description of the calendar system used in any dating expression found in the text. This element may contain one or more `<calendar>` elements, but it is generally presumed that the absence of any specific declaration signifies the Gregorian calendar
- Each `<calendar>` element contains one or more paragraphs of description for the calendar system concerned, and also supplies an identifying code for it as the value of its @xml:id attribute.

Example:

    <calendarDes>
        <calendar xml:id="cal_islamic">
            <p>Islamic <hi>hijrī</hi> calendar: lunar calendar beginning the Year with 1 Muḥarram.</p>
        </calendar>
        <calendar xml:id="cal_julian">
            <p>Reformed Julian calendar beginning the Year with 1 January.</p>
        </calendar>
        <calendar xml:id="cal_ottomanfiscal">
            <p>Ottoman fiscal calendar: a lunosolar calendar. It is based on the Old Julian calendar beginning the Year with 1 March and synchronised with <hi>hijrī</hi> year count every 33 years.</p>
        </calendar>
    </calendarDes>

# Classification Methods

`<textClass>` groups information which describes the nature or topic of a text in terms of a standard classification scheme, thesaurus, etc. using one or more of the following ways:

- `<catRef>`: direct reference to a locally defined (e.g.in the corpus header) category
- `<classCode>`: reference to some standard and externally defined classification scheme
- `<keywords>`: assign arbitrary descriptive terms taken from a bibliographic controlled vocabulary or a tag cloud

This categorization applies to the whole text. For more fine grained classification, use @decls on e.g. a `<div>` element to point to applicable variation in header.

# Detailed characterization of a text

`<textDesc>` provides a description of a text in terms of its ‘Situational parameters’, a description of the situation whithin which the text was produced or experienced.

    <textDesc n="novel">
        <channel mode="w">print; part issues</channel>
        <constitution type="single"/>
        <derivation type="original"/>
        <domain type="art"/>
        <factuality type="fiction"/>
        <interaction type="none"/>
        <preparedness type="prepared"/>
        <purpose degree="high" type="entertain"/>
        <purpose degree="medium" type="inform"/>
    </textDesc>


# The participants description: `<particDesc>`

`<particDesc>` can just contain paragraphs of prose, or a more structured `<person>` element in `<listPerson>`

Example 1:

    <particDesc xml:id="p2">
        <p>Female informant, well-educated, born in Shropshire UK, 12 Jan 1950, of unknown occupation. Speaks French fluently. Socio-Economic status B2 in the PEP classification scheme </p>
    </particDesc>

-----------------------
Example 2:

    <particDesc xml:lang="ar">
        <listPerson>
            <head>People mentioned in the text</head>
            <person xml:id="pers-1" xml:lang="ar">
                <persName xml:lang="ar">عبد الحميد الثاني</persName>
                <birth>
                    <date calendar="#cal_islamic" datingMethod="#cal_islamic" when="1842" when-custom="1258-08-16">١٦ شعبان ١٢٥٨ </date>
                </birth>
                <death>
                    <date when="1918">١٩١٨</date>
                </death>
                <idno type="GND">118646435</idno>
                <idno type="VIAF">9880442</idno>
                <state calendar="#cal_ottomanfiscal" datingMethod="#cal_ottomanfiscal" notBefore-custom="1876-06-18" xml:lang="en">
                    <p>Sultan of the Ottoman Empire, 1876-1909</p>
                </state>
                <note xml:lang="en">
                    <ref target="https://en.wikipedia.org/wiki/Abdul_Hamid_II">Wikipedia article</ref>
                </note>
            </person>
            <person xml:id="pers-2">
                <persName xml:lang="ar">
                    <forename xml:lang="ar">احمد</forename>
                    <forename xml:lang="ar">حسن</forename>
                    <surname xml:lang="ar">طباره</surname>
                </persName>
                <state xml:lang="en">
                    <p>Editor of <orgName xml:lang="ar-Latn-x-ijmes">Thamarāt al-Funūn</orgName>.</p>
                </state>
            </person>
        </listPerson>
    </particDesc>

# Revision Description: `<revisionDesc>`

- A list of `<change>` elements, each with a @date and @who attributes, indicating significant stages in the evolution of a document. Most recent first.
- Can be grouped into <listChange> elements. Used here it is about the electronic file, used in `<creation>` it is about the document.
- Can be maintained manually, or done by means of a version control system (like SVN)

Example:

    <revisionDesc>
        <change when="2015-02-07">Added detailed profileDesc containing information on languages, calendars, and persons</change>
        <change when="2015-02-06">Added mark-up</change>
        <change when="2015-02-05"><persName>Till Grallert</persName> Created file</change>
    </revisionDesc>

# Some more metadata acronym soup

- DCMI: Dublin Core Metadata Initiative: Very simple standard for describing web resources: 15 ‘lowest common
denominator’ fields
- RDF: Resource Description Framework: W3C standard for representing any kind of resource description using
object oriented concepts: basis of the ‘semantic web’
- EAD: Encoded Archival Description: International standard for describing archival collections
- METS: Metadata Encoding and Transcription Standard: generalised method to integrate different metadata systems

TEI provides a richer vocabulary than EAD or DCMI, and is less abstract than RDF or METS

# Next

That was a whirlwind tour of the kinds of things you can put in the `<teiHeader>`, however be aware that adding some of the other TEI modules can expand what is allowed in the header. (e.g. Manuscript Description)
Now let's do an exercise where we make an existing `<teiHeader>` element better!

