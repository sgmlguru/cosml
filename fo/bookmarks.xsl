<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">
    
    <!-- Bookmarks -->
    
    <xsl:template name="fo-bookmarks" >
        <fo:bookmark-tree>
            <xsl:apply-templates
                select="../*|."
                mode="bookmarks"/>
            <xsl:call-template name="bookmarks.indexoutline"/>
        </fo:bookmark-tree>
    </xsl:template>
    
    
    
    <!-- PDF bookmarks -->
    <xsl:template match="cos" mode="bookmarks">
        <fo:bookmark internal-destination="doc-title">
            <fo:bookmark-title>
                <xsl:value-of select="$doc-title"/>
            </fo:bookmark-title>
            <xsl:apply-templates select="meta-data/abstract|body/section|back/section|//reference|//glossary" mode="bookmarks"/>
            <xsl:call-template name="indexoutline"/>
        </fo:bookmark>
    </xsl:template>
    
    <xsl:template match="abstract" mode="bookmarks">
        <fo:bookmark internal-destination="abstract">
            <fo:bookmark-title>
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Abstract'"/>
                </xsl:call-template>
            </fo:bookmark-title>
        </fo:bookmark>
    </xsl:template>
    
    <xsl:template match="section[not(ancestor::back)]" mode="bookmarks">
        <fo:bookmark internal-destination="{generate-id(.)}">
            <fo:bookmark-title>
                <xsl:number level="multiple" count="section|inset" format="1.1"/>
                <xsl:text>&#x20;</xsl:text>
                <xsl:value-of select="title"/>
            </fo:bookmark-title>
            <xsl:apply-templates select="section" mode="bookmarks"/>
        </fo:bookmark>
    </xsl:template>
    
    <xsl:template match="section[ancestor::back]" mode="bookmarks">
        <fo:bookmark internal-destination="{generate-id(.)}">
            <fo:bookmark-title>
                <xsl:number level="multiple" count="section|inset" format="A.1"/>
                <xsl:text>&#x20;</xsl:text>
                <xsl:value-of select="title"/>
            </fo:bookmark-title>
            <xsl:apply-templates select="section" mode="bookmarks"/>
        </fo:bookmark>
    </xsl:template>
    
    <xsl:template match="reference" mode="bookmarks">
        <fo:bookmark internal-destination="{generate-id(./ref-item[1])}">
            <fo:bookmark-title>
                
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'References'"/>
                </xsl:call-template>
                
            </fo:bookmark-title>
        </fo:bookmark>
    </xsl:template>
    
    <xsl:template match="glossary" mode="bookmarks">
        <fo:bookmark internal-destination="glossary">
            <fo:bookmark-title>
                
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Glossary'"/>
                </xsl:call-template>
                
            </fo:bookmark-title>
        </fo:bookmark>
    </xsl:template>
    
    <xsl:template name="bookmarks.indexoutline">
        <xsl:if test="$generate.index = '1'">
            <fo:bookmark internal-destination="index">
                <fo:bookmark-title>
                    
                    <xsl:call-template name="getString">
                        <xsl:with-param name="stringName" select="'Index'"/>
                    </xsl:call-template>
                    
                </fo:bookmark-title>
            </fo:bookmark>
        </xsl:if>
    </xsl:template>
    
    
</xsl:stylesheet>