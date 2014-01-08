<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="1.0">
    
    <!-- Handling of sections and section titles in body and back.
         Note that some demo templates have alternate stylesheets. -->
    
    
    
    <!-- Sections -->
    
    <xsl:template match="section[parent::body][not(./@parts-listing)]">
        <fo:block id="{generate-id(.)}">
            <xsl:if test="preceding-sibling::section and $break.after.section.level1='1'">
                <xsl:attribute name="break-before">page</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="title"/>
        </fo:block>
        <xsl:apply-templates select="*[not(self::title)]"/>
    </xsl:template>
    
    <xsl:template match="section[parent::back]">
        <fo:block id="{generate-id(.)}">
            <xsl:if test="$break.after.section.level1='1' and preceding-sibling::section">
                <xsl:attribute name="break-before">page</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="title"/>
        </fo:block>
        <xsl:apply-templates select="*[not(self::title)]"/>
    </xsl:template>
    
    <xsl:template match="section[count(ancestor-or-self::section) = 2]">
        <fo:block id="{generate-id(.)}">
            <xsl:attribute name="space-before">12pt</xsl:attribute>
            <xsl:apply-templates select="title"/>
        </fo:block>
        <xsl:apply-templates select="*[not(self::title)]"/>
    </xsl:template>
    
    <xsl:template match="section[count(ancestor-or-self::section) = 3]">
        <fo:block space-before="8pt" id="{generate-id(.)}">
            <xsl:apply-templates select="title"/>
        </fo:block>
        <xsl:apply-templates select="*[not(self::title)]"/>
    </xsl:template>
    
    <xsl:template match="section[count(ancestor-or-self::section) = 4]">
        <fo:block space-before="8pt" id="{generate-id(.)}">
            <xsl:apply-templates select="title"/>
        </fo:block>
        <xsl:apply-templates select="*[not(self::title)]"/>
    </xsl:template>
    
    
    
    <!-- Titles -->
    <xsl:template match="title[count(ancestor-or-self::section) = 1]">
        <fo:marker marker-class-name="section-title">
            <xsl:value-of select="."/>
        </fo:marker>
        <fo:block
            xsl:use-attribute-sets="section-titles"
            space-before="30pt"
            space-after="8pt"
            font-size="{$heading1-font-size}"
            id="{generate-id(.)}"
            start-indent="-10mm">
            
            <!-- AntennaHouse PDF bookmarks -->
            <xsl:if test="$axf.extensions=1">
                <xsl:call-template name="axf-bookmarks">
                    <xsl:with-param name="outline-title" select="normalize-space(.)"/>
                </xsl:call-template>
            </xsl:if>
            
            <xsl:choose>
                <xsl:when test="ancestor::body">
                    <xsl:call-template name="section-titles"/>
                </xsl:when>
                <xsl:when test="ancestor::back">
                    <xsl:call-template name="appendix-titles"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="section-titles"/>
                </xsl:otherwise>
            </xsl:choose>
        </fo:block>
    </xsl:template>
    
    <xsl:template match="title[count(ancestor-or-self::section) = 2]">
        <fo:block
            xsl:use-attribute-sets="section-titles"
            font-size="{$heading2-font-size}"
            id="{generate-id(.)}"><!-- Heading 2 Font Size = 14pt (COS), set in param.xsl -->
            
            <xsl:attribute name="start-indent">-3mm</xsl:attribute>
            <xsl:attribute name="color">blue</xsl:attribute>
            
            <!-- AntennaHouse PDF bookmarks -->
            <xsl:if test="$axf.extensions=1">
                <xsl:call-template name="axf-bookmarks">
                    <xsl:with-param name="outline-title" select="normalize-space(.)"/>
                </xsl:call-template>
            </xsl:if>
            
            <xsl:choose>
                <xsl:when test="ancestor::body">
                    <xsl:call-template name="section-titles"/>
                </xsl:when>
                <xsl:when test="ancestor::back">
                    <xsl:call-template name="appendix-titles"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="section-titles"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </fo:block>
    </xsl:template>
    
    <xsl:template match="title[count(ancestor-or-self::section) = 3]">
        <fo:block
            xsl:use-attribute-sets="section-titles"
            font-size="12pt"
            color="blue"
            id="{generate-id(.)}">
            
            <!-- AntennaHouse PDF bookmarks -->
            <xsl:if test="$axf.extensions=1">
                <xsl:call-template name="axf-bookmarks">
                    <xsl:with-param name="outline-title" select="normalize-space(.)"/>
                </xsl:call-template>
            </xsl:if>
            
            <xsl:choose>
                <xsl:when test="ancestor::body">
                    <xsl:call-template name="section-titles"/>
                </xsl:when>
                <xsl:when test="ancestor::back">
                    <xsl:call-template name="appendix-titles"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="section-titles"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </fo:block>
    </xsl:template>
    
    <xsl:template match="title[count(ancestor-or-self::section) = 4]">
        <fo:block
            xsl:use-attribute-sets="section-titles"
            font-size="11pt"
            color="blue"
            id="{generate-id(.)}">
            
            <!-- AntennaHouse PDF bookmarks -->
            <xsl:if test="$axf.extensions=1">
                <xsl:call-template name="axf-bookmarks">
                    <xsl:with-param name="outline-title" select="normalize-space(.)"/>
                </xsl:call-template>
            </xsl:if>
            
            <xsl:choose>
                <xsl:when test="ancestor::body">
                    <xsl:call-template name="section-titles"/>
                </xsl:when>
                <xsl:when test="ancestor::back">
                    <xsl:call-template name="appendix-titles"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="section-titles"/>
                </xsl:otherwise>
            </xsl:choose>
            
        </fo:block>
    </xsl:template>
    
    
    <!-- Title numbering -->
    
    <!-- Section numbering in body -->
    <xsl:template name="section-titles">
        <fo:block>
            <xsl:if test="$section.numbering=1 and not($demo = 'envac')">
                <xsl:number
                    level="multiple"
                    count="section[not(ancestor::back)] | inset[not(ancestor::back)]"
                    format="1.1"/>
                <fo:inline>&#xA0;&#xA0;</fo:inline>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
        </fo:block>
    </xsl:template>
    
    <!-- Section (Appendix) numbering in back -->
    <xsl:template name="appendix-titles">
        <fo:block>
            <xsl:if test="$section.numbering=1 and not($demo = 'envac')">
                <xsl:number
                    level="multiple"
                    count="section[ancestor::back] | inset[ancestor::back]"
                    format="A.1"/>
                <fo:inline>&#xA0;&#xA0;</fo:inline>
            </xsl:if>
            <xsl:value-of select="normalize-space(.)"/>
        </fo:block>
    </xsl:template>
    
</xsl:stylesheet>
