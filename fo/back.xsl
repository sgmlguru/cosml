<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">



    <!-- For back cover, see meta-data.xsl -->

    <xsl:template match="back">

        <!-- Appendices -->
        <xsl:if test="section">

            <fo:page-sequence master-reference="back">

                <xsl:choose>
                    <!-- Formal template pagination alternative -->
                    <xsl:when
                        test="$cover.page='1' and not(glossary) and not(reference) and $legal.page='0'">
                        <xsl:attribute name="force-page-count">end-on-odd</xsl:attribute>
                        <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
                    </xsl:when>
                    <!-- Formal template pagination alternative -->
                    <xsl:when test="$cover.page='1'">
                        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
                        <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- No special pagination rules for informal template -->
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:call-template name="region-before-appendix"/>
                <xsl:call-template name="region-after"/>

                <fo:flow flow-name="xsl-region-body">
                    <!--<fo:block
            break-before="page"
            space-after="8pt"
            start-indent="-10mm"
            font-family="sans-serif"
            font-size="{$heading1-font-size}"
            font-weight="bold"
            id="appendices">
            
            <!-\- "Appendices" heading -\->
            <xsl:call-template name="getString">
              <xsl:with-param name="stringName" select="'Appendices'"/>
            </xsl:call-template>
            
          </fo:block>-->
                    <fo:block space-before="6pt" font-family="{$body-font-family}"
                        font-size="{$body-font-size}" id="appendices">

                        <!-- AntennaHouse PDF bookmarks -->
                        <xsl:if test="$axf.extensions=1">
                            <xsl:call-template name="axf-bookmarks">
                                <xsl:with-param name="outline-title">

                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName" select="'Appendices'"/>
                                    </xsl:call-template>

                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:if>

                        <xsl:apply-templates select="section"/>

                    </fo:block>

                    <xsl:if
                        test="not(//reference) and not(//glossary) and $cover.page = '0' and $generate.index = '0'">
                        <xsl:call-template name="total-page-count"/>
                    </xsl:if>

                </fo:flow>
            </fo:page-sequence>
        </xsl:if>


        <!-- Glossary page -->
        <!-- !='' no longer needed when running XFO. ResolveOp messed things up -->
        <xsl:if test="glossary">

            <fo:page-sequence master-reference="back">

                <xsl:choose>
                    <!-- Formal template pagination alternative -->
                    <xsl:when test="$cover.page='1' and not(reference) and $legal.page='0'">
                        <xsl:attribute name="force-page-count">end-on-odd</xsl:attribute>
                        <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
                    </xsl:when>
                    <!-- Formal template pagination alternative -->
                    <xsl:when test="$cover.page='1' and reference and $legal.page='0'">
                        <xsl:attribute name="force-page-count">end-on-even</xsl:attribute>
                        <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- No special pagination rules for informal template -->
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:call-template name="region-before-glossary"/>
                <xsl:call-template name="region-after"/>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block break-before="page" space-after="8pt" start-indent="-10mm"
                        font-family="sans-serif" font-size="{$heading1-font-size}"
                        font-weight="bold" id="glossary">

                        <!-- "Glossary" heading -->
                        <xsl:call-template name="getString">
                            <xsl:with-param name="stringName" select="'Glossary'"/>
                        </xsl:call-template>

                    </fo:block>
                    <fo:block space-before="6pt" font-family="{$body-font-family}"
                        font-size="{$body-font-size}">

                        <!-- AntennaHouse PDF bookmarks -->
                        <xsl:if test="$axf.extensions=1">
                            <xsl:call-template name="axf-bookmarks">
                                <xsl:with-param name="outline-title">

                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName" select="'Glossary'"/>
                                    </xsl:call-template>

                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:if>

                        <xsl:apply-templates select="//glossary"/>
                    </fo:block>


                    <xsl:if test="not(//reference) and $cover.page = '0' and $generate.index = '0'">
                        <xsl:call-template name="total-page-count"/>
                    </xsl:if>

                </fo:flow>
            </fo:page-sequence>
        </xsl:if>


        <!-- Reference page -->
        <xsl:if test="reference">
            <fo:page-sequence master-reference="back">

                <xsl:choose>
                    <!-- Formal template pagination alternative -->
                    <xsl:when test="$cover.page='1' and $legal.page='0'">
                        <xsl:attribute name="force-page-count">odd</xsl:attribute>
                        <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
                    </xsl:when>
                    <!-- Formal template pagination alternative -->
                    <xsl:when test="$cover.page='1' and $legal.page='1'">
                        <xsl:attribute name="initial-page-number">auto-odd</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <!-- No special pagination rules for informal template -->
                    </xsl:otherwise>
                </xsl:choose>

                <xsl:call-template name="region-before-reference"/>
                <xsl:call-template name="region-after"/>

                <fo:flow flow-name="xsl-region-body">
                    <fo:block break-before="page" space-after="8pt" start-indent="-10mm"
                        font-family="sans-serif" font-size="{$heading1-font-size}"
                        font-weight="bold">

                        <!-- Provide localized "Reference" heading -->
                        <xsl:call-template name="getString">
                            <xsl:with-param name="stringName" select="'References'"/>
                        </xsl:call-template>
                    </fo:block>

                    <!-- Provide localized "References intro"-->
                    <fo:block space-after="10pt" font-family="{$body-font-family}" font-size="12pt"
                        font-weight="normal">

                        <fo:inline>

                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'References-intro'"/>
                            </xsl:call-template>
                        </fo:inline>
                    </fo:block>

                    <fo:block space-before="6pt" font-family="{$body-font-family}" font-size="12pt">

                        <!-- AntennaHouse PDF bookmarks -->
                        <xsl:if test="$axf.extensions=1">
                            <xsl:call-template name="axf-bookmarks">
                                <xsl:with-param name="outline-title">

                                    <xsl:call-template name="getString">
                                        <xsl:with-param name="stringName" select="'References'"/>
                                    </xsl:call-template>

                                </xsl:with-param>
                            </xsl:call-template>
                        </xsl:if>

                        <xsl:apply-templates select="reference"/>
                    </fo:block>

                    <xsl:if test="$cover.page = '0' and $generate.index = '0'">
                        <xsl:call-template name="total-page-count"/>
                    </xsl:if>

                </fo:flow>
            </fo:page-sequence>
        </xsl:if>


        <!-- Pub-info page: copyright, trademarks -->
        <xsl:if test="$legal.page='1'">
            <fo:page-sequence master-reference="pub-info">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-family="sans-serif" font-weight="bold" font-size="12pt"
                        padding-left="0.5cm" color="black" text-align="start" space-before="12pt"
                        space-after="6pt"> Copyright &#xA9; <xsl:value-of select="$year"/>
                        <xsl:text>  </xsl:text>
                        <xsl:call-template name="getString">
                            <xsl:with-param name="stringName" select="'footer-text'"
                            /><!-- Company name -->
                        </xsl:call-template>
                    </fo:block>

                    <fo:block font-family="serif" font-weight="normal" color="black"
                        text-align="start" text-indent="0.0cm" padding-left="5mm" space-after="12pt">

                        <xsl:call-template name="getString">
                            <xsl:with-param name="stringName" select="'copyright-text'"/>
                        </xsl:call-template>

                    </fo:block>

                    <xsl:if test="//tm-item">
                        <xsl:apply-templates select="//tm-list"/>
                    </xsl:if>

                </fo:flow>
            </fo:page-sequence>
        </xsl:if>

        <!-- Process índex entries - ACTIVATE for indexing -->
        <xsl:if test="$generate.index = '1'">
            <xsl:call-template name="index-sequence"/>
        </xsl:if>

    </xsl:template>


    <xsl:template match="reference">
        <fo:list-block>
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>


    <!-- Reference items -->
    <xsl:template match="ref-item">
        <fo:list-item id="{generate-id(.)}" space-after="2mm">
            <fo:list-item-label>
                <fo:block>
                    <xsl:number/>
                </fo:block>
            </fo:list-item-label>

            <fo:list-item-body start-indent="5mm" end-indent="5mm">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="ref-item/p">

        <!--fo:inline>
      <xsl:value-of select="."/>
    </fo:inline-->

        <fo:block space-before="4pt" space-after="12pt" start-indent="5mm">
            <xsl:apply-templates/>
        </fo:block>

    </xsl:template>

    <xsl:template match="//back//doc-info">
        <fo:inline font-style="italic" font-weight="bold">
            <xsl:value-of select="title"/>
        </fo:inline>
        <fo:inline font-style="italic">
            <xsl:text> </xsl:text>
            <xsl:value-of select="subtitle"/>
        </fo:inline>
        <!--
    <fo:inline font-style="italic">
      <xsl:text> (</xsl:text>
      <xsl:value-of select="doc-no/number"/>)
    </fo:inline>
    -->

    </xsl:template>

    <!-- Glossary entries (sorted) -->
    <xsl:template match="glossary">
        <xsl:apply-templates select="def-item">
            <xsl:sort select="term"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="def-item[ancestor::glossary]">
        <fo:block id="{generate-id(.)}" space-before="12pt" keep-together.within-page="always">
            <xsl:apply-templates select="term"/>
            <xsl:apply-templates select="definition"/>
        </fo:block>
    </xsl:template>

    <!-- For term/definition templates, see list.xsl -->


    <!-- Trademark list on the legal info page -->
    <!-- ===================================== -->
    <xsl:template match="tm-list">

        <fo:block space-before="24pt" font-family="sans-serif" font-weight="bold" font-size="12pt"
            space-after="6pt">
            <xsl:call-template name="getString">
                <xsl:with-param name="stringName" select="'trademark-list'"/>
            </xsl:call-template>
        </fo:block>

        <xsl:apply-templates select="//trademark"/>

    </xsl:template>

    <xsl:template match="trademark">
        <xsl:if test="//tm-item">
            <fo:block font-family="{$body-font-family}" space-before="6pt">
                <xsl:value-of select="."/>
                <xsl:text> </xsl:text> (<xsl:apply-templates select="../owner"/>) </fo:block>
        </xsl:if>
    </xsl:template>


</xsl:stylesheet>
