<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!-- this stylesheet removes all mark-up from the body of a TEI file -->
    
    <xsl:output method="xml"  version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"  name="xml"/>
    
    <xsl:include href="Functions.xsl"/>
    
    <!-- identiy transform -->
    <xsl:template match="@* |node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <!-- the output is set by the transformation scenario -->
        <!--<xsl:result-document href="{substring-before(base-uri(),'.xml')}-noMarkUp.xml" format="xml">-->
        <xsl:copy>
            <xsl:apply-templates/>
        </xsl:copy>
        <!--</xsl:result-document>-->
    </xsl:template>
    
    <!-- strip all mark-up from the body of the TEI file -->
    <xsl:template match="text">
        <xsl:copy>
            <xsl:element name="body">
                <xsl:element name="p">
                    <xsl:apply-templates mode="mClean"/>
                </xsl:element>
            </xsl:element>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="node()" mode="mClean">
<!--        <xsl:value-of select="."/>-->
        <xsl:apply-templates mode="mClean"/>
    </xsl:template>
    
    <xsl:template match="choice" mode="mClean">
        <!-- choice can have a large number of respective alternatives. Commonly the first child, is the one found in the original text -->
<!--        <xsl:value-of select="child::node()[1]"/>-->
        <xsl:apply-templates select="child::node()[1]" mode="mClean"/>
    </xsl:template>
    
    <!-- strip all stand-off mark-up from the teiHeader -->
    <xsl:template match="profileDesc | particDesc"/>
    
    <!-- update a new revisionDesc -->
    <xsl:template match="revisionDesc">
        <xsl:copy>
            <xsl:element name="change">
                <xsl:attribute name="when" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="who" select="concat('#', $p_id-editor)"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:text>Generated this file by stripping all mark-up from </xsl:text><xsl:value-of select="base-uri()"/><xsl:text>.</xsl:text>
            </xsl:element>
            <!-- copy the existing child nodes -->
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    
    <!-- strip references to facsimiles from the entire file -->
    <xsl:template match="facsimile"/>
  
    
</xsl:stylesheet>