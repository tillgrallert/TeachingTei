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
    <!-- include my custom calendar conversion templates hosted on github -->
    <xsl:include href="https://raw.githubusercontent.com/tillgrallert/xslt-calendar-conversion/master/DateFunction%20v1.xsl"/>
    
    <xsl:template match="TEI">
        <xsl:result-document href="{substring-before(base-uri(), '.TEIP5.xml')}.html">
        <html> 
            <head>
                <title><xsl:apply-templates select="./teiHeader//titleStmt/title"/></title>
                <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
                <link href="../css/html_arabicNewspapers.css" rel="stylesheet" type="text/css"></link>
            </head>
            <body>
                <xsl:apply-templates select="./text"/>
            </body>
        </html>
        </xsl:result-document>
    </xsl:template>
    

    

    
    <!-- named entities, references etc. -->
    <xsl:template match="persName">
        <span>
            <xsl:attribute name="class" select="'cName cRef'"/>
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <xsl:attribute name="title">
                <xsl:apply-templates select="//teiHeader//node()[@xml:id=substring-after(current()/@ref,'#')]" mode="mSpanTitle"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="rs">
        <span>
            <xsl:attribute name="class" select="'cRef'"/>
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <xsl:attribute name="title">
                <xsl:apply-templates select="//teiHeader//node()[@xml:id=substring-after(current()/@ref,'#')]" mode="mSpanTitle"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    
    <!-- general processing information -->
    
    <xsl:template match="text()">
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="@*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
   
    
    <!-- fill in metadata -->
    <xsl:template match="particDesc//person" mode="mSpanTitle">
            <xsl:value-of select="normalize-space(persName[1])"/>
        <xsl:apply-templates select="./node()" mode="mSpanTitle"/>
       <!-- <xsl:apply-templates select="./death" mode="mSpanTitle"/>-->
        
    </xsl:template>
    
    <xsl:template match="birth" mode="mSpanTitle">
        <br/>
        <xsl:text>b. </xsl:text>
        <xsl:apply-templates  mode="mSpanTitle"/>
    </xsl:template>
    
    <xsl:template match="death" mode="mSpanTitle">
        <br/>
        <xsl:text>d. </xsl:text>
        <xsl:apply-templates  mode="mSpanTitle"/>
    </xsl:template>
    
    <xsl:template match="date">
        <span>
            <xsl:attribute name="class" select="'cDate'"/>
            <xsl:attribute name="title">
                <xsl:apply-templates select="@*" mode="mSpanTitle"/>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </span>
    </xsl:template>
    
    <xsl:template match="@when-custom" mode="mSpanTitle">
        <xsl:if test="../@datingMethod='#cal_islamic'">
            <xsl:variable name="vDateH" select="."/>
            <xsl:variable name="vDateHFormatted">
                <xsl:call-template name="funcDateFormatTei">
                    <xsl:with-param name="pDate" select="$vDateH"/>
                    <xsl:with-param name="pCal" select="'H'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="vDateG">
                <xsl:call-template name="funcDateH2G">
                    <xsl:with-param name="pDateH" select="$vDateH"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="vDateGFormatted">
                <xsl:call-template name="funcDateFormatTei">
                    <xsl:with-param name="pDate" select="$vDateG"/>
                    <xsl:with-param name="pCal" select="'G'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:text>hijrī date: </xsl:text>
            <xsl:value-of select="$vDateHFormatted"/>
            <xsl:text>; computed Gregorian date: </xsl:text>
            <xsl:value-of select="$vDateGFormatted"/>
        </xsl:if>
        <xsl:if test="../@datingMethod='#cal_julian'">
            <xsl:variable name="vDateJ" select="."/>
            <xsl:variable name="vDateJFormatted">
                <xsl:call-template name="funcDateFormatTei">
                    <xsl:with-param name="pDate" select="$vDateJ"/>
                    <xsl:with-param name="pCal" select="'J'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="vDateG">
                <xsl:call-template name="funcDateJ2G">
                    <xsl:with-param name="pDateJ" select="$vDateJ"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="vDateGFormatted">
                <xsl:call-template name="funcDateFormatTei">
                    <xsl:with-param name="pDate" select="$vDateG"/>
                    <xsl:with-param name="pCal" select="'G'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:text>Julian date: </xsl:text>
            <xsl:value-of select="$vDateJFormatted"/>
            <xsl:text>; computed Gregorian date: </xsl:text>
            <xsl:value-of select="$vDateGFormatted"/>
        </xsl:if>
        <xsl:if test="../@datingMethod='#cal_ottomanfiscal'">
            <xsl:variable name="vDateM" select="."/>
            <xsl:variable name="vDateMFormatted">
                <xsl:call-template name="funcDateFormatTei">
                    <xsl:with-param name="pDate" select="$vDateM"/>
                    <xsl:with-param name="pCal" select="'M'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="vDateG">
                <xsl:call-template name="funcDateM2G">
                    <xsl:with-param name="pDateM" select="$vDateM"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:variable name="vDateGFormatted">
                <xsl:call-template name="funcDateFormatTei">
                    <xsl:with-param name="pDate" select="$vDateG"/>
                    <xsl:with-param name="pCal" select="'G'"/>
                </xsl:call-template>
            </xsl:variable>
            <xsl:text>mālī date: </xsl:text>
            <xsl:value-of select="$vDateMFormatted"/>
            <xsl:text>; computed Gregorian date: </xsl:text>
            <xsl:value-of select="$vDateGFormatted"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="@notBefore">
        <xsl:text>after </xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>
    <xsl:template match="@notAfter">
        <xsl:text>before </xsl:text>
        <xsl:value-of select="."/>
    </xsl:template>
    
    <xsl:template match="@* | idno | ref" mode="mSpanTitle"/>
    

    
    
</xsl:stylesheet>