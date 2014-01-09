<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">



    <!-- Global variables -->
    <!-- ================ -->

    <xsl:variable name="doc-title" select="//meta-data/doc-info/title"/>
    <xsl:variable name="subtitle" select="//meta-data/doc-info/subtitle"/>
    <xsl:variable name="doc-no" select="//meta-data/doc-info/doc-no/number"/>
    <xsl:variable name="rev" select="//meta-data/doc-info/doc-no/rev"/>
    <xsl:variable name="year" select="//meta-data/pub-info/rev-date/y"/>
    <xsl:variable name="applic" select="/*/@applic"/>
    <xsl:variable name="root-name" select="name(/*)"/>

    <xsl:variable name="demo">
        <xsl:choose>
            <xsl:when test="$root-name = 'cargotec'">
                <xsl:value-of select="'cargotec'"/>
            </xsl:when>
            <xsl:when test="/*/@role = 'gunnebo'">
                <xsl:value-of select="'gunnebo'"/>
            </xsl:when>

            <!-- Default COSML layout -->
            <xsl:otherwise>
                <xsl:value-of select="''"/>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:variable>



    <!-- Page geometry parameters -->
    <!-- ======================== -->

    <xsl:param name="double.sided" select="'1'"/>
    <xsl:param name="paper.type" select="'A4'"/>

    <xsl:param name="page.width">
        <xsl:choose>
            <xsl:when test="$paper.type = 'A4'">210mm</xsl:when>
            <xsl:when test="$paper.type = 'A5'">148mm</xsl:when>
            <xsl:otherwise>210mm</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="page.height">
        <xsl:choose>
            <xsl:when test="$paper.type = 'A4'">297mm</xsl:when>
            <xsl:when test="$paper.type = 'A5'">210mm</xsl:when>
            <xsl:otherwise>297mm</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="page.margin.bottom">
        <xsl:if test="$paper.type='A4'">5mm</xsl:if>
        <xsl:if test="$paper.type='A5'">2.5mm</xsl:if>
    </xsl:param>

    <xsl:param name="page.margin.top">
        <xsl:if test="$paper.type='A4'">5mm</xsl:if>
        <xsl:if test="$paper.type='A5'">2.5mm</xsl:if>
    </xsl:param>

    <xsl:param name="page.margin.inner">
        <xsl:choose>
            <xsl:when test="$double.sided != '0'">
                <xsl:if test="$paper.type='A4'">20mm</xsl:if>
                <xsl:if test="$paper.type='A5'">10mm</xsl:if>
            </xsl:when>
            <xsl:otherwise>20mm</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="page.margin.outer">
        <xsl:choose>
            <xsl:when test="$double.sided != '0'">
                <xsl:if test="$paper.type='A4'">10mm</xsl:if>
                <xsl:if test="$paper.type='A5'">5mm</xsl:if>
            </xsl:when>
            <xsl:otherwise>20mm</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="body.margin.bottom">
        <xsl:if test="$paper.type='A4'">30mm</xsl:if>
        <xsl:if test="$paper.type='A5'">20mm</xsl:if>
    </xsl:param>

    <xsl:param name="body.margin.top">
        <xsl:if test="$paper.type='A4'">30mm</xsl:if>
        <xsl:if test="$paper.type='A5'">20mm</xsl:if>
    </xsl:param>

    <xsl:param name="body.margin.inner">
        <xsl:choose>
            <xsl:when test="$double.sided != '0'">
                <xsl:if test="$paper.type='A4'">
                    <xsl:value-of select="'30mm'"/>
                </xsl:if>
                <xsl:if test="$paper.type='A5'">
                    <xsl:value-of select="'15mm'"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>30mm</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="body.margin.outer">
        <xsl:choose>
            <xsl:when test="$double.sided != '0'">
                <xsl:if test="$paper.type='A4'">
                    <xsl:value-of select="'25mm'"/>
                </xsl:if>
                <xsl:if test="$paper.type='A5'">
                    <xsl:value-of select="'12.5mm'"/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>30mm</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="region.before.extent">
        <xsl:if test="$paper.type='A4'">25mm</xsl:if>
        <xsl:if test="$paper.type='A5'">19mm</xsl:if>
    </xsl:param>

    <xsl:param name="region.after.extent">
        <xsl:if test="$paper.type='A4'">25mm</xsl:if>
        <xsl:if test="$paper.type='A5'">19mm</xsl:if>
    </xsl:param>



    <!-- Global parameters -->
    <!-- ================= -->
    <!-- Unless otherwise specified, 1=yes, other=no) -->

    <!-- Create a cover page -->
    <xsl:param name="cover.page">0</xsl:param>

    <!-- Create a TOC  -->
    <xsl:param name="create.toc">1</xsl:param>

    <!-- TOC depth (number of levels: 1, 2, or 3) -->
    <xsl:param name="toc.depth">2</xsl:param>

    <!-- Generate an index (requires FO 1.1,
       does not currently work with FOP) -->
    <xsl:param name="generate.index">0</xsl:param>

    <!-- Show a logotype in the footer of the first page -->
    <xsl:param name="first.page.footer.logo">1</xsl:param>

    <!-- Show some text in the footer of the first page -->
    <!-- The actual text is defined in strings.xml -->
    <xsl:param name="first.page.footer.text">1</xsl:param>

    <!-- Numbered sections -->
    <xsl:param name="section.numbering">1</xsl:param>

    <!-- Page break after top level section -->
    <xsl:param name="break.after.section.level1">
        <xsl:choose>
            <xsl:when test="$demo !=''">1</xsl:when>
            <xsl:otherwise>0</xsl:otherwise>
        </xsl:choose>

    </xsl:param>

    <!-- Generate a "legal" page with copyright and trademark info -->
    <xsl:param name="legal.page">0</xsl:param>

    <!-- Create running page headers -->
    <xsl:param name="page.headers">1</xsl:param>

    <!-- Use doc title in page headers -->
    <xsl:param name="page.headers.doc.title">0</xsl:param>

    <!-- Use current top level section title in page headers (FOP 0.20.4 crashes. 0.20.5: works, but wrong font) -->
    <xsl:param name="page.headers.curr.section">1</xsl:param>

    <!-- Use XSL-FO 1.1 Bookmarks -->
    <xsl:param name="xslfo.bookmarks">0</xsl:param>

    <!-- Use XEP extensions (currently:  meta-data, bookmarks, index) -->
    <xsl:param name="xep.extensions">0</xsl:param>

    <!-- Use AntennaHouse extensions (currently: meta-data, bookmarks, index page numbers) -->
    <xsl:param name="axf.extensions">0</xsl:param>

    <!-- Use FOP extensions (currently: bookmarks) -->
    <!-- Also triggers a few FOP workarounds -->
    <xsl:param name="fop.extensions">1</xsl:param>



    <!-- Text properties -->
    <!-- =============== -->

    <!-- Blocks, paragraphs -->
    <xsl:param name="body-font-family">
        <xsl:choose>
            <xsl:when test="/cos/@xml:lang='ja'">MS-Gothic</xsl:when>
            <xsl:otherwise>Times, MS-Gothic, LucidaSans, 'Zapf Dingbats', Symbol,
                Tahoma</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="body-font-size">
        <xsl:if test="$paper.type='A4'">12pt</xsl:if>
        <xsl:if test="$paper.type='A5'">9pt</xsl:if>
    </xsl:param>

    <!-- Headings -->
    <xsl:param name="heading-font-family">
        <xsl:choose>
            <xsl:when test="/cos/@xml:lang='ja'">MS-Gothic</xsl:when>
            <xsl:otherwise>sans-serif</xsl:otherwise>
        </xsl:choose>
    </xsl:param>

    <xsl:param name="heading1-font-size">
        <xsl:value-of select="number(substring-before($body-font-size, 'pt')) * 1.5"/>
        <xsl:text>pt</xsl:text>
    </xsl:param>

    <xsl:param name="heading2-font-size">
        <xsl:value-of select="'14pt'"/>
    </xsl:param>



    <!-- Standard images -->
    <!-- =============== -->

    <!-- Path to directory containing standard images etc (note: trailing slash) -->
    <xsl:param name="standard.files.dir"
        select="'http://www.sgmlguru.org/exist/rest/db/work/system/cosml/standard-images/'"/>

    <!-- Name of logotype image -->
    <xsl:param name="logo.image">logotyp.jpg</xsl:param>

    <!-- Linux Penguin -->
    <xsl:param name="tux.image">tux.jpg</xsl:param>



    <!-- NOT IMPLEMENTED -->
    <!-- =============== -->

    <!-- Use graphics in notes and admonishments -->
    <!--xsl:param name="admon.graphics" select="1"/-->

</xsl:stylesheet>
