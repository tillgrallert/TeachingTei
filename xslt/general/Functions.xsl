<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:html="http://www.w3.org/1999/xhtml" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.pnp-software.com/XSLTdoc"
    xmlns:opf="http://www.idpf.org/2007/opf" 
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:xi="http://www.w3.org/2001/XInclude"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs xd xi dc opf html"
    version="3.0">
    
    <!-- this stylesheet contains various templates used by other stylesheets -->
    
   
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
    
    <!-- strip out the particDesc when generating flat files -->
    <xsl:template match="particDesc"/>
    
    <!-- identify the author of the change by means of a @xml:id -->
    <xsl:param name="p_editor">
        <tei:respStmt xml:lang="en">
            <tei:resp>TEI edition</tei:resp>
            <tei:persName xml:id="pers_TG"><tei:forename>Till</tei:forename> <tei:surname>Grallert</tei:surname></tei:persName>
        </tei:respStmt>
    </xsl:param>
    <xsl:param name="p_id-editor" select="$p_editor/descendant::tei:persName/@xml:id"/>
    
    <!-- toggle debugging (not available in all stylesheets) -->
    <xsl:param name="p_verbose" select="false()"/>
    
    <!-- generate an id for the most recent change -->
    <xsl:param name="p_id-change" select="generate-id(//tei:change[last()])"/>
    
</xsl:stylesheet>