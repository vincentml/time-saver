<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xs math xd"
    expand-text="yes" version="3.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p>This XSLT parses the text of the WordPress Updates page into an easier to use
                format which can be opened in Excel. When updating WordPress it is good practice to
                read up on each update and make notes. This XSLT quickly creates an Excel file from
                the information on the WordPress Updates screen. The Excel file can then be used for
                recording notes.</xd:p>
            <xd:p>Usage: Go to the WordPress Updates page in the WordPress Dashboard. Copy all text
                on this page and paste it into a text file; save this file as wp-updates.txt. Then
                run this XSLT either in oXygen or from the command line as shown below to produce
                wp-updates.xml. You can then open wp-updates.xml in Excel.</xd:p>
            <xd:p>To run this XSLT from a command line using Saxon HE 9.8 or higher:</xd:p>
            <xd:pre>java -jar saxon9he.jar -it -xsl:wp-updates.xsl -o:wp-updates.xml</xd:pre>
        </xd:desc>
    </xd:doc>

    <xd:doc>
        <xd:desc>The text of the WordPress Updates page can be provided either as a (path to a) file
            or as a string parameter. The default is to use file wp-updates.txt.</xd:desc>
    </xd:doc>
    <xsl:param name="wpUpdatesPageFile" as="xs:string" select="'wp-updates.txt'"/>
    <xsl:param name="encoding" as="xs:string" select="'windows-1252'"/>
    <xsl:param name="wpUpdatesPageText" as="xs:string"
        select="unparsed-text($wpUpdatesPageFile, $encoding)"/>

    <xsl:output indent="true"/>

    <xsl:template name="xsl:initial-template" match="/">
        <xsl:variable name="lines" as="xs:string*" select="tokenize($wpUpdatesPageText, '\r?\n')"/>
        <xsl:variable name="raw">
            <xsl:apply-templates select="$lines" mode="raw"/>
        </xsl:variable>
        <updates>
            <!--xsl:sequence select="$raw"/-->
            <xsl:apply-templates select="$raw/name" mode="format"/>
        </updates>
    </xsl:template>

    <xsl:template mode="raw" match=".[starts-with(., 'You have version')]">
        <xsl:analyze-string select="." regex="You have version (\S+) installed. Update to (\S+)\.">
            <xsl:matching-substring>
                <current-version>{regex-group(1)}</current-version>
                <new-version>{regex-group(2)}</new-version>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template mode="raw" match=".[starts-with(., 'Select ')]">
        <name>{substring-after(., 'Select ')}</name>
    </xsl:template>

    <xsl:template mode="raw" match=".[matches(., 'The following \S+ have new versions available')]">
        <xsl:analyze-string select="." regex="The following (\S+) have new versions available">
            <xsl:matching-substring>
                <type>{regex-group(1)}</type>
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:template>

    <xsl:template mode="raw" match=".[matches(., 'You can update to WordPress')]">
        <type>WordPress</type>
        <name>WordPress</name>
        <current-version/>
        <new-version>{replace(., '^\s*You can update to WordPress ([\d\.]+).*$',
            '$1')}</new-version>
    </xsl:template>

    <xsl:template mode="raw" match="."/>
    
    <xsl:template mode="format" match="name">
        <update>
            <xsl:copy-of select="preceding-sibling::type[1]"/>
            <xsl:copy-of select="."/>
            <xsl:copy-of select="following-sibling::current-version[1]"/>
            <xsl:copy-of select="following-sibling::new-version[1]"/>
            <!-- the next few elements are placeholders for information that will be added later. -->
            <significant-changes/>
            <upgrade-process/>
            <notes/>
        </update>
    </xsl:template>

</xsl:stylesheet>
