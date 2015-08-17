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
    
    <!-- HTML -->
    
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
    
    <!-- divs -->
    <xsl:template match="div">
        <div>
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <xsl:attribute name="class">
                <xsl:if test="@type='section'">
                    <xsl:text>cSec</xsl:text>
                </xsl:if>
                <xsl:if test="@type='article'">
                    <xsl:text>cArt</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates select="@* | node()"/>
        </div>
    </xsl:template>
    <!-- ps -->
    <xsl:template match="p">
        <p>
            <xsl:call-template name="templHtmlAttrLang">
                <xsl:with-param name="pInput" select="."/>
            </xsl:call-template>
            <xsl:apply-templates select="@* | node()"/>
        </p>
    </xsl:template>
    <!-- heads -->
    <xsl:template match="div[@type='section']/head | div[@type='bill']/head">
        <h2><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="div[@type='article']/head">
        <h3><xsl:apply-templates/></h3>
    </xsl:template>
    
    <xsl:template match="div/head">
        <h1><xsl:apply-templates/></h1>
    </xsl:template>
    <!-- title -->
    <xsl:template match="bibl[ancestor::text]/title">
        <span>
            <xsl:attribute name="class" select="'cTitle'"/>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    <!-- tables -->
    <xsl:template match="table">
        <table>
            <thead>
                <xsl:apply-templates select="./row[@role='label']"/>
            </thead>
            <tbody>
                <xsl:apply-templates select="./row[@role='data']"/>
            </tbody>         
        </table>
    </xsl:template>
    <xsl:template match="row">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>
    <xsl:template match="row[@role='data']/cell">
        <td>
            <xsl:apply-templates/>
        </td>
    </xsl:template>
    <xsl:template match="row[@role='label']/cell">
        <th>
            <xsl:apply-templates/>
        </th>
    </xsl:template>
    <!-- the separating marks encoded as <ab> (anonymous blocks) -->
    <xsl:template match="ab">
        <div>
            <xsl:apply-templates select="@* | node()"/>
        </div>
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