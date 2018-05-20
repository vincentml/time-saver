<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:ixsl="http://saxonica.com/ns/interactiveXSLT"
    extension-element-prefixes="ixsl"
    exclude-result-prefixes="xs math xd"
    version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>Saxon JS interactive XSLT</xd:p>
        </xd:desc>
    </xd:doc>
    
    <xsl:import href="wp-updates.xsl"/>
    <xsl:import href="xml-to-csv.xsl"/>
    
    <xsl:template name="start" match="/">
        <xsl:result-document href="#output" method="ixsl:replace-content">
            <xsl:value-of>Today is <xsl:value-of select="format-date(current-date(), '[D] [MNn] [Y]')"/>. Saxon-JS is working!</xsl:value-of>  
        </xsl:result-document>    
    </xsl:template>
    
    <xsl:template match="input[@type = 'button']" mode="ixsl:onclick">
        <xsl:variable name="raw" select="ixsl:get(id('rawtext', ixsl:page()), 'value')"/>
        <!-- The conversion could be done in one step which would be much more efficient. Using several steps here to re-use modules. -->
        <xsl:variable name="format">
            <xsl:call-template name="process">
                <xsl:with-param name="text" select="$raw"/>
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="csv">
            <xsl:call-template name="xml-to-csv">
                <xsl:with-param name="data" select="$format/*"/>
            </xsl:call-template>
        </xsl:variable>
        <!--xsl:result-document href="#output" method="ixsl:replace-content">
            <xsl:sequence select="$csv"/>
        </xsl:result-document-->
        <xsl:sequence select="ixsl:call(ixsl:window(), 'download', ['wp-updates.csv', string($csv)])"/>
    </xsl:template>
    
    <!-- TODO: find out how to get a correct relative URL -->
    <xsl:template match="a[@id = 'sample']" mode="ixsl:onclick">
        <xsl:result-document href="#rawtext" method="ixsl:replace-content">
            <xsl:sequence select="unparsed-text(concat('http://localhost:8984/static/wp-updates/', 'sample.txt'))"/>
        </xsl:result-document>
    </xsl:template>
    
</xsl:stylesheet>