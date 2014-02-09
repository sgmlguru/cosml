<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs xlink" 
    version="2.0">
    
    <xsl:output indent="yes" method="xml" encoding="UTF-8"/>

    
    <!-- Root XML -->
    <xsl:param name="root-xml"></xsl:param>
    
    <xsl:param name="tmp-base-uri"/>
    <!-- select="'xmldb:exist:///db/work/tmp'" -->
    
    
    
    <xsl:template match="/">
        <map>
            <node>
                <xsl:attribute name="TEXT">
                    <xsl:value-of select="base-uri(.)"/>
                </xsl:attribute>
                <xsl:apply-templates select=".//block-inset|.//inset|.//graphics"/>
            </node>
        </map>
    </xsl:template>
    
    <xsl:template match="graphics">
        <node>
            <xsl:attribute name="TEXT">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
        </node>
    </xsl:template>
    
    <xsl:template match="block-inset|inset">
        <node>
            <xsl:attribute name="TEXT">
                <xsl:value-of select="@xlink:href"/>
            </xsl:attribute>
            <xsl:apply-templates select="doc(substring-before(@xlink:href,'#'))//inset |
                doc(substring-before(@xlink:href,'#'))//block-inset |
                doc(substring-before(@xlink:href,'#'))//graphics"/>
        </node>
    </xsl:template>
    
    
    
</xsl:stylesheet>