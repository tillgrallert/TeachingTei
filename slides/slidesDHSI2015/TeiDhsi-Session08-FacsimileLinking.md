---
title: Tei@DHSI 8 --- Facisimile linking
author: Till Grallert
date: 6 June 2015
---

# Topic: Facsimile linking

The slides are based on those supplied by the various [Digital Humanities Summer Schools at the University of Oxford](http://digital.humanities.ox.ac.uk/dhoxss/) under the [Creative Commons Attribution](http://creativecommons.org/licenses/by/3.0/) license and have been adopted to the needs of the 2015 Introduction to TEI at DHSI and the example of Arabic newspapers and British consular archives.

Slides were produced using [MultiMarkdown](http://fletcherpenney.net/multimarkdown/), [Pandoc](http://johnmacfarlane.net/pandoc/), [Slidy JS](https://www.w3.org/Talks/Tools/Slidy/slidy.js), and the [Snippet](http://steamdev.com/snippet/) jQuery Syntax highlighter.

# A special case of linking: facsimiles

Increasingly people want to do not just 'text' editions but text editions with facing page (or otherwise linked) facsimile images. Indeed, some people want to just have images and create and electronic facsimile (perhaps with a view to later eventual transcription). The `<facsimile>` element, a sibling of `<teiHeader>` and `<text>`, is provided to accommodate this desire.

# Digital facsimiles

- `<facsimile>` contains a representation of some written source in the form of a set of images rather than as transcribed or encoded text
- `<surface>` defines a written surface in terms of a rectangular coordinate space
 	+ `@start` points to an element which encodes the starting position of the text
- `<zone>` defines a rectangular area contained within a `<surface>` element
- Global `@facs` (facsimile) points directly to an image, or to a part of a facsimile element which corresponds with this element.

# Most simple case: mapping 1:1 with `@facs`

If a digital text contains one image per page or column (or similar unit), and no more complex mapping between text and image is envisaged, then the `@facs` attribute may be used to point directly to a graphic resource.

# Example: the facsimile

This image of the first page of a consular report is found at "../images/pro-fo/618-3/DSCN9874_150dpi.jpg"

![first page of PRO FO 618/3, Damascus 30, 3 Aug 1908, Devey to Lowther](../images/pro-fo/618-3/DSCN9874_150dpi.jpg)

# Example: the text linking to the facsimile

	<pb n="1" facs="../images/pro-fo/618-3/DSCN9874_150dpi.jpg"/>
    <div>
        <head>Ex-Mushir Fuad P. released</head>
        <dateline><date>August 3, 1908</date></dateline>
        <dateline>Dft<lb/>
            <persName>Sir Gerald A. Lowther</persName><lb/> K.C.M.G.,C.B., <lb/>
            <placeName><choice>
                    <abbr>Cple</abbr>
                    <expan>Constantinople</expan>
                </choice></placeName>
            <lb/> No. <del>30</del>
            <del>29</del> 30</dateline>
        <dateline>42 Emb.</dateline>
        <p>Sir,
        	<lb/>I have the honour to report to Y.E. that the General Amnesty granted by
        	<persName><choice>
                    <abbr>H.I.M.</abbr>
                    <expan>His Imperial Majesty</expan>
            </choice> the Sultan</persName> to <del>all</del> Political
            <del>criminals was after some hesitation taken to</del>
            <add>exciles was after some hesitation taken to</add> include the Ex-Mushir
            <persName>Fuad Pasha</persName> who has been imprisoned under the
            strictest confinement for the last six and a half years
            <!-- ... -->
        </p>
    </div>

# Using `@facs` in conjunction with `<facsimile>`, `<surface>`, and `<zone>`

Using these attributes and elements together enables an editor to

- associate multiple images with each page
- record arbitrary planar coordinates of textual elements on any kind of surface and link such elements to digital facsimile images of them

# The `<facsimile>` element in the TEI header

The facsimile element is used to represent a digital facsimile. It appears within a TEI document along with, or instead of, the text element introduced in earlier in this course. When this module is selected therefore, a *valid* TEI document may thus comprise any of the following:

- a TEI Header and a text element
- a TEI Header and a facsimile element
- a TEI Header, a facsimile element, and a text element

# Example: `<facsimile>`

	<TEI>
		<teiHeader>
		<!-- ... -->
		</teiHeader>
	   <facsimile>
			<graphic xml:id="facs_1" url="../images/pro-fo/371-560/DSCN7960_150dpi.jpg"/>
			<graphic xml:id="facs_2" url="../images/pro-fo/371-560/DSCN7961_150dpi.jpg"/>
			<graphic xml:id="facs_3" url="../images/pro-fo/371-560/DSCN7962_150dpi.jpg"/>
	   </facsimile>
	   <text>
	   <!-- ... -->
	   </text>
	</TEI>

# Example: `<surface>`

	<TEI>
		<teiHeader>
		<!-- all the header elements -->
		</teiHeader>
	   <facsimile>
	      <surface xml:id="facs_1">
	         <graphic url="../images/pro-fo/371-560/DSCN7960_150dpi.jpg"/>
	         <graphic url="../images/pro-fo/371-560/DSCN7960_300dpi.jpg"/>
	      </surface>
	      <surface xml:id="facs_2">
	         <graphic url="../images/pro-fo/371-560/DSCN7961_150dpi.jpg"/>
	      </surface>
	      <surface xml:id="facs_3">
	         <graphic url="../images/pro-fo/371-560/DSCN7962_150dpi.jpg"/>
	      </surface>
	   </facsimile>
	   <text>
	   <!-- the body of the document, i.e. digital text -->
	   </text>
	</TEI>

# Dimensions

The actual dimensions of the object represented are not documented by the surface element; instead, the surface is located within an abstract coordinate space, which is defined by the following attributes, supplied by the `att.coordinated` class:

- `@ulx` gives the x coordinate value for the upper left corner of a rectangular space
- `@uly` gives the y coordinate value for the upper left corner of a rectangular space.
- `@lrx` gives the x coordinate value for the lower right corner of a rectangular space.
- `@lry` gives the y coordinate value for the lower right corner of a rectangular space.


# Example: `<surface>`

	<facsimile>
		<surface ulx="0" uly="0" lrx="820" lry="1182" xml:id="facs_1"/>
	</facsimile>

*Note*: if no further unit of measurement is provided, pixels are presumed.

# Drawing rectangular shapes

![Kawkab America #55, 28 Apr 1893, p1. (English)](../images/Facsimile1.jpg)

# Addressing the rectangular shapes as `<zone>` elements

The rectangular shapes form the previous can be modelled as `<zone>`s on a larger surface of the page for analytical purposes:

	<surface xml:id="facs_v2-i55_4">
         <graphic url="../images/kawkab/dds-54634_Page_09_Image_0001_2R.tif" xml:id="facs_v2-i55_4_source"/>
         <graphic url="../images/kawkab/dds-54634_Page_09_Image_0001_2R.jpg" xml:id="facs_v2-i55_4_web"/>
         <zone ulx="71" uly="33" lrx="1344" lry="270" xml:id="facs_v2-i55_4_z1" facs="#facs_v2-i55_4_web"/>
         <zone ulx="59" uly="253" lrx="326" lry="964" xml:id="facs_v2-i55_4_z2" facs="#facs_v2-i55_4_web"/>
         <zone ulx="574" uly="39" lrx="804" lry="208" xml:id="facs_v2-i55_4_z3" facs="#facs_v2-i55_4_web"/>
         <zone ulx="71" uly="33" lrx="1344" lry="270" xml:id="facs_v2-i55_4_z4" facs="#facs_v2-i55_4_web"/>
     </surface>

*Note*: as there are two image files, zones indicate on which graphic they were drawn through the `@facs` attribute.

# Optional: a description of a zone's content

The `<desc>` element may be used within either `<surface>` or `<zone>` to provide some further information about the area being defined.

	<surface xml:id="facs_v2-i55_4">
		<desc>A printed page</desc>
		<zone ulx="71" uly="33" lrx="1344" lry="270" xml:id="facs_v2-i55_4_z1" facs="#facs_v2-i55_4_web">
			<desc>The issue's masthead</desc>
		</zone>
	</surface>

# Linking facsimile and transcription: `@xml:id` and `@facs`

- give each relevant part of the facsimile an `@xml:id` identifier
- use the `@facs` attribute to point from the transcription into the
`<facsimile>`

# Linking facsimile and transcription: the same `<facsimile>` again

	<surface xml:id="facs_v2-i55_4">
         <graphic url="../images/kawkab/dds-54634_Page_09_Image_0001_2R.tif" xml:id="facs_v2-i55_4_source"/>
         <graphic url="../images/kawkab/dds-54634_Page_09_Image_0001_2R.jpg" xml:id="facs_v2-i55_4_web"/>
         <zone ulx="71" uly="33" lrx="1344" lry="270" xml:id="facs_v2-i55_4_z1" facs="#facs_v2-i55_4_web"/>
         <zone ulx="59" uly="253" lrx="326" lry="964" xml:id="facs_v2-i55_4_z2" facs="#facs_v2-i55_4_web"/>
         <zone ulx="574" uly="39" lrx="804" lry="208" xml:id="facs_v2-i55_4_z3" facs="#facs_v2-i55_4_web"/>
         <zone ulx="71" uly="33" lrx="1344" lry="270" xml:id="facs_v2-i55_4_z4" facs="#facs_v2-i55_4_web"/>
     </surface>

# Linking facsimile and transcription: the text


	<text corresp="#v2-i55_ar" n="55en" type="issue" xml:id="v2-i55_en" xml:lang="en">
        <pb facs="#facs_v2-i55_4" n="1" xml:id="pb_v2-i55_1en"/>
        <front facs="#facs_v2-i55_4_z1" xml:id="v2-i55_en_front">
           <!-- the masthead -->
           <!-- the main body, which usually does not change between issues -->
           <div style="border-bottom:double black">
              <bibl xml:lang="en"><title level="j">Kawkab America</title><lb/>
                 <title level="j" type="sub">"The Star of America"</title></bibl>
              <bibl rend="center" xml:lang="ar" facs="#facs_v2-i55_4_z3"><title level="j">كوكب اميركا</title><lb/>
                 <title level="j" type="sub">جريدة سياسية علمية تجارية ادبية</title></bibl>
           </div>
           <!-- the bottom line, commonly containing dating information -->
           <div style="border-bottom:solid black" xml:lang="en" facs="#facs_v2-i55_4_z4">
              <bibl xml:lang="en"><biblScope n="2" unit="volume">Vol. 2.</biblScope>
                 <biblScope n="55" unit="issue">No. 55</biblScope>
                 <cb/><pubPlace>New York</pubPlace>, <date when="1893-04-28">Friday, April 28, 1893</date>.</bibl>
           </div>
        </front>
        <body>
        <!-- the body of the issue -->
        </body>
    </text>

# Pointing from `<facsimile>` to the transcription using `@start`

It is also possible to point in the other direction, from a `<surface>` or `<zone>` to the corresponding text. This is the function of the `@start`attribute, which supplies the identi􏰀er of the element containing the transcribed text found within the `<surface>` or `<zone>` concerned.

# Example

Consider this truncated text:

	<text corresp="#v2-i55_ar" n="55en" type="issue" xml:id="v2-i55_en" xml:lang="en">
        <pb facs="#facs_v2-i55_4" n="1" xml:id="pb_v2-i55_1en"/>
        <front facs="#facs_v2-i55_4_z1" xml:id="v2-i55_en_front">
        	<!-- ... -->
        </front>
        <!-- ... -->
    </text>

And this facsimile linking to it:

	<surface start="#pb_v2-i55_1en" xml:id="facs_v2-i55_4">
         <graphic url="../images/kawkab/dds-54634_Page_09_Image_0001_2R.jpg" xml:id="facs_v2-i55_4_web"/>
         <zone start="#v2-i55_en_front" ulx="71" uly="33" lrx="1344" lry="270" xml:id="facs_v2-i55_4_z1" facs="#facs_v2-i55_4_web"/>
         <!-- ... -->
     </surface>

# Conclusion

The "linking" and "transcr" modules provide a wide range of tools to describe relationships between parts of your text. If you use these techniques, remember:

- You should work out a naming scheme to assign ID attributes. You will need a lot of them.
- There are often several ways to do things; use the more specialized markup when you can to make it easier for others to read. Don't rely on `@type` attributes with undefined meanings everywhere.
- Control your vocabulary for token attributes like `@type`
- The TEI only takes you as far as markup. Implementing all this to make a fancy interactive text exploration web site may be a lot of work.

# The Elephant in the room: software implementations

Despite `<facsimile>` being part of TEI P5 from the very beginning, there are **almost no** software implementations available that provide an easy and convenient (graphic) interface for drawing shapes on image files, recording them as zones, and linking them to the transcription. In consequence, most large projects wrote their own software, while small projects use only the most basic function of linking one image per page to the `<pb/>` elements.

Equally, there are **no** out-of-the box software implementations to transform and display the encoded links between bits of transcriptions and zones on the images for presentation purposes.

# Available options

- The **Image Markup Tool**, Windows-only sofware developed by Martin Holmes at UVic
    + writes the `<zones>` and the link to the text to a new TEI P5 file, using its own schema
    + last update in 2012
    + available at [http://www.tapor.uvic.ca/~mholmes/image_markup/](http://www.tapor.uvic.ca/~mholmes/image_markup/)
- **TextGrid**'s TBLE
    + writes the `<zones>` and the link to the text to a new TEI P5 file, using SVG (Scalable Vector Graphics) and its own schema
    + TextGridLab is freely available at [https://www.textgrid.de/en/registrationdownload/download-and-installation](https://www.textgrid.de/en/registrationdownload/download-and-installation/), but requires a free *DAHRIA* account
- The **TEI Facsimile Plugin** for oXygen:
    + allows to draw `<zone>` elements
    + this functional proof of concept was developed by oXygen's Alex Jitianu for the DIXIT camp in Graz, 2014
    + source available at [https://github.com/oxygenxml/TEI-Facsimile-Plugin](https://github.com/oxygenxml/TEI-Facsimile-Plugin)
<!-- - **TILE** ([Text-Image Linking Environment](http://mith.umd.edu/tile/)) -->


<!-- Literature:

- Al-Hajj and Küster, 2011 [The Text-Image-Link-Editor: A tool for Linking Facsimiles & Transcriptions and Image Annotations](dh2011abstracts.stanford.edu/xtf/view?docId=tei/ab-197.xml)
-->