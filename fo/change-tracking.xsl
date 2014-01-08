<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="1.0">
    
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Sep 2, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> ari</xd:p>
            <xd:p></xd:p>
        </xd:desc>
    </xd:doc>
    
    
    <xsl:template match="*">
        <xsl:apply-templates/>
    </xsl:template>
    
    
    <xsl:template match="processing-instruction('xm-deletion_mark')">
        <xsl:value-of select="substring-before(substring-after(.,'data=&quot;'),'&quot;')"/>
    </xsl:template>
    
    
</xsl:stylesheet>
