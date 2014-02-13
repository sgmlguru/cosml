<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs xlink" 
    version="2.0">
    
    <xsl:output indent="yes" method="xml" encoding="UTF-8"/>
    
    
    
    <!-- Produces mind map XML from COSML root XML documents and their descendant module links -->

    
    <!-- Root XML -->
    <xsl:param name="root-xml"/>
    
    <xsl:param name="tmp-base-uri"/>
    <!-- select="'xmldb:exist:///db/work/tmp'" -->
    
    
    
    <xsl:template match="/">
        <map version="freeplane 1.2.0">
            <node>
                <xsl:attribute name="TEXT">
                    <xsl:value-of select="tokenize(base-uri(.),'/')[last()]"/>
                </xsl:attribute>
                <xsl:apply-templates select=".//block-inset|.//inset|.//graphics"/>
            </node>
        </map>
    </xsl:template>
    
    <xsl:template match="graphics">
        <node>
            <xsl:attribute name="TEXT">
                <xsl:value-of select="tokenize(@xlink:href,'/')[last()]"/>
            </xsl:attribute>
        </node>
    </xsl:template>
    
    <xsl:template match="block-inset|inset">
        <node>
            <xsl:attribute name="TEXT">
                <xsl:value-of select="tokenize(@xlink:href,'/')[last()]"/>
            </xsl:attribute>
            <xsl:apply-templates select="doc(substring-before(@xlink:href,'#'))//inset |
                doc(substring-before(@xlink:href,'#'))//block-inset |
                doc(substring-before(@xlink:href,'#'))//graphics"/>
        </node>
    </xsl:template>
    
    
    
</xsl:stylesheet>