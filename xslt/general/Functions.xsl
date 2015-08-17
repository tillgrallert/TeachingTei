<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- this stylesheet contains various templates used by other stylesheets -->
    
    
    <!-- add the HTML @lang attribute based on the containing element -->
    <xsl:template name="templHtmlAttrLang">
        <xsl:param name="pInput"/>
        <xsl:choose>
            <xsl:when test="$pInput/@xml:lang">
                <xsl:attribute name="lang" select="$pInput/@xml:lang"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="lang">
                    <xsl:value-of select="ancestor::node()[@xml:lang!=''][1]/@xml:lang"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
   
    <!-- add the XML @xml:lang attribute based on the containing element -->
    <xsl:template name="templXmlAttrLang">
        <xsl:param name="pInput"/>
        <xsl:choose>
            <xsl:when test="$pInput/@xml:lang">
                <xsl:attribute name="xml:lang" select="$pInput/@xml:lang"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="ancestor::node()[@xml:lang!=''][1]/@xml:lang"/>
                </xsl:attribute>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- highlights -->
    <xsl:template match="hi">
        <span>
            <xsl:apply-templates select="@* | node()"/>
        </span>
    </xsl:template>
    
    <!-- rendering information -->
    <xsl:template match="@rend">
        <xsl:attribute name="style">
            <xsl:if test=".='center'">
                <xsl:text>text-align:center;</xsl:text>
            </xsl:if>
            <xsl:if test=".='underline'">
                <xsl:text>text-decoration:underline;</xsl:text>
            </xsl:if>
        </xsl:attribute>
    </xsl:template>
    <!-- strip out the particDesc when generating flat files -->
    <xsl:template match="particDesc"/>
    
    <!-- to account for the <lb/>, <cb/>, <pb/> elements that might need surrounding whitespace -->
    <!-- as there is a new rule for <pb>, I removed it from this template -->
    <xsl:template match="lb | cb">
        <xsl:value-of select="' '"/>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- generate thumb-nail links to images of pages  -->
    <xsl:template match="pb">
        <xsl:variable name="vFacsID" select="substring-after(@facs,'#')"/>
        <xsl:variable name="vFacs" select="ancestor::TEI/descendant::node()[@xml:id=$vFacsID]"/>
        <xsl:variable name="vFacsURL">
            <xsl:choose>
                <xsl:when test="$vFacs/descendant-or-self::graphic[ ends-with(@url,'.jpg')]">
                    <xsl:value-of select="$vFacs/descendant-or-self::graphic[ ends-with(@url,'.jpg')][1]/@url"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$vFacs/descendant-or-self::graphic[1]/@url"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <span lang="en" class="cPN">
            <xsl:text>[</xsl:text><a href="{$vFacsURL}">
            <xsl:text>Page </xsl:text>
            <xsl:value-of select="@n"/><xsl:text>]</xsl:text><br/>
                <img src="{$vFacsURL}" alt="" class="cImgThumb"/>
        </a>
        </span>
    </xsl:template>
    
</xsl:stylesheet>