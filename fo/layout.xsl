<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:rx="http://www.renderx.com/XSL/Extensions" 
    version="2.0">

    <xsl:template match="/*">

        <!-- Multiple font selection added in XEP 3.10 -->
        <fo:root 
            hyphenate="true" 
            hyphenation-push-character-count="2"
            hyphenation-remain-character-count="2" 
            font-selection-strategy="character-by-character"
            orphans="2" 
            widows="2">

            <xsl:attribute name="language">
                <xsl:choose>
                    <xsl:when test="./@xml:lang">
                        <xsl:value-of select="./@xml:lang"/>
                    </xsl:when>
                    <xsl:otherwise>sv</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>

            <!-- XEP extension: PDF meta-data -->
            <xsl:if test="$xep.extensions=1">
                <xsl:call-template name="xep-meta"/>
            </xsl:if>

            <!-- AntennaHouse extension: PDF meta-data -->
            <xsl:if test="$axf.extensions=1">
                <xsl:call-template name="axf-meta"/>
            </xsl:if>

            <fo:layout-master-set>


                <!-- Page masters -->
                <!-- ============ -->

                <!-- Cover page -->
                <fo:simple-page-master master-name="cover" xsl:use-attribute-sets="left-page">
                    <fo:region-body margin-top="40mm"/>
                    <fo:region-before extent="{$region.before.extent}"/>
                    <fo:region-after extent="30mm" region-name="xsl-region-after-cover"/>
                </fo:simple-page-master>


                <!-- Back cover page -->
                <fo:simple-page-master master-name="back-cover" xsl:use-attribute-sets="right-page">
                    <fo:region-body margin-top="40mm"/>
                    <fo:region-before extent="{$region.before.extent}"/>
                    <fo:region-after extent="30mm" region-name="xsl-region-after-back-cover"/>
                </fo:simple-page-master>


                <!-- Meta-data page -->
                <fo:simple-page-master master-name="left-meta" xsl:use-attribute-sets="left-page">
                    <fo:region-body xsl:use-attribute-sets="region-body-left"/>
                    <fo:region-before region-name="xsl-region-before-left"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-left"/>
                </fo:simple-page-master>

                <fo:simple-page-master master-name="right-meta" xsl:use-attribute-sets="right-page">
                    <fo:region-body xsl:use-attribute-sets="region-body-right"/>
                    <fo:region-before region-name="xsl-region-before-right"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-right"/>
                </fo:simple-page-master>


                <!-- TOC pages -->
                <fo:simple-page-master master-name="left-TOC" xsl:use-attribute-sets="left-page">
                    <fo:region-body xsl:use-attribute-sets="region-toc-left"> </fo:region-body>
                    <fo:region-before extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-left"/>
                </fo:simple-page-master>

                <fo:simple-page-master master-name="right-TOC" xsl:use-attribute-sets="right-page">
                    <fo:region-body xsl:use-attribute-sets="region-toc-right"> </fo:region-body>
                    <fo:region-before extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-right"/>
                </fo:simple-page-master>


                <!-- Body pages -->
                <fo:simple-page-master master-name="left-page" xsl:use-attribute-sets="left-page">
                    <fo:region-body xsl:use-attribute-sets="region-body-left"> </fo:region-body>
                    <fo:region-before region-name="xsl-region-before-left"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-left"/>
                </fo:simple-page-master>

                <fo:simple-page-master master-name="right-page" xsl:use-attribute-sets="right-page">
                    <fo:region-body xsl:use-attribute-sets="region-body-right"> </fo:region-body>
                    <fo:region-before region-name="xsl-region-before-right"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-right"/>
                </fo:simple-page-master>


                <!-- Back pages -->
                <fo:simple-page-master master-name="left-back" xsl:use-attribute-sets="left-page">
                    <fo:region-body xsl:use-attribute-sets="region-body-left"> </fo:region-body>
                    <fo:region-before region-name="xsl-region-before-left"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-left"/>
                </fo:simple-page-master>

                <fo:simple-page-master master-name="right-back" xsl:use-attribute-sets="right-page">
                    <fo:region-body xsl:use-attribute-sets="region-body-right"> </fo:region-body>
                    <fo:region-before region-name="xsl-region-before-right"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-right"/>
                </fo:simple-page-master>


                <!-- Index pages -->
                <fo:simple-page-master master-name="left-index" xsl:use-attribute-sets="left-page">
                    <fo:region-body xsl:use-attribute-sets="region-index-left"> </fo:region-body>
                    <fo:region-before region-name="xsl-region-before-left"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-left"/>
                </fo:simple-page-master>

                <fo:simple-page-master master-name="right-index" xsl:use-attribute-sets="right-page">
                    <fo:region-body xsl:use-attribute-sets="region-index-right"> </fo:region-body>
                    <fo:region-before region-name="xsl-region-before-right"
                        extent="{$region.before.extent}"/>
                    <fo:region-after extent="{$region.after.extent}"
                        region-name="xsl-region-after-right"/>
                </fo:simple-page-master>





                <!-- Page sequence masters -->
                <!-- ===================== -->
                <fo:page-sequence-master master-name="meta-data">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="right-meta"
                            odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="left-meta"
                            odd-or-even="even"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>

                <fo:page-sequence-master master-name="TOC">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="right-TOC"
                            odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="left-TOC"
                            odd-or-even="even"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>

                <fo:page-sequence-master master-name="contents">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="right-page"
                            odd-or-even="odd"/>
                        <!-- Removed to get a blank last page if necessary -->
                        <!-- blank-or-not-blank="not-blank"/-->
                        <fo:conditional-page-master-reference master-reference="left-page"
                            odd-or-even="even"/>
                        <!-- blank-or-not-blank="not-blank"/-->
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>

                <fo:page-sequence-master master-name="back">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="right-back"
                            odd-or-even="odd"/>
                        <!--blank-or-not-blank="not-blank"/>-->
                        <fo:conditional-page-master-reference master-reference="left-back"
                            odd-or-even="even"/>
                        <!--blank-or-not-blank="not-blank"/>-->
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>

                <fo:page-sequence-master master-name="index">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="right-index"
                            odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="left-index"
                            odd-or-even="even"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>

                <!-- Reuse index page sequence for pub-info -->
                <fo:page-sequence-master master-name="pub-info">
                    <fo:repeatable-page-master-alternatives>
                        <fo:conditional-page-master-reference master-reference="right-index"
                            odd-or-even="odd"/>
                        <fo:conditional-page-master-reference master-reference="left-index"
                            odd-or-even="even"/>
                    </fo:repeatable-page-master-alternatives>
                </fo:page-sequence-master>


            </fo:layout-master-set>


            <!-- XEP extension: PDF bookmarks -->
            <xsl:if test="$xep.extensions = 1">
                <rx:outline>
                    <!-- See extension.xsl -->
                    <xsl:apply-templates select="../* | ." mode="outline"/>
                    <xsl:call-template name="indexoutline"/>
                </rx:outline>
            </xsl:if>


            <!-- FOP extension: PDF bookmarks -->
            <xsl:if test="$fop.extensions = 1">
                <!--xsl:apply-templates select="cos" mode="fop.outline"/-->
                <xsl:apply-templates select="../*|." mode="fop.outline"/>
                <!-- select="meta-data/abstract | body/section | back/section | back/reference | back/glossary" -->
                <xsl:call-template name="fop-indexoutline"/>
            </xsl:if>


            <!-- XSL-FO 1.1 Bookmarks -->
            <xsl:if test="$xslfo.bookmarks = '1'">
                <xsl:call-template name="fo-bookmarks"/>
            </xsl:if>


            <!-- Actual Document Contents -->
            <xsl:choose>
                <xsl:when test="$root-name = 'section'">
                    <xsl:call-template name="body-cosml"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>


            <!-- Back Cover -->
            <xsl:if test="$cover.page = '1'">
                <!-- In meta-data.xsl -->
                <xsl:call-template name="back-cover"/>
            </xsl:if>

        </fo:root>

    </xsl:template>




    <!-- Inserted last in content -->
    <xsl:template name="total-page-count">
        <fo:block id="id-last-page"/>
    </xsl:template>

</xsl:stylesheet>
