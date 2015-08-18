---
title: Tei@DHIB Introduction
date: 2 March 2015
author: Till Grallert
url: index.html
---

# Introduction

## Workshop: From Analogue Documents to Electronic Texts: Introduction to TEI XML Editing in Multilingual Environments

Dates and location: 2-6 March 2015, 10-12am and 2-4pm, computer lab at Fisk Hall, AUB

Instructor: Till Grallert, OIB, <grallert@orient-institut.org>

Course material: [http://tinyurl.com/dhib2015tei](http://tinyurl.com/dhib2015tei); password "dhibeirut2015tei"

Slides were produced using [MultiMarkDown](http://fletcherpenney.net/multimarkdown/), [Pandoc](http://johnmacfarlane.net/pandoc/), and [Slidy JS code](https://www.w3.org/Talks/Tools/Slidy/slidy.js).

# Goals:

By the end of this week you'll have a basic knowledge of

- XML
- TEI P5
- oXygen
- XPath
- XSLT
- HTML and CSS

and all that in multi-lingual (English and Arabic) environments

# Goals:

... or, in less giberish terms, of 

- data capture / recording in XML
- data modelling following the TEI
- data analysis and transformation through XSLT
- presentation of your data (on the web using HTML and CSS)

# Goals:

... or, since a picture is worth more than a thousand words, as the saying goes, how to get from the paper copies in front of you ...

![Image of *al-Bashīr*](images/bashir-img.png)

# Goals:

... to this ...

![*al-Bashīr* as TEI XML file](images/bashir-oxygen.png)

# Goals:

... and finally to that:

![*al-Bashīr* as website](images/bashir-html.png)

# Goals:

You will also have seen four different early-twentieth century newspapers from Beirut--*al-Bashīr*, *al-Iqbāl*, *Lisān al-Ḥāl*, and *Thamarāt al-Funūn*--and their reaction to the Young Turk Revolution and the restoration of the Ottoman constitution in July 1908. In addition, you will have encountered three different Arabic translations of that very constitution.

# Tentative schedule

The schedule is preliminary and tentative and we'll adopt it to the needs and the tempo of the course:

- Day 1: Introducing the game of XML and TEI
- Day 2: Data capture and organisation
- Day 3: Retrieving and displaying your data 
- Day 4: Enriching your data with names and named entities
- Day 5: Facismile linking

# Day 1: Introduction to the game

## 1 Morning Session

- Short introductory round
- [Lecture 1: Introduction to XML and Tei](TeiDhib-Session01-TeiXml-Slidy.html)

## 2 Afternoon Session

- Introduce our little project of digitising newspapers
- Exercise 1: first look at actual XML files
<!-- - (Short introduction to CSS as we need it to correctly display Arabic in oXygen) -->
- [Lecture 2: core module / structural mark-up](TeiDhib-Session02-TeiCoreModule-Slidy.html)
- Exercise 2a: contemplate the structure of newspaper texts (pen and paper)

# Day 2: data capture and organisation

## 3 Morning Session

<!-- do we first introduce customisation, schemas etc. or first XPath -->

- Exercise 2: 
    + data entry / structural mark-up (90min)
    + produce *well-formed* XML

## 4 Afternoon Session

- [Lecture 3: customisation / schemas](TeiDhib-Session03-SchemaCustomization-Slidy.html)
- Exercise 3: schema customisation
    + produce our own schema and validate our files against it
    + produce *valid* TEI XML

- ([Lecture 4: metadata](TeiDhib-Session04-TeiMetadata-Slidy.html))

# Day 3: retrieving and displaying data

## 5 Morning Session

Participants are free to join other courses of the DHI Beirut from 11 to 11:30

- [Lecture 5: introduction to XPath and XSLT](TeiDhib-Session05-XpathXslt-Slidy.html)
- Exercise: XSLT
    + produce a toc

## 6 Afternoon Session

- Continue exercise from morning session: XSLT 
    + produce a toc
    + produce a HTML view of our XML files

<!-- - (Lecture 6: introduction to more advanced features of XSLT and XPath) -->

# Day 4: names and named entities

## 7 Morning Session

- [Lecture 6: names, people, places, and dates](TeiDhib-Session06-SemanticMarkUp-Slidy.html)
- XML Exercise: Semantic mark-up (60min)
- XSLT Exercise: include semantic mark-up in HTML output

## 8 Afternoon Session

- [Lecture 7: Ontologies of named entities, linking](TeiDhib-Session07-Ontologies-Slidy.html)
- XSLT Exercise: retrieve lists of names
- XML/ XSLT Exercise: link names to ontologies in the teiHeader
- XML Exercise: link to external authorities

# Day 5: Facsimile linking and wrap-up

## 9 Morning Session

- [Lecture 8: Facisimile linking](TeiDhib-Session08-FacsimileLinking-Slidy.html)?
- XML Exercise: link `<pb>`s to facsimiles
- XSLT Exercise: retrieve the image links and display them in the HTML output

## 10 Afternoon Session

- presentation of results
- group discussion
- Q&A on topics to be decided over the course of the week

# Useful links

(this slide will come up again)

- the TEI Consortium's [website](http://www.tei-c.org/index.xml) at http://www.tei-c.org/index.xml:
    + the [TEI guidelines](http://www.tei-c.org/Guidelines/P5/) at http://www.tei-c.org/Guidelines/P5/
    + [TEI by Example](http://www.teibyexample.org/TBE.htm) at http://www.teibyexample.org/TBE.htm
    + the TEI mailing list, <TEI-L@LISTSERV.BROWN.EDU>
    + the [TEI wiki](http://wiki.tei-c.org/index.php) at http://wiki.tei-c.org/: comprising inter alia [TEI cheatsheets](http://wiki.tei-c.org/index.php/TEI_Cheatsheets) at http://wiki.tei-c.org/index.php/TEI_Cheatsheets.
- Further resources provided by the TEI council and Oxford computing centre: 
    + [ROMA](http://www.tei-c.org/Roma/) at http://www.tei-c.org/Roma/: customising TEI schemas for XML validation
    + [OxGarage](http://oxgarage.oucs.ox.ac.uk:8080/ege-webclient/) at http://oxgarage.oucs.ox.ac.uk:8080/ege-webclient/: online resource for conversion between common file formats, using TEI P5 as pivot format. Can be used to produce TEI P5 XML from a .docx file.
    + [DHOxSS](http://digital.humanities.ox.ac.uk/dhoxss/) at http://digital.humanities.ox.ac.uk/dhoxss/: providing the material (including slides and exercises) for years of summer schools.
