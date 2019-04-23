---
title: Tei@DHSI 7 --- Ontologies of named entities and linking
date: 4 Jun 2015
author: Till Grallert
---

# Topic: prosopographical records, ontologies, and links to external authoritiy files

The slides are based on those supplied by the various [Digital Humanities Summer Schools at the University of Oxford](http://digital.humanities.ox.ac.uk/dhoxss/) under the [Creative Commons Attribution](http://creativecommons.org/licenses/by/3.0/) license and have been adopted to the needs of the 2015 Introduction to TEI at DHSI.

Slides were produced using [MultiMarkdown](http://fletcherpenney.net/multimarkdown/), [Pandoc](http://johnmacfarlane.net/pandoc/), [Slidy JS](https://www.w3.org/Talks/Tools/Slidy/slidy.js), and the [Snippet](http://steamdev.com/snippet/) jQuery Syntax highlighter.

# General notes

<!-- some note on the difference between names and named entities and the idea of stand-off markup -->

Names refer to (named) entities. Information describing entities in detail can be kept in ontologies in the `<profileDesc>` of the TEI header (c.f. our session on metadata). They are then linked to by means of  `@ref` attributes on the names.

<!-- a slide on listPerson, listPlace, and listOrg -->
<!-- links to external authorities -->

# What can we say about named entities?

Potentially, quite a lot...

    <person xml:id="VM1893">
        <persName xml:lang="ru">Владимир Владимирович Маяковский</persName>
        <persName xml:lang="fr">Wladimir Maïakowski</persName>
        <birth when="1893-07-19">7 July (OS) 1893,
            <placeName ref="#BGDT" xml:lang="en">
                <settlement>Baghdati<settlement>, <country>Georgia<country>
            </placeName>
        </birth>
        <death when="1930-04-14"/>
        <occupation>Poet and playwright</occupation>
        <note>Among the foremost representatives of early-20th century Russian Futurism.</note>
    </person>

What elements should the TEI provide for such a purposes?

# Traits, states, and events

As elsewhere in the TEI, we resolve this question by adding a layer of abstraction. We distinguish three *classes* of information:

- `<state>`: more general-purpose, but usually a time-related property (e.g. occupation for a person, population for a place)
- `<trait>`: if you want to a distinguish between time-bound and static, use this for properties that (usually) don't change over time (e.g. eye colour for a person, location for a place)
- `<event>`: an independent event in the real world which may lead to a change in state or trait (e.g. birth for a person, a war for a place)

All these elements are members of the `att.datable` class and thus can have time/dating attributes.

# States

Some typical states for a person

- `<occupation>`: an informal description of a person's trade, profession or occupation
- `<residence>`: a person's present or past places of residence
- `<affiliation>`: an informal description of a person's present or past affiliation with some organization
- `<education>`: a description of the educational experience of a person
- `<floruit>` contains information about a person's period of activity

# Traits

Some typical traits of a person

- `<faith>`: faith, belief system, religion etc. of a person
- `<langKnowledge>`: linguistic knowledge of a person
- `<nationality>`: nationality (socio-politico status)
- `<sex>`: sex
- `<socecStatus>`: socio-economic status

Some typical traits of a place:

- `<climate>`: describes the climate
- `<location>`: describes where a place is (see later)
- `<population>`: describes its population
- `<terrain>`: describes its terrain

Some of these (e.g. sex) have normalised attributes, but mostly they contain free text descriptions.

# Events

For persons, only two specific event elements are defined: `<birth>` and `<death>`. Anything else must be defined using the generic `<event>` element and its `@type` attribute.


    <person xml:id="pers_3">
        <persName xml:lang="ar">
            <forename>نجيب</forename> <forename>يوسف</forename> <surname>عربيلي</surname></persName>
        <persName xml:lang="ar-Latn-EN">
            <forename>Najeeb</forename> <forename xml:lang="en">Joseph</forename> <surname>Arbeely</surname></persName>
        <birth>
            <date when="1861">1861</date>, in <placeName>Damascus</placeName>
        </birth>
        <death>
            <date when="1904">1904, February</date>, in <placeName>New York</placeName>
        </death>
        <event when="1878">
            <p>Migration to the <placeName>USA</placeName></p>
        </event>
        <state from="1885">
            <p>American consul in <placeName>Jerusalem</placeName></p>
        </state>
        <state notBefore="1886">
            <p>Inspector in the <orgName>Bureau of Immigration</orgName> at the port of <placeName>New York</placeName></p>
        </state>
        <state from="1892-04-15" xml:lang="en">
            <p>Editor of <orgName>Kawkab America</orgName>.</p>
        </state>
    </person>


# A place as being defined by its location

The `<location>` element can contain

- a more or less well-structured description using the hierarchy of place name components mentioned earlier (a politico-geographical location)
- a set of geographical co-ordinates

Example:

    <place type="neighbourhood" xml:id="ltg000001">
        <placeName xml:lang="ar-Latn-x-ijmes">Bāb al-Jābiyya</placeName>
        <placeName xml:lang="ar">باب الجابية</placeName>
        <settlement xml:lang="ar" type="city">دمشق الشام</settlement>
        <region xml:lang="ota" type="province" notAfter="1918-10-01">ولاية سورية</region>
        <location>
            <geo>33.507628, 36.301395</geo>
        </location>
    </place>

# Places can self-nest

    <place type="state">
        <placeName xml:lang="en">Ottoman Empire</placeName>
        <placeName xml:lang="ar">الدولة العثمانية العالية</placeName>
        <place type="province">
            <placeName notAfter="1918-10-01" xml:lang="ota ar">ولاية سورية</placeName>
            <placeName notAfter="1918-10-01" xml:lang="en">Province of Syria</placeName>
            <place type="city">
                <placeName type="city" xml:lang="ar">دمشق الشام</placeName>
                <placeName type="city" xml:lang="en">Damascus</placeName>
                <place type="neighbourhood">
                    <placeName xml:lang="ar-Latn-x-ijmes">Bāb al-Jābiyya</placeName>
                    <placeName xml:lang="ar">باب الجابية</placeName>
                    <location>
                        <geo>33.507628, 36.301395</geo>
                    </location>
                </place>
            </place>
        </place>
    </place>

# Organizational names

Organizations have names as well. These are any named collection of people regarded as a single unit. An `<orgName>` can point back to an `<org>` in the header.

    <p>it is debated <date notAfter="1908-10-01">now</date> among ‘<orgName ref="#CUP">Young Turkey</orgName>’ adherents whether it would be right to punish the officials who were led to bribery by the littleness of their pay &amp; its frequent irregularity.</p>

    <org xml:id="CUP">
        <!-- Information about the organization -->
        <orgName xml:lang="en">Committee of Union and Progress</orgName>
    </org>


# All entities can be fictional

    <place type="imaginary">
        <placeName>Atlantis</placeName>
        <location>
            <offset>fifty leagues beyond</offset>
            <placeName>Pillars of
                <persName>Hercules</persName></placeName>
        </location>
    </place>

# Personal relationships

- The `<relation>` (relationship) element describes any kind of relationship or linkage amongst other entities. We distinguish
    + ‘mutual’ relationships (e.g. sibling) from
    + non-mutual or directed relationships (e.g. parent-of ).

- The following attributes are available:
    + `@name`: supplies a name for the kind of relationship of which this is an instance
    + `@active`: identifies the 'active' participants in a non-mutual relationship, or all the participants in a mutual one
    + `@mutual`: supplies a list of participants amongst all of whom the relationship holds equally
    + `@passive`: identifies the ‘passive’ participants in a non-mutual relationship

# Example

    <person xml:id="pers_2">
        <persName xml:lang="en"><addName type="title">Dr.</addName> <forename>Abraham</forename> <surname>Arbeely</surname></persName>
        <!-- ... -->
    </person>
    <person xml:id="pers_3">
        <persName xml:lang="en"><addName type="title">Prof.</addName> <forename>Abraham</forename> <forename>Joseph</forename> <surname>Arbeely</surname></persName>
    <!-- ... -->
    </person>
    <person xml:id="pers_4">
        <persName xml:lang="en"><forename>Najeeb</forename> <forename>Joseph</forename> <surname>Arbeely</surname></persName>
    <!-- ... -->
    </person>
    <!--....-->
    <relationGrp type="children">
        <relation name="parent" active="#pers_4" passive="#pers_2 #pers_3"/>
    </relationGrp>
    <relationGrp type="siblings">
        <realtion name="sibling" mutual="#pers_2 #pers_3"/>
    </relationGrp>

# Nyms

The elements `<listNym>` and `<nym>` are used to document the canonical form of a name or name-component.

- `<nym>`
    + Like a dictionary entry, it can contain model.entryParts (e.g. `<form>`, `<orth>`, `<etym>`) and may also include a number of other `<nym>`s
    + in addition to global attributes and att.typed, it includes the attribute `@parts` to point to constituent `<nym>`s
- `<listNym>` a list of canonical names
- `@nymRef` has been added to the attribute class `att.naming` to refer to the canonical name

# Example


    <nym xml:id="nym-F-737">
        <form xml:lang="ar">شكري</form>
        <form xml:lang="ar-Latn-EN">Shukri</form>
        <form xml:lang="ar-Latn-x-ijmes">Shukrī</form>
        <form xml:lang="tr">Şükrü</form>
    </nym>
    <nym xml:id="nym-F-406">
        <form xml:lang="ar">يوسف</form>
        <form xml:lang="ar-Latn-EN">Yusef</form>
        <form xml:lang="ar-Latn-FR">Youssouf</form>
        <form xml:lang="ar-Latn-x-ijmes">Yūsuf</form>
        <form xml:lang="de">Josef</form>
        <form xml:lang="en">Joseph</form>
        <form xml:lang="tr">Yusuf</form>
    </nym>

# Next

Now let's do an exercise where we make an existing `<teiHeader>` element better by supplying stand-of markup for entities linked to `<persName>` and `<placeName>` elements in the text.