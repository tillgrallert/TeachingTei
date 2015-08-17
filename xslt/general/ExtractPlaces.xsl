<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- this stylesheet extracts all <persName> elements from a TEI XML file and groups them into a <listPerson> element -->
    
    <xsl:include href="Functions.xsl"/>
    
    <xsl:template match="TEI">
        <xsl:element name="listPlace">
        <xsl:for-each-group select="./text//placeName" group-by=".">
            <xsl:apply-templates select="."/>
        </xsl:for-each-group>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="placeName">
        <xsl:element name="place">
            <xsl:attribute name="xml:id" select="concat('pl_',generate-id())"/>
            <xsl:copy>
                <xsl:call-template name="templXmlAttrLang">
                    <xsl:with-param name="pInput" select="."/>
                </xsl:call-template>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="geogName | geogFeat | country | bloc | region | settlement | district">
            <xsl:copy>
                <xsl:call-template name="templXmlAttrLang">
                    <xsl:with-param name="pInput" select="."/>
                </xsl:call-template>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
    </xsl:template>
    
    <!-- this template matches all text nodes (i.e. the text content of any element) and normalize whitespace -->
    <xsl:template match="text()">
        <xsl:value-of select="normalize-space(.)"/>
    </xsl:template>
    
    <!-- This template replicates attrbutes as they are found in the source -->
    <xsl:template match="@*">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>