<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0">

  <xsl:template match="emph">
    <fo:inline font-style="italic">
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="code|uri|file-path|lit">
    <fo:inline font-family="Courier" font-size="11pt">
<!--      <xsl:value-of select="."/>-->
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="gui">
    <fo:inline font-family="sans-serif">
<!--      <xsl:value-of select="."/>-->
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="quote">
    <fo:inline>
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'startquote'"/>
      </xsl:call-template>

<!--      <xsl:value-of select="."/>-->
      <xsl:apply-templates/>

      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'endquote'"/>
      </xsl:call-template>
    </fo:inline>
  </xsl:template>

<!--  <xsl:template match="index">
    <fo:wrapper
      xmlns:rx="http://www.renderx.com/XSL/Extensions"
      id="{generate-id(.)}"
      rx:key="{@index-term}">
      <xsl:apply-templates/>
    </fo:wrapper>
  </xsl:template>

  INDEX handling moved to index.xsl for DocBook index model.

-->

  <xsl:template match="hlink">
<!--    <xsl:value-of select="."/>-->
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="subs">
    <fo:inline font-size="70%" vertical-align="sub" line-height="0pt">
<!--      <xsl:value-of select="."/>-->
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="sups">
    <fo:inline font-size="70%" vertical-align="super" line-height="0pt">
<!--      <xsl:value-of select="."/>-->
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <xsl:template match="keystroke">
    <fo:inline font-family="sans-serif" font-weight="bold">
<!--      <xsl:value-of select="."/>-->
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>

  <!-- Glossary terms -->
  <xsl:template match="gl-term">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Footnotes -->
  <xsl:template match="ftnote[not(ancestor::tgroup)]">
    <fo:footnote>
      <fo:inline font-size="0.63em" baseline-shift="super">
        <xsl:number level="any" count="ftnote[not(ancestor::tgroup)]" format="[1]" from="body|back"/>
      </fo:inline>
      <fo:footnote-body>
        <fo:list-block provisional-distance-between-starts="20pt" provisional-label-separation="5pt">
          <xsl:if test="ancestor::note or ancestor::list or ancestor::step-list or ancestor::step-list">
            <xsl:attribute name="start-indent">0mm</xsl:attribute>
          </xsl:if>
          <fo:list-item margin-top="0.1em">
            <fo:list-item-label end-indent="label-end()">
              <fo:block  font-size="0.83em" line-height="0.9em">
                <xsl:number level="any" count="ftnote[not(ancestor::tgroup)]" format="[1]" from="body|back"/>
              </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
              <fo:block  font-size="0.83em" line-height="0.9em">
                <xsl:apply-templates/>
              </fo:block>
            </fo:list-item-body>
          </fo:list-item>
        </fo:list-block>
      </fo:footnote-body>
    </fo:footnote>
  </xsl:template>

  <!-- TEST: insert a zero width space after every forward slash -->
  <xsl:template match="text()">
    <xsl:call-template name="replace-string">
      <xsl:with-param name="text" select="."/>
      <xsl:with-param name="from" select="'/'"/>
      <xsl:with-param name="to" select="'/&#x200B;'"/>
    </xsl:call-template>
  </xsl:template>

  <!-- Reusable replace-string function -->
  <!-- http://aspn.activestate.com/ASPN/Cookbook/XSLT/Recipe/65426 -->
  <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="from"/>
    <xsl:param name="to"/>

    <xsl:choose>
      <xsl:when test="contains($text, $from)">

        <xsl:variable name="before" select="substring-before($text, $from)"/>
        <xsl:variable name="after" select="substring-after($text, $from)"/>

        <xsl:value-of select="$before"/>
        <xsl:value-of select="$to"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="$after"/>
          <xsl:with-param name="from" select="$from"/>
          <xsl:with-param name="to" select="$to"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
