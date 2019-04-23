# Topic: Putting the files to use: XPath and XSLT

The slides are based on those supplied by the various [Digital Humanities Summer Schools at the University of Oxford](http://digital.humanities.ox.ac.uk/dhoxss/) under the [Creative Commons Attribution](http://creativecommons.org/licenses/by/3.0/) license and have been adopted to the example of Arabic newspapers.

Slides were produced using [MultiMarkdown](http://fletcherpenney.net/multimarkdown/), [Pandoc](http://johnmacfarlane.net/pandoc/), [Slidy JS](https://www.w3.org/Talks/Tools/Slidy/slidy.js), and the [Snippet](http://steamdev.com/snippet/) jQuery Syntax highlighter.

# What is the XSL family?

- *XPath*: a language for expressing paths through XML trees
- *XSLT*: a programming language for transforming XML
- *XSL FO*: an XML vocabulary for describing formatted pages (we won't cover this)

# XSLT

The XSLT language is

- expressed in XML
- uses namespaces to distinguish output from instructions
- purely functional
- reads and writes XML trees

It was designed to generate XSL FO, but now widely used to generate HTML.

# What is a transformation?

Take this:

    <persName>
        <forename>Milo</forename>
        <surname>Casagrande</surname>
    </persName>
    <persName>
        <forename>Corey</forename>
        <surname>Burger</surname>
    </persName>
    <persName>
        <forename>Naaman</forename>
        <surname>Campbell</surname>
    </persName>

and make this:

    <item n="1">
        <name>Burger</name>
    </item>
    <item n="2">
        <name>Campbell</name>
    </item>
    <item n="3">
        <name>Casagrande</name>
    </item>

# A text example

Take this:

    <div n="34" type="recipe">
        <head>Pasta for beginners</head>
        <list>
            <item>Pasta</item>
            <item>Grated cheese</item>
        </list>
        <p>Cook the pasta and mix with the cheese</p>
    </div>

and make this:

    <html>
        <h1>34: Pasta for beginners</h1>
        <p>Ingredients: Pasta Grated cheese</p>
        <p>Cook the pasta and mix with the cheese</p>
    </html>

# How do you express that in XSL?

    <xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:template match="div">
            <html>
                <h1>
                    <xsl:value-of select="@n"/>:
                    <xsl:value-of select="head"/></h1>
                <p>Ingredients:
                    <xsl:apply-templates select="list/item"/></p>
                <p>
                    <xsl:value-of select="p"/>
                </p>
            </html>
        </xsl:template>
    </xsl:stylesheet>

Note: the namespace declaration linking xsl: to http://www.w3.org/1999/XSL/Transform

# Structure of an XSL file

    <xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:template match="div">
            <!-- .... do something with div elements....-->
        </xsl:template>
        <xsl:template match="p">
            <!-- .... do something with p elements....-->
        </xsl:template>
    </xsl:stylesheet>

- The `div` and `p` are *XPath expressions*, which specify which bit of the document is matched by the template.
- Any element not starting with **xsl:** in a template body is put into the output.

# The golden rules of XSLT

1. If there is no template matching an element, we go on and process the elements inside it
2. If there are no elements to process by Rule 1, any text inside the element is output
3. Children elements are not processed by a template unless you explicitly say so
4. `<xsl:apply-templates select="XX"/>` looks for templates which match element "XX"; `<xsl:value-of select="XX"/>` simply gets any text from that element
5. The order of templates in your program file is immaterial
6. You can process any part of the document from any template
7. Everything is well-formed XML. Everything!

# Important "magic"

Our examples and exercises all start with two important attributes on `<stylesheet>`:

    <xsl:stylesheet
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xpath-default-namespace="http://www.tei-c.org/ns/1.0"
        version="2.0">

This indicates that

1. In our XPath expressions, any element name without a namespace is assumed to be in the TEI namespace
2. We want to use version 2.0 of the XSLT specification. This means that we must use the Saxon processor for our work.

# A simple test file

    <text>
        <front>
            <div>
                <p>Material up front</p>
            </div>
        </front>
        <body>
            <div>
                <head>Introduction</head>
                <p rend="it">Some sane words</p>
                <p>Rather more surprising words</p>
            </div>
        </body>
        <back>
            <div>
                <p>Material in the back</p>
            </div>
        </back>
    </text>

# XSL feature: apply-templates

    <xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xpath-default-namespace="http://www.tei-c.org/ns/1.0">
        <xsl:template match="/">
            <html>
                <xsl:apply-templates/>
            </html>
        </xsl:template>
        <xsl:template match="TEI">
            <xsl:apply-templates select="text"/>
        </xsl:template>
        <xsl:template match="text">
            <h1>FRONT MATTER</h1>
            <xsl:apply-templates select="front"/>
            <h1>BODY MATTER</h1>
            <xsl:apply-templates select="body"/>
        </xsl:template>
    </xsl:stylesheet>

# XSL feature: value-of

Templates for paragraphs and headings

    <xsl:template match="p">
            <p>
                <xsl:apply-templates/>
            </p>
        </xsl:template>
        <xsl:template match="div">
            <h2>
                <xsl:value-of select="head"/>
            </h2>
            <xsl:apply-templates/>
        </xsl:template>
    <xsl:template match="div/head"/>

Notice how we avoid getting the heading text twice.
Why did we need to qualify it to deal with just `<head>` inside `<div>`?

# More complex patterns

The @select attribute can point to any part of the document. Using XPath expressions, we can find:

expression | meaning
-|-
/ | the root of document (outside the root element)
* | any element
text() | only the text content of a node
name | an element called `name`
@name | an attribute called `name`

Example of a complete path in `<value-of>`:
`<xsl:value-of select="/TEI/teiHeader/fileDesc/titleStmt/title"/>`

# XPath

XPath is the basis of most other XML querying and transformation languages.

- It is a syntax for accessing parts of an XML document
- It uses a path structure to define XML elements
- It has a library of standard functions
- It is a W3C Standard and one of the main components of XQuery and XSLT

# Example text

    <body n="anthology">
        <div type="poem">
            <head>The SICK ROSE </head>
            <lg type="stanza">
                <l n="1">O Rose thou art sick.</l>
                <l n="2">The invisible worm,</l>
                <l n="3">That flies in the night </l>
                <l n="4">In the howling storm:</l>
            </lg>
            <lg type="stanza">
                <l n="5">Has found out thy bed </l>
                <l n="6">Of crimson joy:</l>
                <l n="7">And his dark secret love </l>
                <l n="8">Does thy life destroy.</l>
            </lg>
        </div>
    </body>

# Example XPath expressions

![XPathExercise 01](images/XPathExercise01.png)

---------------------------

![XPathExercise 02](images/XPathExercise02.png)

---------------------------

![XPathExercise 03](images/XPathExercise03.png)

---------------------------

![XPathExercise 04](images/XPathExercise04.png)

---------------------------

![XPathExercise 05](images/XPathExercise05.png)

---------------------------

![XPathExercise 06](images/XPathExercise06.png)

---------------------------

![XPathExercise 07](images/XPathExercise07.png)

---------------------------

![XPathExercise 08](images/XPathExercise08.png)

---------------------------

![XPathExercise 09](images/XPathExercise09.png)

---------------------------

![XPathExercise 10](images/XPathExercise10.png)

---------------------------

![XPathExercise 11](images/XPathExercise11.png)

---------------------------

![XPathExercise 12](images/XPathExercise12.png)

---------------------------

![XPathExercise 13](images/XPathExercise13.png)

---------------------------

![XPathExercise 14](images/XPathExercise14.png)

---------------------------

![XPathExercise 15](images/XPathExercise15.png)

---------------------------

![XPathExercise 16](images/XPathExercise16.png)

---------------------------

![XPathExercise 17](images/XPathExercise17.png)

---------------------------

![XPathExercise 18](images/XPathExercise18.png)

---------------------------

![XPathExercise 19](images/XPathExercise19.png)

---------------------------

![XPathExercise 20](images/XPathExercise20.png)

---------------------------

![XPathExercise 21](images/XPathExercise21.png)

---------------------------

![XPathExercise 22](images/XPathExercise22.png)

---------------------------

![XPathExercise 23](images/XPathExercise23.png)

---------------------------

![XPathExercise 24](images/XPathExercise24.png)

---------------------------

![XPathExercise 25](images/XPathExercise25.png)

---------------------------

![XPathExercise 26](images/XPathExercise26.png)

# XPath: More about paths

- A location path results in a node-set
- Paths can be absolute: `/div/lg[1]/l`
- Paths can be relative: `l/../../head`
- Formal Syntax: `axisname::nodetest[predicate]`
- For example: `child::div[contains(head, 'ROSE')]`

# XPath: axes (1)

- `self::` Contains the current node
- `attribute::` Contains all attributes of the current node
- `parent::` Contains the parent of the current node
- `ancestor::` Contains all ancestors (parent, grandparent, etc.) of the current node
- `ancestor-or-self::` Contains the current node plus all its ancestors (parent, grandparent, etc.)
- `child::` Contains all children of the current node
- `descendant::` Contains all descendants (children, grandchildren, etc.) of the current node
- `descendant-or-self::` Contains the current node plus all its descendants (children, grandchildren, etc.)

# XPath: axes (2)

- `following::` Contains everything in the document after the closing tag of the current node
- `following-sibling::` Contains all siblings after the current node
- `preceding::` Contains everything in the document that is before the starting tag of the current node
- `preceding-sibling::` Contains all siblings before the current node

# Example: XPath axes

- `ancestor::lg` = all `<lg>` ancestors
- `ancestor-or-self::div` = all `<div>` ancestors or current
- `attribute::n` = `n` attribute of current node
- `child::l` = `<l>` elements directly under current node
- `descendant::l` = `<l>` elements anywhere under current node
- `descendant-or-self::div` = all `<div>` children or current
- `following-sibling::l[1]` = next `<l>` element at this level
- `preceding-sibling::l[1]` = previous `<l>` element at this level
- `self::head` = current `<head>` element

# XPath: predicates (conditions)

- `child::lg[attribute::type='stanza']`
- `child::l[@n='4']`
- `child::div[position()=3]`
- `child::div[4]`
- `child::l[last()]`
- `child::lg[last()-1]`

# XPath: abbreviated syntax

- nothing is the same as `child::`, so `lg` is short for `child::lg`
- `@` is the same as `attribute::`, so `@type` is short for `attribute::type`
- `.` is the same as `self::`, so `./head` is short for `self::node()/child::head`
- `..` is the same as `parent::`, so `../lg` is short for `parent::node()/child::lg`
- `//` is the same as `descendant-or-self::`, so `div//l` is short for `child::div/descendant-or-self::node()/child::l`

# XSL example: context-dependent matches

Compare

    <xsl:template match="head"> .... </xsl:template>

with

    <xsl:template match="div/head"> ... </xsl:template>
    <xsl:template match="figure/head"> ....</xsl:template>

# XSL processor: priorities when templates conflict

It is possible for it to be ambiguous which template is to be used:

    <xsl:template match="person/name">... </xsl:template>
    <xsl:template match="name">... </xsl:template>

Which template is used when the processor meets a `<name>` element?

# XSL processor: solving priorities

There is a @priority attribute on `<template>`; the **higher** the value, the more inclined the XSLT engine is to use it:

    <xsl:template match="name" priority="1">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="person/name" priority="2">
        A name
    </xsl:template>

# XSL processor: general template priority

The normal rule is that **the most specific template is applied**.

    <xsl:template match="*">
        <!-- ... -->
    </xsl:template>
    <xsl:template match="tei:*">
        <!-- ... -->
    </xsl:template>
    <xsl:template match="p">
        <!-- ... -->
    </xsl:template>
    <xsl:template match="div/p">
        <!-- ... -->
    </xsl:template>
    <xsl:template match="div/p/@n">
        <!-- ... -->
    </xsl:template>

# XSL: pushing and pulling

XSLT stylesheets can be characterized as being of two types:

1. *push*: In this type of stylesheet, there is a different template for every element, communication via `<xsl:apply-templates>` and the overall result is assembled from bits in each template. It is sometimes hard to visualize the final design. **Common for data-oriented processing where the structure is fixed**.
2. *pull*: In this type, there is a master template (usually matching `/`) with the main structure of the output, and specific `<xsl:for-each>` or `<xsl:value-of>` commands to grab what is needed for each part. The templates tend to get large and unwieldy. **Common for document-oriented processing where the input document structure varies**.

# XSL: attribute value template (1)

How can we turn this:

    <ref target="http://www.oucs.ox.ac.uk/">OUCS</ref>

into that:

    <a href="http://www.oucs.ox.ac.uk/"/>

if the following **does not** work:

    <xsl:template match="ref">
        <a href="@target">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

as it will produce:

    <a href="@target">OUCS</ref>

# XSL: attribute value template (1)

Instead we have two options to give the @href attribute whatever value the @target attribute has

Use `{}` to indicate that the expression must be **evaluated**:

    <xsl:template match="ref">
        <a href="{@target}">
            <xsl:apply-templates/>
        </a>
    </xsl:template>

Use `<xsl:attribute>`

    <xsl:template match="ref">
        <a>
            <xsl:attribute name="href" select="@target"/>
            <xsl:apply-templates/>
        </a>
    </xsl:template>

# XSL feature: for-each

If we want to avoid lots of templates, we can do in-line looping over
a set of elements. For example:

    <xsl:template match="listPerson">
        <ul>
            <xsl:for-each select="person">
                <li>
                    <xsl:value-of select="persName"/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

compare to:

    <xsl:template match="listPerson">
        <ul>
            <xsl:apply-templates select="person"/>
        </ul>
    </xsl:template>
    <xsl:template match="person">
        <li>
            <xsl:value-of select="persName"/>
        </li>
    </xsl:template>

# XSL feature: if

We can make code conditional on a test being passed. The @test can use **any** XPath facilities:

    <xsl:template match="person">
        <xsl:if test="@sex='2'">
            <li>
                <xsl:value-of select="persName"/>
            </li>
        </xsl:if>
    </xsl:template>

compare to:

    <xsl:template match="person[@sex='1']">
        <li>
            <xsl:value-of select="persName"/>
        </li>
    </xsl:template>
    <xsl:template match="person"/>


# XSL feature: choose

We can make a multi-value choice conditional on what we find in
the text:

    <xsl:template match="person">
        <xsl:apply-templates/>
        <xsl:choose>
            <xsl:when test="@sex='1'">(male) </xsl:when>
            <xsl:when test="@sex='2'">(female) </xsl:when>
            <xsl:when test="not(@sex)">(no sex specified) </xsl:when>
            <xsl:otherwise>(unknown sex)</xsl:otherwise>
        </xsl:choose>
    </xsl:template>

# Summary / next

Now you can

1. Write templates which match any element or attribute
2. Pick out text from anywhere
3. Write code conditional on something in the text

And we are going to put this knowledge to use on our XML files

# Useful links

- [TEI boilerplate](http://dcl.slis.indiana.edu/teibp/) at [http://dcl.slis.indiana.edu/teibp/](http://dcl.slis.indiana.edu/teibp/): Displaying TEI P5 XML files in a web browser without prior conversion to HTML (the implementation uses XSL which is processed by the browser)
- [OxGarage](http://oxgarage.oucs.ox.ac.uk:8080/ege-webclient) at [http://oxgarage.oucs.ox.ac.uk:8080/ege-webclient](http://oxgarage.oucs.ox.ac.uk:8080/ege-webclient): a web interface to the XSL stylesheets and its profiles
    + generate schemas using the same tools as Roma
    + convert documentation to HTML, ePub, and DOCX
    + convert between TEI XML and Word DOCX
    + perform all the ODD tasks using web services
    + chain sets of transformations together

