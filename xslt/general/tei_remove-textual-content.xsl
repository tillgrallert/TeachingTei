<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!-- this stylesheet removes all text() from the body of a TEI file, but keeps the structural mark-up -->
    
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
<!--       <xsl:result-document href="{substring-before(base-uri(),'.xml')}-structuralMarkUpOnly.xml" format="xml">-->
           <xsl:copy>
               <xsl:apply-templates/>
           </xsl:copy>
       <!--</xsl:result-document>-->
    </xsl:template>
    
    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="mClean"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="@* |node()" mode="mClean">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" mode="mClean"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="text()" mode="mClean"/>
    
    <!-- remove semantic mark-up -->
    <xsl:template match="persName | orgName | addName | surname | forename | placeName | rs | date | time | bibl | title" mode="mClean">
       <xsl:apply-templates mode="mClean"/>
   </xsl:template>
    
    <!-- strip references to facsimiles from the entire file -->
    <xsl:template match="facsimile"/>
    <xsl:template match="@facs" mode="mClean"/>
    
    <!-- create a new revisionDesc -->
    <xsl:template match="revisionDesc">
        <xsl:copy>
            <xsl:element name="change">
                <xsl:attribute name="when" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="who" select="concat('#', $p_id-editor)"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:text>Generated this file by stripping all semantic mark-up and text from </xsl:text>
                <xsl:value-of select="base-uri()"/><xsl:text>.</xsl:text>
            </xsl:element>
            <!-- copy the existing child nodes -->
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>