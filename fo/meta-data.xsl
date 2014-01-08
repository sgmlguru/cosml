<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">

    <xsl:template match="meta-data">

        <!-- No cover page ("internal" style) -->
        <!-- ================================ -->
        <xsl:if test="$cover.page != '1'">

            <!-- initial-page-number is a basic property that all implementations
           must support whereas force-page-count is an extended property. Also,
           use of initial-page-number="auto-odd" on the initial page that is
           supposed to be odd (recto) is much more intuitive and better practice
           than trying to make chapters start on recto pages by trying to make
           whatever page-sequence might precede a chapter end on an even page. -->

            <!-- MJ 030201: start page numbering on first page -->
            <!-- No blank page 2 if TOC fits on first page -->

            <fo:page-sequence master-reference="meta-data" initial-page-number="auto-odd"
                font-family="sans-serif">

                <xsl:call-template name="meta-region-before"/>

                <xsl:call-template name="region-after"/>


                <fo:flow flow-name="xsl-region-body">

                    <fo:block hyphenate="false" font-family="sans-serif" font-size="24pt"
                        font-weight="bold" border-after-style="double" start-indent="-10mm"
                        space-after="6pt">

                        <!-- Document Type -->
                        <xsl:choose>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'quote'">
                                <fo:block margin-bottom="6pt">
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName" select="'Quotation'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'order-conf'">
                                <fo:block margin-bottom="6pt">
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName"
                                            select="'Order Confirmation'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'whitepaper'">
                                <fo:block margin-bottom="6pt">
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName" select="'Whitepaper'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'report'">
                                <!-- Empty for now -->
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'use-cases'">
                                <fo:block margin-bottom="6pt">
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName" select="'Use Cases'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'test-spec'">
                                <fo:block margin-bottom="6pt">
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName"
                                            select="'Test Specification'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'system-spec'">
                                <fo:block margin-bottom="6pt">
                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName"
                                            select="'System Specification'"/>
                                    </xsl:call-template>
                                </fo:block>
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'ip'">
                                <!-- Empty for now -->
                            </xsl:when>
                            <xsl:when test="//meta-data/doc-info/doc-type/@type = 'rs'">
                                <!-- Empty for now -->
                            </xsl:when>

                            <!-- Fallback for new document types: defined by @type='other' combined with element contents -->
                            <xsl:when
                                test="//meta-data/doc-info/doc-type/@type = 'other' and normalize-space(//doc-info/doc-type) != ''">
                                <fo:block margin-bottom="6pt">
                                    <xsl:value-of select="normalize-space(//doc-info/doc-type)"/>
                                </fo:block>
                            </xsl:when>
                        </xsl:choose>

                        <!-- Document Title -->
                        <fo:block id="doc-title">
                            <xsl:value-of select="$doc-title"/>
                        </fo:block>

                        <!-- Document Subtitle -->
                        <fo:block space-before="1mm" font-family="sans-serif" font-size="12pt"
                            font-weight="bold" text-align="start">
                            <xsl:value-of select="$subtitle"/>
                        </fo:block>

                    </fo:block>

                    <fo:block font-family="sans-serif" font-size="10pt" text-align="start">

                        <xsl:if test="abstract">
                            <fo:block font-size="{$heading1-font-size}" font-weight="bold"
                                start-indent="-10mm" space-before="24pt" space-after="8pt"
                                id="abstract">

                                <!-- Provide localized "Abstract" heading -->
                                <xsl:call-template name="getString">
                                    <xsl:with-param name="stringName" select="'Abstract'"/>
                                </xsl:call-template>

                            </fo:block>
                            <fo:block>

                                <!-- AntennaHouse PDF bookmarks -->
                                <xsl:if test="$axf.extensions=1">
                                    <xsl:call-template name="axf-bookmarks">
                                        <xsl:with-param name="outline-title">
                                            <xsl:call-template name="getString">
                                                <xsl:with-param name="stringName"
                                                  select="'Abstract'"/>
                                            </xsl:call-template>
                                        </xsl:with-param>
                                    </xsl:call-template>
                                </xsl:if>

                                <xsl:apply-templates select="abstract"/>
                            </fo:block>
                        </xsl:if>

                        <fo:block>
                            <xsl:call-template name="doc-info"/>
                        </fo:block>

                    </fo:block>

                    <xsl:if test="$create.toc='1'">
                        <xsl:call-template name="toc"/>
                    </xsl:if>

                </fo:flow>
            </fo:page-sequence>
        </xsl:if>




        <!-- With cover page -->
        <!-- =============== -->
        <xsl:if test="$cover.page='1'">
            <fo:page-sequence master-reference="cover">

                <fo:static-content flow-name="xsl-region-after-cover">

                    <!-- Logotype on cover footer -->
                    <fo:block font-family="sans-serif" text-align="center" display-align="after">
                        <xsl:if test="$first.page.footer.logo=1">
                            <!--                  <fo:external-graphic src="url('{concat($standard.files.dir, $logo.image)}')" width="55mm" height="scale-to-fit"/>-->
                            <xsl:call-template name="logo-ref"/>
                            <!-- See static-content.xsl -->
                        </xsl:if>
                    </fo:block>

                    <fo:block>
                        <fo:leader/>
                    </fo:block>
                    <!-- empty dummy -->

                    <fo:block space-before="0pt" text-align="center" font-size="8pt"
                        font-weight="bold">
                        <xsl:if test="$first.page.footer.text=1">
                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'footer-text'"/>
                            </xsl:call-template>
                        </xsl:if>
                    </fo:block>

                </fo:static-content>


                <fo:flow flow-name="xsl-region-body">

                    <!-- Document Title -->
                    <fo:block font-family="sans-serif" font-size="32pt" font-weight="bold"
                        text-align="end" id="doc-title">
                        <xsl:value-of select="$doc-title"/>
                    </fo:block>

                    <!-- Document Subtitle -->
                    <fo:block space-before="5mm" font-family="sans-serif" font-size="14pt"
                        font-weight="bold" text-align="end">
                        <xsl:value-of select="$subtitle"/>
                    </fo:block>

                    <!-- Cover Image -->
                    <!-- Cover image COSML -->

                </fo:flow>

            </fo:page-sequence>


            <!-- Meta-data page (page 2) -->
            <fo:page-sequence force-page-count="end-on-even" master-reference="meta-data" format="i">

                <xsl:call-template name="region-after"/>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-family="sans-serif" font-size="10pt" text-align="start">

                        <!-- Abstract, if present -->
                        <xsl:if test="abstract">
                            <fo:block font-size="{$heading1-font-size}" font-weight="bold"
                                start-indent="-10mm" space-after="16pt" id="abstract">
                                <!-- Localized "Abstract" heading -->
                                <xsl:call-template name="getString">
                                    <xsl:with-param name="stringName" select="'Abstract'"/>
                                </xsl:call-template>
                            </fo:block>
                            <xsl:apply-templates select="abstract"/>
                        </xsl:if>

                        <!-- About the document -->
                        <xsl:call-template name="doc-info"/>

                        <!-- Image from pub-info -->


                    </fo:block>
                </fo:flow>
            </fo:page-sequence>


            <!-- Table of Contents (page 3-) -->
            <xsl:if test="$create.toc='1'">
                <fo:page-sequence master-reference="TOC" force-page-count="end-on-even" format="i">

                    <!--xsl:call-template name="region-before"/-->
                    <xsl:call-template name="region-after"/>

                    <fo:flow flow-name="xsl-region-body">
                        <xsl:call-template name="toc"/>
                    </fo:flow>

                </fo:page-sequence>
            </xsl:if>

        </xsl:if>

    </xsl:template>




    <!-- "About..." stuff -->
    <xsl:template name="doc-info">
        <fo:block font-size="{$heading1-font-size}" font-weight="bold" start-indent="-10mm"
            space-after="8pt" space-before="24pt">

            <!-- About the Document -->
            <xsl:call-template name="getString">
                <xsl:with-param name="stringName" select="'About the Document'"/>
            </xsl:call-template>

        </fo:block>
        <fo:table>
            <fo:table-column column-width="35mm"/>
            <fo:table-column column-width="70mm"/>
            <fo:table-body font-size="10pt" font-family="sans-serif">
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>

                            <!-- Document Title -->
                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'Document title'"/>
                            </xsl:call-template>

                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:value-of select="$doc-title"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>

                <xsl:if test="//doc-no">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>

                                <!-- Document Number -->
                                <xsl:call-template name="getString">
                                    <xsl:with-param name="stringName" select="'Document number'"/>
                                </xsl:call-template>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:value-of select="$doc-no"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="$rev"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <xsl:if test="//rev-date">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <!-- Revision date -->
                                <xsl:call-template name="getString">
                                    <xsl:with-param name="stringName" select="'Revision date'"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:apply-templates select="//rev-date">
                                    <xsl:sort select="y"/>
                                    <xsl:sort select="m"/>
                                    <xsl:sort select="d"/>
                                </xsl:apply-templates>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <!-- Author info -->
                <xsl:if test="normalize-space(//author)!=''">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>

                                <!-- Written By -->
                                <xsl:call-template name="getString">
                                    <xsl:with-param name="stringName" select="'Written by'"/>
                                </xsl:call-template>

                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block>

                                <xsl:for-each select="//author/name">
                                    <xsl:apply-templates select="first"/>&#xA0;<xsl:apply-templates
                                        select="last"/>
                                    <xsl:if test="position() != last()">,&#x20;</xsl:if>
                                </xsl:for-each>

                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

                <!-- Recipient info -->
                <xsl:if test="normalize-space(//recipient-info)!=''">
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <!-- "Recipient:" -->
                                <xsl:call-template name="getString">
                                    <xsl:with-param name="stringName" select="'Recipient'"/>
                                </xsl:call-template>
                            </fo:block>
                        </fo:table-cell>

                        <fo:table-cell>
                            <xsl:for-each select="//recipient">
                                <xsl:if test="normalize-space(name) != ''">
                                    <fo:block>
                                        <xsl:for-each select="name">
                                            <xsl:apply-templates select="first"
                                                />&#xA0;<xsl:apply-templates select="last"/>
                                            <xsl:if test="position() != last()">,&#x20;</xsl:if>
                                        </xsl:for-each>
                                    </fo:block>
                                </xsl:if>
                                <xsl:if test="normalize-space(company-info) != ''">
                                    <fo:block>
                                        <xsl:apply-templates select="company-info/company-name"/>
                                    </fo:block>
                                </xsl:if>
                            </xsl:for-each>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>

            </fo:table-body>
        </fo:table>

    </xsl:template>


    <xsl:template match="rev-date">
        <xsl:value-of select="y"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="m"/>
        <xsl:text>-</xsl:text>
        <xsl:value-of select="d"/>
        <xsl:if test="position() != last()">,&#x20;</xsl:if>
    </xsl:template>



    <xsl:template name="back-cover">
        <fo:page-sequence master-reference="back-cover">

            <fo:static-content flow-name="xsl-region-after-back-cover">

                <!-- Logotype on cover footer -->
                <fo:block font-family="sans-serif" text-align="center" display-align="after">
                    <xsl:if test="$first.page.footer.logo=1">
                        <!--                  <fo:external-graphic src="url('{concat($standard.files.dir, $logo.image)}')" width="55mm" height="scale-to-fit"/>-->
                        <xsl:call-template name="logo-ref"/>
                        <!-- See static-content.xsl -->
                    </xsl:if>
                </fo:block>
            </fo:static-content>

            <fo:flow flow-name="xsl-region-body">
                <!-- Cover image COSML -->
                <fo:block>
                    <!-- COSML Back Cover -->
                    <fo:leader/>
                    <xsl:text> </xsl:text>
                </fo:block>
                <xsl:call-template name="total-page-count"/>
            </fo:flow>
        </fo:page-sequence>
    </xsl:template>




</xsl:stylesheet>
