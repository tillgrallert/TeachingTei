<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:html="http://www.w3.org/1999/xhtml" 
    exclude-result-prefixes="xs"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:output encoding="UTF-8" indent="yes" method="html" omit-xml-declaration="yes"/>
    
    <!-- this stylesheet generates a very simple html page from TEI XML input comprising:
        a) a table of content called through the mToc mode
        b) simple divs, with h1 children and a single paragraph containing all the text-->
    
    <!-- this template creates html pargraph elements for each head element in the TEI source -->
    <xsl:template match="head" mode="mTOC">
        <p>
            <a>
                <xsl:attribute name="href">
                    <xsl:text>#</xsl:text>
                    <xsl:value-of select="generate-id()"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            <xsl:text> - </xsl:text>
            <xsl:value-of select="preceding::pb[1]/@n"/></a>
        </p>
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:result-document href="{substring-before(base-uri(), '.xml')}_toc-v1.html">
        <html>
            <head>
                <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
            </head>
            <body>
        <div>
            <h1>Table of Content: </h1>
            <!-- issues could be split here -->
            <xsl:apply-templates select=".//text//body//head" mode="mTOC"/>
        </div>
                <div>
                    <xsl:apply-templates select=".//text//body"/>
                </div>
            </body>
        </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="div">
        <div>
            <!--<h1><xsl:value-of select="./head"/></h1>-->
            <xsl:apply-templates select="./head"/>
            <p><xsl:value-of select="descendant-or-self::node()[not(self::node()=head)]"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="head">
        <h1>
            <xsl:attribute name="id">
                <xsl:value-of select="generate-id()"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    
   <!-- <xsl:template match="div[@type='section']/head | div[@type='bill']/head">
        <ul>
            <li></li>
        </ul>
    </xsl:template>
    
    <xsl:template match="div[@type='article']/head">
        
        
    </xsl:template>-->
    
</xsl:stylesheet>