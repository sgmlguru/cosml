<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">

    <xsl:template name="toc">
        <fo:block start-indent="-10mm" space-before="28pt" space-after="8pt"
            font-size="{$heading1-font-size}" font-weight="bold" font-family="sans-serif">

            <!-- "Table of Contents" heading -->
            <xsl:call-template name="getString">
                <xsl:with-param name="stringName" select="'Table of Contents'"/>
            </xsl:call-template>

        </fo:block>

        <!-- New TOC layout: nicer-looking leaders; numbered or non-numbered sections 
       Works best with XEP or AH; a little uglier in FOP :-) -->

        <fo:table start-indent="0mm" table-layout="fixed">

            <xsl:choose>
                <xsl:when test="$section.numbering=1">
                    <xsl:choose>
                        <xsl:when test="$toc.depth=1">
                            <fo:table-column column-width="6mm"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                        </xsl:when>
                        <xsl:when test="$toc.depth=2">
                            <fo:table-column column-width="8mm"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                        </xsl:when>
                        <xsl:when test="$toc.depth=3">
                            <fo:table-column column-width="10mm"/>
                            <fo:table-column column-width="proportional-column-width(1)"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>

                <xsl:otherwise>
                    <fo:table-column column-width="0mm"/>
                    <fo:table-column column-width="proportional-column-width(1)"/>
                </xsl:otherwise>
            </xsl:choose>

            <fo:table-body>

                <!-- One level TOC -->
                <xsl:if test="$toc.depth=1">

                    <xsl:apply-templates
                        select="//section[parent::body]/title |
            //inset[parent::body]"
                        mode="toc"/>

                    <xsl:if test="//back/section">
                        <xsl:call-template name="appendices-toc-heading"/>
                        <xsl:apply-templates
                            select="//section[parent::back]/title |
                      //inset[parent::back]"
                            mode="toc"/>
                    </xsl:if>
                </xsl:if>


                <!-- Two level TOC -->
                <xsl:if test="$toc.depth=2">

                    <xsl:apply-templates
                        select="//section[parent::body]/title |
            //section[parent::body]/section/title |
            //inset[parent::body] |
            //section[parent::body]/inset"
                        mode="toc"/>

                    <xsl:if test="//back/section">
                        <xsl:call-template name="appendices-toc-heading"/>
                        <xsl:apply-templates
                            select="//section[parent::back]/title |
                      //section[parent::back]/section/title |
                      //inset[parent::back] |
                      //section[parent::back]/inset"
                            mode="toc"/>
                    </xsl:if>
                </xsl:if>


                <!-- Three level TOC -->
                <xsl:if test="$toc.depth=3">
                    <xsl:apply-templates
                        select="//section[parent::body]/title |
            //section[parent::body]/section/title |
            //section[parent::body]/section/section/title |
            //inset[parent::body] |
            //section[parent::body]/inset |
            //section[parent::body]/section/inset"
                        mode="toc"/>

                    <xsl:if test="//back/section">
                        <xsl:call-template name="appendices-toc-heading"/>
                        <xsl:apply-templates
                            select="//section[parent::back]/title |
                      //section[parent::back]/section/title |
                      //section[parent::back]/section/section/title |
                      //inset[parent::back] |
                      //section[parent::back]/inset |
                      //section[parent::back]/section/inset"
                            mode="toc"/>
                    </xsl:if>
                </xsl:if>


                <!-- Glossary in TOC -->
                <xsl:if test="//glossary">
                    <xsl:apply-templates select="//glossary" mode="toc"/>
                </xsl:if>


                <!-- Reference in TOC -->
                <xsl:if test="//reference">
                    <xsl:apply-templates select="//reference" mode="toc"/>
                </xsl:if>


                <!-- Index in TOC -->
                <xsl:if test="$generate.index = '1'">
                    <xsl:call-template name="index-toc"/>
                </xsl:if>
                <!-- REMOVE comment markers for index in TOC -->

            </fo:table-body>
        </fo:table>
    </xsl:template>


    <!-- TOC entry, level 1 -->
    <xsl:template match="//section[not(parent::section)]/title" mode="toc">

        <fo:table-row font-weight="bold" font-size="12pt" space-before="3pt">

            <fo:table-cell>
                <fo:block font-weight="bold">

                    <xsl:if test="$section.numbering=1">
                        <xsl:call-template name="toc-numbering-choice"/>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>

            <fo:table-cell>
                <fo:block text-align-last="justify">

                    <!-- Testing: hyperlinked level 1 -->
                    <fo:basic-link internal-destination="{generate-id(.)}"
                        show-destination="replace">
                        <xsl:value-of select="."/>
                        <xsl:text>&#xA0; </xsl:text>
                        <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(.)}"/>
                    </fo:basic-link>
                </fo:block>
            </fo:table-cell>

        </fo:table-row>

    </xsl:template>

    <!-- TOC entry, level 2 -->
    <xsl:template match="//section[not(parent::section)]/section/title" mode="toc">

        <fo:table-row font-weight="normal" font-size="10pt">

            <fo:table-cell>

                <fo:block>
                    <xsl:if test="$section.numbering=1">
                        <xsl:call-template name="toc-numbering-choice"/>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>

            <fo:table-cell>
                <fo:block text-align-last="justify">
                    <xsl:value-of select="."/>&#xA0; <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{generate-id(.)}"/>
                </fo:block>
            </fo:table-cell>

        </fo:table-row>

    </xsl:template>

    <!-- TOC entry, level 3 -->
    <xsl:template match="//section[not(parent::section)]/section/section/title" mode="toc">

        <fo:table-row font-weight="normal" font-size="10pt">

            <fo:table-cell>

                <fo:block>
                    <xsl:if test="$section.numbering=1">
                        <xsl:call-template name="toc-numbering-choice"/>
                    </xsl:if>
                </fo:block>
            </fo:table-cell>

            <fo:table-cell>
                <fo:block text-align-last="justify">
                    <xsl:value-of select="."/>&#xA0; <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="{generate-id(.)}"/>
                </fo:block>
            </fo:table-cell>

        </fo:table-row>

    </xsl:template>

    <!-- Appendices Heading -->
    <xsl:template name="appendices-toc-heading">
        <fo:table-row font-weight="bold" font-size="12pt" space-before="3pt">

            <fo:table-cell>
                <fo:block/>
            </fo:table-cell>

            <fo:table-cell>
                <fo:block text-align-last="justify" margin-top="6pt">
                    <xsl:call-template name="getString">
                        <xsl:with-param name="stringName" select="'Appendices'"/>
                    </xsl:call-template>
                    <xsl:text>&#xA0; </xsl:text>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="appendices"/>
                </fo:block>
            </fo:table-cell>
        </fo:table-row>
    </xsl:template>

    <!-- References entry in TOC -->
    <xsl:template match="reference" mode="toc">

        <xsl:if test="ref-item">
            <fo:table-row font-weight="bold" font-size="12pt" space-before="3pt">

                <fo:table-cell>
                    <fo:block/>
                </fo:table-cell>

                <fo:table-cell>
                    <fo:block text-align-last="justify">
                        <xsl:call-template name="getString">
                            <xsl:with-param name="stringName" select="'References'"/>
                        </xsl:call-template>&#xA0; <fo:leader leader-pattern="dots"/>
                        <fo:page-number-citation ref-id="{generate-id(ref-item[1])}"/>
                    </fo:block>
                </fo:table-cell>

            </fo:table-row>
        </xsl:if>

    </xsl:template>

    <!-- Glossary entry -->
    <xsl:template match="glossary" mode="toc">

        <fo:table-row font-weight="bold" font-size="12pt" space-before="3pt">

            <fo:table-cell>
                <fo:block/>
            </fo:table-cell>

            <fo:table-cell>
                <fo:block text-align-last="justify">
                    <xsl:call-template name="getString">
                        <xsl:with-param name="stringName" select="'Glossary'"/>
                    </xsl:call-template>
                    <xsl:text>&#xA0; </xsl:text>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="glossary"/>
                </fo:block>
            </fo:table-cell>

        </fo:table-row>
    </xsl:template>

    <!-- Index entry -->
    <xsl:template name="index-toc">

        <fo:table-row font-weight="bold" font-size="12pt" space-before="3pt">

            <fo:table-cell>
                <fo:block/>
            </fo:table-cell>

            <fo:table-cell>
                <fo:block text-align-last="justify">
                    <xsl:call-template name="getString">
                        <xsl:with-param name="stringName" select="'Index'"/>
                    </xsl:call-template>
                    <xsl:text>&#xA0; </xsl:text>
                    <fo:leader leader-pattern="dots"/>
                    <fo:page-number-citation ref-id="index"/>
                </fo:block>
            </fo:table-cell>

        </fo:table-row>

    </xsl:template>

    <xsl:template name="toc-numbering-choice">
        <xsl:choose>
            <xsl:when test="ancestor::body">
                <xsl:number level="multiple" count="section[ancestor::body]|inset[ancestor::body]"
                    format="1.1"/>
            </xsl:when>
            <xsl:when test="ancestor::back">
                <xsl:number level="multiple" count="section[ancestor::back]|inset[ancestor::back]"
                    format="A.1"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
