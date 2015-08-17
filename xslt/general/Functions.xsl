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
    
</xsl:stylesheet>