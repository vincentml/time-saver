<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="3.0">
    
    <xsl:template match="/">
        <xsl:call-template name="xml-to-csv">
            <xsl:with-param name="data" select="*"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="xml-to-csv">
        <xsl:param name="data" as="element()"/>
        <xsl:apply-templates select="$data/*[1]/*" mode="csv-header"/>
        <xsl:apply-templates select="$data/*/*" mode="csv-row"/>
    </xsl:template>
    
    <xsl:template mode="csv-header" match="*">
        <xsl:value-of select="concat(local-name(),
            if (following-sibling::*) then ',' else '&#xa;'
            )"/>
    </xsl:template>
    
    <xsl:template mode="csv-row" match="*">
        <xsl:value-of select="concat('&#x22;', normalize-space(), '&#x22;',
            if (following-sibling::*) then ',' else '&#xa;'
            )"/>
    </xsl:template>
    
</xsl:stylesheet>