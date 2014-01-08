<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink"
    version="1.0">

    <!-- Attribute sets -->
    <!-- ============== -->

    <!-- Page geometry -->

    <!-- Even (left-hand) pages -->
    <xsl:attribute-set name="left-page">
        <xsl:attribute name="page-height">
            <xsl:value-of select="$page.height"/>
        </xsl:attribute>
        <xsl:attribute name="page-width">
            <xsl:value-of select="$page.width"/>
        </xsl:attribute>
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$page.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$page.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$page.margin.outer"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$page.margin.inner"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-toc-left">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$body.margin.outer"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$body.margin.inner"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-body-left">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$body.margin.outer"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$body.margin.inner"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-index-left">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$body.margin.outer"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$body.margin.inner"/>
        </xsl:attribute>
    </xsl:attribute-set>


    <!-- Odd (right-hand) pages -->
    <xsl:attribute-set name="right-page">
        <xsl:attribute name="page-height">
            <xsl:value-of select="$page.height"/>
        </xsl:attribute>
        <xsl:attribute name="page-width">
            <xsl:value-of select="$page.width"/>
        </xsl:attribute>
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$page.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$page.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$page.margin.inner"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$page.margin.outer"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-toc-right">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$body.margin.inner"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$body.margin.outer"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-body-right">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$body.margin.inner"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$body.margin.outer"/>
        </xsl:attribute>
    </xsl:attribute-set>

    <xsl:attribute-set name="region-index-right">
        <xsl:attribute name="margin-top">
            <xsl:value-of select="$body.margin.top"/>
        </xsl:attribute>
        <xsl:attribute name="margin-bottom">
            <xsl:value-of select="$body.margin.bottom"/>
        </xsl:attribute>
        <xsl:attribute name="margin-left">
            <xsl:value-of select="$body.margin.inner"/>
        </xsl:attribute>
        <xsl:attribute name="margin-right">
            <xsl:value-of select="$body.margin.outer"/>
        </xsl:attribute>
    </xsl:attribute-set>


    <!-- Section titles -->
    <xsl:attribute-set name="section-titles">
        <xsl:attribute name="font-family">
            <xsl:value-of select="$heading-font-family"/>
        </xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
    </xsl:attribute-set>


    <!-- Table cells -->
    <xsl:attribute-set name="tablecell-properties">
        <xsl:attribute name="padding-start">3pt</xsl:attribute>
        <xsl:attribute name="padding-end">3pt</xsl:attribute>
        <xsl:attribute name="padding-before">2pt</xsl:attribute>
        <xsl:attribute name="padding-after">2pt</xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
        <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
        <xsl:attribute name="border-left-style">solid</xsl:attribute>
        <xsl:attribute name="border-right-style">solid</xsl:attribute>
        <xsl:attribute name="border-width">0.1pt</xsl:attribute>
    </xsl:attribute-set>


    <!-- Indented blocks (note, admonishment, code-block) -->
    <xsl:attribute-set name="indented-block-properties">
        <xsl:attribute name="space-before">12pt</xsl:attribute>
        <xsl:attribute name="space-after">12pt</xsl:attribute>
        <xsl:attribute name="start-indent">3mm</xsl:attribute>
        <xsl:attribute name="end-indent">3mm</xsl:attribute>
    </xsl:attribute-set>

</xsl:stylesheet>
