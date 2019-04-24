<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs"
    version="3.0">
    
    <!-- this stylesheet removes all mark-up from the body of a TEI file and leaves only the facsimiles in place -->
    
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
       <!--<xsl:result-document href="{substring-before(base-uri(),'.xml')}-facsimileEdition.xml" format="xml">-->
           <xsl:copy>
               <xsl:apply-templates/>
           </xsl:copy>
       <!--</xsl:result-document>-->
    </xsl:template>
    
    <!-- produce an new empty body for the TEI file -->
    <xsl:template match="text">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="body">
                <xsl:element name="p">
                </xsl:element>
            </xsl:element>
        </xsl:copy>
    </xsl:template>
    
    <!-- update the revisionDesc -->
    <xsl:template match="revisionDesc">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:element name="change">
                <xsl:attribute name="when" select="format-date(current-date(),'[Y0001]-[M01]-[D01]')"/>
                <xsl:attribute name="who" select="concat('#', $p_id-editor)"/>
                <xsl:attribute name="xml:id" select="$p_id-change"/>
                <xsl:attribute name="xml:lang" select="'en'"/>
                <xsl:text>Generated this file by stripping the text from </xsl:text><xsl:value-of select="base-uri()"/><xsl:text>.</xsl:text>
            </xsl:element>
            <!-- copy the existing child nodes -->
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>