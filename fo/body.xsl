<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink"
    version="1.0">

    <xsl:template match="body">
        <xsl:call-template name="body-cosml"/>
    </xsl:template>

    <xsl:template name="body-cosml">
        <fo:page-sequence master-reference="contents">

            <!--<xsl:if test="$cover.page='1'">
        <!-\-xsl:attribute name="force-page-count">end-on-even</xsl:attribute-\->
        <xsl:attribute name="initial-page-number">1</xsl:attribute>
      </xsl:if>-->

            <xsl:choose>
                <xsl:when test="$cover.page='1' and //back">
                    <xsl:attribute name="initial-page-number">1</xsl:attribute>
                </xsl:when>
                <xsl:when test="$cover.page='1' and not(//back)">
                    <xsl:attribute name="initial-page-number">1</xsl:attribute>
                    <xsl:attribute name="force-page-count">odd</xsl:attribute>
                    <!-- (back cover follows, change for index handling) -->
                </xsl:when>
                <xsl:otherwise>
                    <!-- Informal template, no special pagination rules -->
                </xsl:otherwise>
            </xsl:choose>


            <xsl:call-template name="region-before"/>
            <xsl:call-template name="region-after"/>

            <fo:flow flow-name="xsl-region-body" font-family="{$body-font-family}"
                font-size="{$body-font-size}">

                <!--<fo:block
          font-family="{$body-font-family}"
          font-size="{$body-font-size}"
          id="{generate-id(.)}">
          <xsl:apply-templates/>
        </fo:block>-->

                <xsl:apply-templates/>

                <xsl:if test="not(//back) and $cover.page = '0' and $generate.index = '0'">
                    <xsl:call-template name="total-page-count"/>
                    <!-- When cover pages are activated, see back cover -->
                </xsl:if>

            </fo:flow>
        </fo:page-sequence>
    </xsl:template>


</xsl:stylesheet>
