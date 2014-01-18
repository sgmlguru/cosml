<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs xlink" version="2.0">

    <xsl:output indent="yes" method="xml" encoding="UTF-8"/>

    <!-- Root XML URI -->
    <xsl:param name="root-xml"
        select="'file:///mnt/win7-work/SGML/DTD/cosml/local-tests/test-root.xml'"/>

    <!-- Raw list of URIs into links to participating modules, recursive -->
    <xsl:param name="files">
        <doc>
            <root>
                <resource>
                    <urn/>
                    <url>
                        <xsl:value-of select="base-uri(document($root-xml)/*)"/>
                    </url>
                    <type>doc-root</type>
                </resource>
            </root>
            <modules>
                <xsl:for-each select="document($root-xml)//graphics">
                    <xsl:call-template name="graphics"/>
                </xsl:for-each>
                <xsl:for-each select="document($root-xml)//inset|document($root-xml)//block-inset">
                    <xsl:call-template name="file">
                        <xsl:with-param name="href" select="substring-before(@xlink:href,'#')"/>
                    </xsl:call-template>
                </xsl:for-each>
            </modules>
        </doc>
    </xsl:param>

    <xsl:template match="/">
        <doc>
            <!-- Only list unique file URIs -->
            <root>
                <xsl:copy-of select="$files/doc/root/resource"/>
            </root>
            <modules>
                <xsl:for-each select="$files/doc/modules/resource[not(url=preceding::*)]">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </modules>
            <!--<xsl:copy-of select="$files"/>-->
        </doc>
    </xsl:template>

    <xsl:template name="file">
        <xsl:param name="href"/>
        <resource>
            <urn/>
            <url>
                <xsl:value-of select="$href"/>
            </url>
            <type>xml</type>
        </resource>
        <xsl:for-each select="document($href)//graphics">
            <xsl:call-template name="graphics"/>
        </xsl:for-each>
        <xsl:for-each select="document($href)//inset|document($href)//block-inset">
            <xsl:call-template name="file">
                <xsl:with-param name="href" select="substring-before(@xlink:href,'#')"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="graphics">
        <resource>
            <urn/>
            <url>
                <xsl:value-of select="@xlink:href"/>
            </url>
            <type>
                <xsl:value-of select="tokenize(@xlink:href,'\.')[last()]"/>
            </type>
        </resource>
    </xsl:template>
    

</xsl:stylesheet>
