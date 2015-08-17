<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- this stylesheet extracts all <persName> elements from a TEI XML file and groups them into a <listPerson> element -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:include href="Functions.xsl"/>
    
    <xsl:template match="TEI">
        <xsl:element name="listPerson">
            <!-- XPath to limit the result to all personal names that are NOT already in the profileDesc -->
            <!-- be aware that differently encoded names will pop up as names -->
            <xsl:for-each-group select=".//text//persName[not(descendant::text()=/TEI/teiHeader//particDesc//persName/descendant::text())]" group-by=".">
                <xsl:sort select="." order="ascending"/>
            <xsl:apply-templates select="."/>
        </xsl:for-each-group>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="persName">
        <xsl:element name="person">
            <!-- this generates a unique id, prefixed by 'pers_' for each person element of the result tree -->
            <xsl:attribute name="xml:id" select="concat('pers_',generate-id())"/>
            <xsl:copy>
                <xsl:call-template name="templXmlAttrLang">
                    <xsl:with-param name="pInput" select="."/>
                </xsl:call-template>
                <xsl:apply-templates select="@* | node()"/>
            </xsl:copy>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="forename | surname | addName">
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