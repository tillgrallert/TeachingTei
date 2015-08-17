<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" 
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output method="html" encoding="UTF-8" name="html"/>
    <xsl:output method="xml" name="xml" indent="no"/>
    
    <xsl:template match="/">
        <!-- this saves an html file at the same location as our source XML  -->
        <xsl:result-document href="{substring-before(base-uri(), '.xml')}.html" method="html">
            <html>
                <head>
                    <style type="text/css">
                       /* body {
                            padding: 1em;
                            font-family:"American Typewriter", Helvetica, Arial
                        }
                        h1 {
                            border-bottom:solid 1px black;
                            text-align:center;
                        } */
                    </style>
                </head>
                <body>
                    <h1><xsl:value-of select="//fileDesc/titleStmt/title[1]"/></h1>
                    <div>
                        <h2>Contents:</h2>
                        <ul>
                            <!-- we create a new list for each newspaper issue -->
                            <xsl:for-each select="//text[@type='issue']">
                                <li>
                                    <h2>Issue: <xsl:value-of select="./front//bibl/biblScope[@unit='issue']/@n"/>, <xsl:value-of select="./front//bibl/date"/></h2>
                                    <!-- inside each newspaper issue, we want to create a list of headlines -->
                                    <ul>
                                        <xsl:for-each select="./body//div/head">
                                            <!-- this is rather useless idea: sorting head lines -->
                                            <!-- <xsl:sort select="." order="ascending"/> -->
                                            <!-- this retrieves the headline and the encoded page numbers -->
                                            <li><xsl:value-of select="."/> ... p. <xsl:value-of select="preceding::pb[1]/@n"/></li>
                                            <!-- we tried to compute the page number, but we failed -->
                                            <!-- <li><xsl:value-of select="."/> ... p. <xsl:value-of select=" count(ancestor::text[1]/descendant::pb)"/></li> -->
                            </xsl:for-each>
                                    </ul>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </div>
                <div>
                    <xsl:apply-templates select="//text[@type='issue']"/>
                </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="text[@type='issue']">
        <xsl:apply-templates select="./body//div[@type='article']"/>
    </xsl:template>
    
    <xsl:template match="div">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div/head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    <xsl:template match="p">
        <p>
            <!-- we count the current paragraph -->
            <xsl:attribute name="n"><xsl:value-of select="count(preceding::p)+1"/></xsl:attribute>
            <xsl:apply-templates/></p>
    </xsl:template>
  
</xsl:stylesheet>