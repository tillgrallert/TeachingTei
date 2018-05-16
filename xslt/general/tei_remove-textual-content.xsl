<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <!-- this stylesheet removes all text() from the body of a TEI file, but keeps the structural mark-up -->
    
    <xsl:output method="xml"  version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"  name="xml"/>
    
    <xsl:include href="Functions.xsl"/>
    
    <xsl:template match="@* |node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
       <xsl:result-document href="{substring-before(base-uri(),'.xml')}-structuralMarkUpOnly.xml" format="xml">
           <xsl:copy>
               <xsl:apply-templates select="@* | node()"/>
           </xsl:copy>
       </xsl:result-document>
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
    <xsl:template match="persName | orgName | addName | surname | forename | placeName | rs | date | time" mode="mClean">
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
                <xsl:text>Generated this file by stripping all semantic mark-up and text from </xsl:text>
                <xsl:value-of select="base-uri()"/>
            </xsl:element>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>