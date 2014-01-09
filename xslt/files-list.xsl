<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    exclude-result-prefixes="xs xlink"
    version="2.0">
    
    <xsl:output indent="yes" method="xml" encoding="UTF-8"/>
    
    <!-- Root XML URI -->
    <xsl:param name="root-xml" select="'file:///mnt/win7-work/SGML/DTD/cosml/local-tests/test-root.xml'"/>
    
    <!-- Raw list of URIs into links to participating modules, recursive -->
    <xsl:param name="files">
        <raw>
            <xsl:for-each select="document($root-xml)//inset|document($root-xml)//block-inset">
                <xsl:call-template name="file">
                    <xsl:with-param name="href" select="substring-before(@xlink:href,'#')"/>
                </xsl:call-template>
            </xsl:for-each>
        </raw>
    </xsl:param>
    
    <xsl:template match="/">
        <files>
            <!-- Only list unique file URIs -->
            <xsl:for-each select="$files//file[not(.=preceding::*)]">
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </files>
    </xsl:template>
    
    <xsl:template name="file">
        <xsl:param name="href"/>
        <file>
            <xsl:value-of select="$href"/>
        </file>
        <xsl:for-each select="document($href)//inset|document($href)//block-inset">
            <xsl:call-template name="file">
                <xsl:with-param name="href" select="substring-before(@xlink:href,'#')"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>