# Topic: Named Entities Mark-up
## Names, people, places, and dates, or the stuff that is most important to social historians

Covered in chapter 13 of the TEI P5 guidelines

<!-- what about measures? -->

The slides are based on those supplied by the various [Digital Humanities Summer Schools at the University of Oxford](http://digital.humanities.ox.ac.uk/dhoxss/) under the [Creative Commons Attribution](http://creativecommons.org/licenses/by/3.0/) license and have been adopted to the example of Arabic newspapers.

Slides were produced using [MultiMarkdown](http://fletcherpenney.net/multimarkdown/), [Pandoc](http://johnmacfarlane.net/pandoc/), [Slidy JS](https://www.w3.org/Talks/Tools/Slidy/slidy.js), and the [Snippet](http://steamdev.com/snippet/) jQuery Syntax highlighter.

# Names, people, and places

We are going to look at **names** of things first. Instances of names are distinct from the entities which they reference. One entity (person, place, organisation) might be known by many names.

# Names in the TEI

TEI provides several ways of marking up names and nominal expressions:

- `<rs>` ("referring string"): any phrase which refers to a person or place, e.g. 'the girl you mentioned', 'my husband'...
- `<name>`: any lexical item recognized as a proper name e.g. 'Siegfried Sassoon' , 'Calais', 'John Doe' ...
- `<persName>`, `<placeName>`, `<orgName>`: 'syntactic sugar' for `<name type="person">` etc.
- A rich set of elements for the components of such nominal expressions, e.g. `<surname>`, `<forename>`, `<geogName>`, `<geogFeat>` etc.

# Entities

Recognising the need to distinguish clearly the encoding of references from the encoding of referenced entities (occurrences in the real world) themselves, the TEI provides provides:

- `<person>` corresponding with `<persName>`
- `<place>` corresponding with `<placeName>`
- `<org>` corresponding with `<orgName>`
- and in addition `<relation>`, `<event>` and others

# Why?

- To facilitate a more detailed and explicit encoding source documents (historical materials for example) which are primarily of interest because they concern objects in the real world
- To support the encoding of "data-centric" documents, such as authority files, biographical or geographical dictionaries and gazeteers etc.
- To represent and model in a uniform way data which is only implicit in readings of many different documents

# Reference theory

*Reference* is a fundamental semiotic concept

- We can talk about the real world using natural languages because we know that some types of word are closely associated with real, specific, objects
- Proper names and technical terms are canonical examples of this kind of word
- '*ʿUṭūfetli Meḥmet ʿAlī Bey Efendi*' refers to a single real world entity; 'Lyon' and 'River Thames' to others: a specific place, a specific river respectively
- When we translate between natural languages, usually the proper names don't change, or are conventionally equivalent

# How do we represent this association?

Every element which is a member of the `att.naming` class inherits two attributes from the `att.canonical` class:

- `@key`: provides an externally-defined means of identifying the entity (or entities) being named, using a coded value of some kind.
- `@ref`: provides an explicit means of locating a full definition for the entity being named by means of one or more URIs.

Note: Arguably, `@key` is redundant, since `@ref` is defined as anyURI, this
can point from the name instance to the @xml:id of metadata about the entity, prefixing it with a '#' if in the same file.

# Other linking attributes

- `@role`: may be used to specify further information about the entity referenced by this name, for example the occupation of a person, or the status of a place.
- `@nymRef`: provides a means of locating the canonical form (`<nym>`) of the *names* associated with the object named by the element bearing it.

Note: `@nymRef` is particularly important for our multi-lingual examples:

```xml
<persName xml:lang="ar">
    <forename nymRef="#nym1">شكري</forename>
    <addName type="title" nymRef="#nym2">باشا</addName>
</persName>
    <persName xml:lang="ota-Latn-x-ijmes">
    <forename nymRef="#nym1">Şükrü</forename>
    <addName type="title" nymRef="#nym2">Paşa</addName>
</persName>
</persName>
    <persName xml:lang="ar-Latn-EN">
    <forename nymRef="#nym1">Shukri</forename>
    <addName type="title" nymRef="#nym2">Pasha</addName>
</persName>
```


# Examples

```xml
<p xml:lang="en">... <name ref="#jsbach" type="person">Johann Sebastian Bach</name> the German composer was born in 1685... </p>
```

or:

```xml
<p xml:lang="ar">نقل الينا البرق خبر صدور الارادة
<lb/> السنية بتعيين <persName ref="#orp">حضرة دولتلو عمر رشدي
<lb/>باشا</persName> قومندان الفيلق الهمايون الخامس
<lb/>سابقاً ناظراً لل<orgName ref="entities:mow">حربية</orgName> وهو دليل على ان نياب
<lb/>عظمته منصرفة الى ما فيه اعلآء شان
<lb/>جيشه الهمايوني وترقيبته سائر الفنون
<lb/>والشؤون العسكرية فلا زالت غيوث
<lb/>اياديه البيضاء تهطل على البلاد من
<lb/>وابل النعم والآلاء ما ينطق الالسنة
<lb/>بالشكر مشفوعاً بالدعاء</p>
```

# References take many forms

Even within a single language, in a single document, there may be many ways of referencing the same person:

```xml
<persName>Leslie Gunston</persName>.... <persName>Leslie</persName> .... <. rs>Wilfred's cousin</rs>
```

The `@ref` can be used simply to combine all references to a specified person:

```xml
<persName ref="#LG">Leslie Gunston</persName>....
<persName ref="#LG">Leslie</persName> ....
<rs ref="#LG">Wilfred's cousin</rs>
<!-- ... elsewhere -->
<person xml:id="LG">
    <persName>Leslie Gunston</persName>
<!-- everything we want to say about Leslie -->
</person>
```

# References are also ambiguous

```xml
<s>Jean likes <name ref="#NN123">Nancy</name></s>
```

Using a more precise element (`<persName>` or `<placeName>`) is
one way of resolving the ambiguity; another is to follow the pointer:

```xml
<person xml:id="NN123">
    <persName>
        <forename>Nancy</forename>
        <surname>Ide</surname>
    </persName>
    <!-- ... -->
</person>
```

or:

```xml
<place xml:id="N123">
    <placeName notBefore="1400">Nancy</placeName>
    <placeName notAfter="0056">Nantium</placeName>
    <!-- ... -->
</place>
```


# Components of `<persName>` elements

```xml
<persName xml:lang="ota" ref="pers1">
    <forename nymRef="#nym1">شكري</forename>
    <addName type="title" nymRef="#nym2">باشا</addName>
</persName>
<persName xml:lang="ar" ref="pers2">
    <forename nymRef="#nym1">شكري</forename>
    <addName xml:lang="ota" type="title" nymRef="#nym3">بك</addName>
    <surname nymRef="#nym4">العسلي</surname>
</persName>
```

Not to mention: `<roleName>` (e.g. 'Emperor'), `<genName>` (eg 'the Elder') `<addName>` (e.g. 'Hammer of the Scots'), `<nameLink>` a link between components (e.g. 'van') etc. all of which can carry `@type` attributes

# `<persName>` works well for Western names, but Arabic or Ottoman?

The canonical scheme of `<surname>` and `<forename>` is insufficient to markup the components of personal names in pre-modern and/or non-Western contexts: How should we mark up the following names?

- حضرة صاحب الدولة المشير عبد الله باشا
- جناب رفعتلو فريد افندي كركبي
- حضرة سعادتلو احمد برهان الدين بك افندي
- جناب عزتلو صبحي بك ابو النصر
- جزائري زاده الامير علي باشا ابن عبد القادر افندي الحسني

# Soualah and Hassoun's proposal for classical Arabic names

[Soulah and Hassoun 2012](http://jtei.revues.org/398) propose to use available elements `<surname>`, `<forename>`, and `<addName>` with a controlled vocabulary of `@type` and `@subtype` attributes.

- `<surname>`: to encode the *laqab* evoking a real or assigned quality
- `<forename>`: for the *ism*
- `<addName>` with `@type`
    + "patronym": introduced by "ibn" or "ibnat"
    + "kunyah": a mark of distinction applied to prominent figures to honor them. For example, “Abū Yūsuf” is often used for someone called Yaʿqūb
    + "khitab": an honorific name, which is usually ended by the suffix al-Dīn
    + "nisbah": an adjective formed by using the suffix ī in order to indicate the person origin, his birth place, or his residence. It represents the relationship name, which can be a genealogical, political or ideological affiliation of a person.

# Extended proposal for late Ottoman contexts

I suggest to add the following values to the `@type` attribute of `<addName>`

- "title": covering the wide range of Ottoman titles, e.g. Pasha, Bey, Efendi
- "honorific": for the highly regularised honorific addresses and salutations, e.g. rif'etli, saadetli, utufetli, lizetli, devletli

# Example

```xml
<persName xml:lang="ar"> جزائري زاده الامير علي باشا ابن عبد القادر افندي الحسني</persName>
```

Could be marked up as:

```xml
<persName xml:lang="ar">
    <addName type="nisbah">جزائري</addName>
    <addName type="honorific" xml:lang="ota">زاده</addName>
    <addName type="title">الامير</addName>
    <forename>علي</forename>
    <addName type="title" xml:lang="ota">باشا</addName>
    <addName type="patronym">ابن
        <forename>عبد القادر</forename>
        <addName type="title" xml:lang="ota">افندي</addName>
    </addName>
    <surname type="laqab">الحسني</surname>
</persName>
```




# Components of place names

- `<placeName>` (names can be made up of other names)
- `<geogName>` a name associated with some geographical feature such as a mountain or river
- `<geogFeat>` a term for some particular kind of geographical feature e.g. 'Mount', 'Lake'

For example:

```xml
<placeName xml:lang="fr">
    <geogFeat>Mont</geogFeat>
    <geogName>Blanc</geogName>
</placeName>
<placeName xml:lang="ar">
    <geogFeat>نهر</geogFeat>
    <geogName>بيروت</geogName>
</placeName>
```

# Geo-political place names

1. `<bloc>`: name of a geo-political unit consisting of two or more nation states or countries.
2. `<country>`: name of a geo-political unit, such as a nation, country, colony, or commonwealth, larger than or administratively superior to a region and smaller than a bloc.
3. `<region>`: name of an administrative unit such as a state, province, or county, larger than a settlement, but smaller than a country.
4. `<settlement>`:  name of a settlement such as a city, town, or village identified as a single geo-political or administrative unit.
5. `<district>`: contains the name of any kind of subdivision of a settlement, such as a parish, ward, or other administrative or geographic unit.

# The `<date>` element

Temporal information can be encoded with:

- `<date>`: contains a date in any format.
- `<time>` contains a phrase defining a time of day in any format.
<!-- - `<offset>` marks that part of a relative temporal or spatial expression which indicates the direction of the offset between the two place names, dates, or times involved in the expression.-->

Example:

```xml
<div type="article">
    <p>
        <date>يوم السبت الماضي</date>عاد الينا على
        <lb/>الباخرة الافرنسية <persName>جناب الوجيه الخواجا
        <lb/>سركست</persName> صاحب محل وبر المشهور
        <lb/>وقنصل كل من <placeName>الداتمرك</placeName> و<placeName>اسوج</placeName> فلقيه
        <lb/>على البحر موظفو المحل وعدد من
        <lb/>الاصدقاء فنهنئه بالعود سالماً</p>
    <ab rend="center">---</ab>
</div>
```


# W3C Date Formats

All the elements above are 'datable' and so can be associated with a more or less exact date or date range using any combination of the following attributes (class `att.datable`):

- `@when`: supplies the value of a date or time in a standard form
- `@notBefore`: specifies the earliest possible date for the event in standard form
- `@notAfter`: specifies the latest possible date for the event in standard form
- `@from`: indicates the starting point of the period in standard form
- `@to`: indicates the ending point of the period in standard form

# Calendars

Similar to the conceptualisation of personal names, current dating standards favour the contemporary Western model--i.e. without further specification all dated attributes refer to the Gregorian calendar.

All other calendars--in our case this means *hijrī*, *mālī*, and *rūmī*--should be declared and documented using the `<calendarDesc>` in the `<profileDesc>` in the TEI header. They can then be referenced through:

- `@calendar`: indicates the system or calendar to which the date represented by the content of this element belongs.
- `@datingMethod`: supplies a pointer to a `<calendar>` element or other means of interpreting the values of the custom dating attributes:
    + the members of `att.datable.custom`: `@when-custom`, `@notBefore-custom` etc.

# The islamic calendar: *hijrī*

```xml
<calendar xml:id="cal_islamic">
  <p>Islamic <hi>hijrī</hi> calendar: lunar calendar beginning the Year with 1 Muḥarram. Dates differ between locations as the beginning of the month is based on sightings of the new moon.</p>
  <p>E.g. <date calendar="#cal_islamic" datingMethod="#cal_islamic" when="1841-05-23" when-custom="1257-04-01">1 Rab II 1257, Sunday</date>, <date calendar="#cal_islamic" datingMethod="#cal_islamic" when="1908-03-05" when-custom="1326-02-01">1 Ṣaf 1326, Thursday</date>.</p>
</calendar>
```

Note: The official **XPath** specifications have a bug that prevents the computation of Islamic *hijrī* dates. To remedy this and other issues, I wrote a number of *XSLT stylesheets* for converting dates between the four calendars in use in the Ottoman Empire, which can be found on [GitHub](https://github.com/tillgrallert/xslt-calendar-conversion) ([https://github.com/tillgrallert/xslt-calendar-conversion](https://github.com/tillgrallert/xslt-calendar-conversion)).

# The (reformed) Julian calendar: *rūmī*, *sharqī*

```xml
<calendar xml:id="cal_julian">
  <p>Reformed Julian calendar beginning the Year with 1 January. In the Ottoman context usually referred to as <hi>rūmī</hi>. Arabic newspapers usually labelled this calendar as <hi>sharqī</hi>.</p>
  <p>All solar calendars add an intercalated 366th day every fourth (and, in the case of Gregorian and rūmī calendars, even-numbered) year at the end of February (the last day of the old Julian calendar). The Gregorian calendar suppresses this rule in centesimal years that cannot be divided by 400. This difference creates a growing offset between Gregorian and Julian calendars: while 1900 R was a leap year, 1900 was not, which in turn caused the difference between the Gregorian calendar, on the one hand, and the <hi>mālī</hi> and <hi>rūmī</hi> calendars, on the other, to grow from 12 to 13 days from 29 Shubāṭ (February) 1900 R / 1315 M (13 March 1900) onwards.</p>
  <p>E.g. <date calendar="#cal_julian" datingMethod="#cal_julian" when="1841-05-23" when-custom="1841-05-11">11 Ayyār 1841, Sunday</date>, <date calendar="#cal_julian" datingMethod="#cal_julian" when="1908-03-05" when-custom="1908-02-21">21 Shub 1908, Thursday</date>.</p>
</calendar>
```

# The Ottoman fiscal calendar: *mālī*, *rūmī* (sic!)

```xml
<calendar xml:id="cal_ottomanfiscal">
  <p>Ottoman fiscal calendar: a lunosolar calendar. It is based on the Old Julian calendar beginning the Year with 1 March. Introduced as fiscal calendar in 1676 and in the Ottoman context usually referred to as <hi>mālī</hi> and sometimes, confusingly, also as <hi>rūmī</hi>. Every 33 lunar years, a <hi>hijrī</hi> year would complete within a single solar <hi>mālī</hi> year. In this case the counting of the <hi>mālī</hi> years skipped a year to catch up with the faster <hi>hijrī</hi> calendar. Due to a printing error in the coupon booklets for the consolidated debt repayment program for 1872 (1288 M instead of 1289 M), synchronisation of <hi>mālī</hi> and <hi>hijrī</hi> years was henceforth abolished. As <hi>mālī</hi> years began with 1 March, <hi>mālī</hi> leap years preceded their <hi>rūmī</hi> and Gregorian counterpart (the leap year 1315 M commenced on 13 March 1899).</p>
  <p>E.g. <date calendar="#cal_ottomanfiscal" datingMethod="#cal_ottomanfiscal" when="1841-05-23" when-custom="1257-03-11">11 Māyis 1257, Sunday</date>, <date calendar="#cal_ottomanfiscal" datingMethod="#cal_ottomanfiscal" when="1908-03-05" when-custom="1323-12-21">21 Shub 1323, Thursday</date>.</p>
</calendar>
```

# Example

```xml
<div type="article">
    <p>
        <date datingMethod="#cal_islamic" calendar="#cal_islamic" when-custom="1307-03-08" when="1889-11-02">يوم السبت الماضي</date>عاد الينا على
        <lb/>الباخرة الافرنسية <persName>جناب الوجيه الخواجا
        <lb/>سركست</persName> صاحب محل وبر المشهور
        <lb/>وقنصل كل من <placeName>الداتمرك</placeName> و<placeName>اسوج</placeName> فلقيه
        <lb/>على البحر موظفو المحل وعدد من
        <lb/>الاصدقاء فنهنئه بالعود سالماً</p>
    <ab rend="center">---</ab>
</div>
```

# Next:

Now let's do an exercise where we markup entities in the newspaper texts using `<persName>`, `<placeName>`, `<orgName>`, and `<date>` with their various attributes.


