---
title: "Leipzig: TEI and rtl-languages; notes"
author: Till Grallert
date: 2015-12-13 15:07:45
---

Grounds I want to cover:

# 1. XML, Unicode, Arabic

- The good: XML follows the unicode standard by design!
- The bad: Each unicode sign is an independent entity
    + Common but "defective" writing of Arabic without the initial *hamza* is different from the correct spelling: a search for "الى" will not return instances of "إلى", "ان" will neither return "إن" nor "أن" out of the box.
    + Arabic numerals are not considered as numerals by the computer (i.e. data type is `xs:string` and not `xs:integer`): a search for "1326" will not return instances of "١٣٢٦" and vice versa.
- The ugly: XML and TEI are based in the western tradition of modelling a text and named entities as well as LTR writing systems 

# 2.a. the good

TEI and XML can represent any text written in any sign-system. If this system is part of the unicode standard, the TEI file can comprise a digital text as opposed to mere facsimiles.

BUT: mixing two writing systems, while unambiguous for the computer, will cause confusion for the human reader / editor:




# Set up your work environment to correctly display Arabic etc.

- oXygen supports the correct display of rtl-languages in the author view, if they are marked up with `@xml:lang`
- otherwise a bit of CSS is needed

# 2.b. the bad

The solution is normalisation. If the text shall be machine-readible, it must be normalised!

# 2.c. the ugly

# 3. Dates and calendars

# 4. Names 
