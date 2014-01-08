<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0">

  <!-- Process insets (references to external sections) incl. TOC entries (3 levels) -->

  <!-- PROBLEM: relative paths to images in insets -->
  <!-- Example: the inset element looks like this: <inset xlink:href="insets/test.xml"/>. 
     The referenced document contains: <graphics xlink:href="c.png"/>. 
     Q: how construct the complete path to the graphic, e.g. file:///c:/test/insets/c.png"? -->
  <!-- * The URI module from the XSLT Standard Library (http://xsltsl.sourceforge.net)? -->
  <!-- * XInclude and xml:base attributes? -->
  <!-- * The base-uri() function in XSLT/XPath 2.0? (see meta-data-formal.xsl)? -->
  <!-- ================================================ -->

  <!-- 030216: TOC entries do not work with xsltproc: id generation error (?). OK with Saxon and Xalan -->
  <!-- 030216: absolute hrefs for the document function not working? -->
  <!-- 030703: insets work, sort of, but not when run through XFO. More testing needed -->

  <!-- Inset on level 1 -->
  <xsl:template match="//body/inset">
    <xsl:call-template name="inset-section1"/>
  </xsl:template>

  <xsl:template name="inset-section1">
    <fo:block space-after="16pt">

      <fo:block
        xsl:use-attribute-sets="section-titles"
        start-indent="-10mm"
        font-size="{$heading1-font-size}"
        id="{generate-id(.)}">

        <xsl:call-template name="inset-titles"/>

      </fo:block>
      <fo:block>
        <xsl:apply-templates select="document(@xlink:href, /)/*[not(self::title)]"/>
      </fo:block>
    </fo:block>
  </xsl:template>

  <!-- Inset on level 2 -->
  <xsl:template match="//body/section/inset">
    <xsl:call-template name="inset-section2"/>
  </xsl:template>

  <xsl:template name="inset-section2">
    <fo:block space-before="6pt">

      <fo:block
        xsl:use-attribute-sets="section-titles"
        start-indent="-3mm"
        font-size="14pt"
        id="{generate-id(.)}">

        <xsl:call-template name="inset-titles"/>

      </fo:block>
      <fo:block>
        <xsl:if test="contains(@xlink:href, '#')">
          <xsl:apply-templates select="document(@xlink:href, /)/*[not(self::title)]"/>
        </xsl:if>

        <xsl:if test="not(contains(@xlink:href, '#'))">
          <xsl:apply-templates select="document(@xlink:href, /)/section/*[not(self::title)]"/>
        </xsl:if>

        <xsl:comment> xlink:href: <xsl:value-of select="@xlink:href"/> substring-before(@xlink:href,
          '#'): <xsl:value-of select="substring-before(@xlink:href, '#')"/>
          name(document(@xlink:href, /)): <xsl:value-of select="name(document(@xlink:href, /))"/>
          name(document(@xlink:href, /)/*[1]): <xsl:value-of
            select="name(document(@xlink:href, /)/*[1])"/>
          name(document(substring-before(@xlink:href, '#'), /)/*[1]): <xsl:value-of
            select="name(document(substring-before(@xlink:href, '#'), /)/*[1])"/>
        </xsl:comment>

      </fo:block>
    </fo:block>
  </xsl:template>

  <!-- Inset on level 3 -->
  <xsl:template match="//body/section/section/inset">
    <xsl:call-template name="inset-section3"/>
  </xsl:template>

  <xsl:template name="inset-section3">
    <fo:block space-before="6pt">

      <fo:block
        xsl:use-attribute-sets="section-titles"
        start-indent="0mm"
        font-size="12pt"
        id="{generate-id(.)}">

        <xsl:call-template name="inset-titles"/>

      </fo:block>
      <fo:block>

        <xsl:apply-templates select="document(@xlink:href, /)/*[not(self::title)]"/>
      </fo:block>
    </fo:block>
  </xsl:template>


  <!-- Titles; test for numbering -->
  <xsl:template name="inset-titles">
    <fo:block>
      <xsl:if test="count(ancestor::section) + count(ancestor::inset) &gt;= 1">
        <xsl:attribute name="color">blue</xsl:attribute>
      </xsl:if>

      <xsl:if test="$section.numbering=1">
        <xsl:number level="multiple" count="section|inset" format="1.1"/>
        <fo:inline>&#xA0;&#xA0;</fo:inline>
      </xsl:if>
      <xsl:value-of select="document(@xlink:href, /)//title"/>

    </fo:block>
  </xsl:template>


  <!-- TOC entry for inset level 1 -->
  <xsl:template match="//body/inset" mode="toc">

    <fo:table-row font-weight="bold" font-size="12pt">

      <fo:table-cell>
        <fo:block>
          <xsl:if test="$section.numbering=1">
            <xsl:number level="multiple" count="section|inset" format="1.1"/>
          </xsl:if>
        </fo:block>
      </fo:table-cell>

      <fo:table-cell>
        <fo:block text-align-last="justify">
          <xsl:value-of select="document(@xlink:href, /)//title"/>
          <fo:leader leader-pattern="dots"/>
          <fo:page-number-citation ref-id="{generate-id(.)}"/>
        </fo:block>
      </fo:table-cell>

    </fo:table-row>

  </xsl:template>


  <!-- TOC entry for inset level 2 -->
  <xsl:template match="//body/section/inset" mode="toc">

    <fo:table-row font-size="10pt">

      <fo:table-cell>
        <fo:block>
          <xsl:if test="$section.numbering=1">
            <xsl:number level="multiple" count="section|inset" format="1.1"/>
          </xsl:if>
        </fo:block>
      </fo:table-cell>

      <fo:table-cell>
        <fo:block text-align-last="justify">
          <xsl:value-of select="document(@xlink:href, /)//title"/>
          <fo:leader leader-pattern="dots"/>
          <fo:page-number-citation ref-id="{generate-id(.)}"/>
        </fo:block>
      </fo:table-cell>

    </fo:table-row>

  </xsl:template>

  <!-- TOC entry for inset level 3 -->
  <xsl:template match="//body/section/section/inset" mode="toc">

    <fo:table-row font-size="10pt">

      <fo:table-cell>
        <fo:block>
          <xsl:if test="$section.numbering=1">
            <xsl:number level="multiple" count="section|inset" format="1.1"/>
          </xsl:if>
        </fo:block>
      </fo:table-cell>

      <fo:table-cell>
        <fo:block text-align-last="justify">
          <xsl:value-of select="document(@xlink:href, /)//title"/>
          <fo:leader leader-pattern="dots"/>
          <fo:page-number-citation ref-id="{generate-id(.)}"/>
        </fo:block>
      </fo:table-cell>

    </fo:table-row>

  </xsl:template>


  <!-- A block-inset is a placeholder for a block in another document -->
  <xsl:template match="block-inset">
    <fo:block>
      <xsl:apply-templates select="document(@xlink:href, /)/*"/>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>
