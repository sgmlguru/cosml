<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0"
    exclude-result-prefixes="xlink">
    
    <xsl:output indent="yes" method="html"/>
    
    <xsl:param name="file-list-url"/>
    
    <xsl:param name="files" select="document($file-list-url,/)"/>
    
    <xsl:key name="id-nodes" match="*" use="@id"/>
    
    <xsl:param name="ids">
        <xsl:for-each select="document($files//file,/)">
            <xsl:apply-templates select="*[@id]" mode="file"/>
        </xsl:for-each>
    </xsl:param>
    
    <xsl:template match="*[@id]" mode="file">
        <target>
            <xsl:attribute name="id">
                <xsl:value-of select="@id"/>
            </xsl:attribute>
            <xsl:apply-templates select="*" mode="file"/>
        </target>
    </xsl:template>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <title>Broken Links (Cross-references, Hyperlinks, Footnote References)</title>
            </head>
            <body>
               <h1>Broken Links</h1>
                
                <xsl:for-each select="$files//file">
                    <xsl:variable name="file" select="."/>
                    <h2>
                        <xsl:value-of select="."/>
                    </h2>
                    
                    <ul>
                        <xsl:apply-templates select="document($file)/*"/>
                    </ul>
                    
                </xsl:for-each>
                               
            </body>
        </html>
    </xsl:template>
    
    
    
    
    <xsl:template match="*">
        <xsl:apply-templates select="*"/>
    </xsl:template>
    
    <xsl:template match="locator|hlink|ftnoteref">
        <xsl:variable name="href">
            <xsl:choose>
                <xsl:when test="contains(@xlink:href,'#')">
                    <xsl:value-of select="substring-after(@xlink:href,'#')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@xlink:href"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:choose>
            <xsl:when test="$ids//*[@id = $href]"><!-- test="contains($ids//target/@id,$href)" version=1.1 -->
                <!-- Link target exists -->
            </xsl:when>
            <xsl:otherwise>
                <li>
                    <b>
                        <xsl:choose>
                            <xsl:when test="local-name(.) = 'locator'">
                                <xsl:text>Cross-reference (</xsl:text>
                                <xsl:value-of select="local-name(.)"/>
                                <xsl:text>)</xsl:text>
                            </xsl:when>
                            <xsl:when test="local-name(.) = 'hlink'">
                                <xsl:text>Hyperlink (</xsl:text>
                                <xsl:value-of select="local-name(.)"/>
                                <xsl:text>)</xsl:text>
                            </xsl:when>
                            <xsl:when test="local-name(.) = 'ftnoteref'">
                                <xsl:text>Footnote reference (</xsl:text>
                                <xsl:value-of select="local-name(.)"/>
                                <xsl:text>)</xsl:text>
                            </xsl:when>
                        </xsl:choose>
                    </b>
                    <xsl:text> with </xsl:text>
                    <i>
                        <xsl:text>@id=</xsl:text>
                        <xsl:choose>
                            <xsl:when test="normalize-space(@id)">
                                <xsl:text>"</xsl:text>
                                <xsl:value-of select="@id"/>
                                <xsl:text>"</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>(NO VALUE)</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </i>
                    <xsl:text> and target </xsl:text>
                    <i>
                        <xsl:text>@xlink:href="</xsl:text>
                        <xsl:value-of select="$href"/>
                        <xsl:text>"</xsl:text>
                    </i>
                </li>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
</xsl:stylesheet>
