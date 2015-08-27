<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:output encoding="UTF-8" indent="yes" method="html" omit-xml-declaration="yes"/>
    
    
    <xsl:include href="Functions.xsl"/>
    <xsl:include href="HtmlBasics.xsl"/>
    
    <!-- generate a new file -->
    <xsl:template match="TEI">
        <xsl:result-document href="{substring-before(base-uri(), '.TEIP5.xml')}-toc.html">
            <html> 
                <head>
                    <title><xsl:apply-templates select="./teiHeader/fileDesc/titleStmt/title"/></title>
                    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
                    <link href="https://cdn.rawgit.com/tillgrallert/TeachingTei/master/css/html_arabicNewspapers.css" rel="stylesheet" type="text/css"/>
                    <link href="../css/html_arabicNewspapers.css" rel="stylesheet" type="text/css"/>
                </head>
                <body>
                    <xsl:apply-templates select="./text"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <!-- create the toc -->
    <xsl:template match="text[@type='issue']">
        <div class="cToc" id="toc">
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <h2 lang="en">
                <xsl:text>Headings of issue </xsl:text>
                <xsl:value-of select="@n"/>
                <xsl:text>:</xsl:text>
            </h2>
            <ul>
                <xsl:apply-templates select="./body/div" mode="mTOC"/>
            </ul>
        </div>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- create a sub-list and list item (li) for each bill, section, or article -->
    <xsl:template match="div[@type='bill'] | div[@type='section'] | div[@type='article']" mode="mTOC">
        <li>
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <xsl:apply-templates select="./head" mode="mTOC"/>
            <xsl:if test="./div">
                <ul>
                    <xsl:apply-templates select="./div" mode="mTOC"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
  
  
    <!-- <xsl:template match="div[@type='article']">
        <li>
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <xsl:apply-templates select="./head"/>
        </li>
    </xsl:template>-->
    
    <!-- create the clickable links to heads in the  toc -->
    <xsl:template match="head" mode="mTOC">
        <a href="#{generate-id()}">
            <xsl:value-of select="preceding::pb[1]/@n"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates/>
        </a>
    </xsl:template>
    
    <!-- create the anchor for each head in the text -->
    <xsl:template match="head" priority="2">
        <h1 id="{generate-id()}">
            <xsl:value-of select="."/>
        </h1>
    </xsl:template>
    
    
<!--    <xsl:template match="lb" priority="1">
        <xsl:text> </xsl:text>
    </xsl:template>-->
    <!--<xsl:template match="lb" priority="1">
        <br/>
    </xsl:template>-->
    
    
    <xsl:template match="@style">
        <xsl:attribute name="style" select="."/>
    </xsl:template>
    
    <!-- omit all nodes that are not explicitly dealt with -->
    
    <xsl:template match="node()" mode="mTOC"/>
   <!-- <xsl:template match="node()" mode="mBody"/>-->
</xsl:stylesheet>