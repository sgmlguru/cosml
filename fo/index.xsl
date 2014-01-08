<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0">



  <!-- Inline Index Term Handling -->

  <xsl:template match="index[@class='startofrange']" priority="75">
    <xsl:choose>
      <xsl:when test="$generate.index = '1'">
        <fo:index-range-begin id="{@id}">
          <xsl:attribute name="index-key">
            <xsl:value-of select="normalize-space(primary)"/>
            <xsl:text>;</xsl:text>
            <xsl:value-of select="normalize-space(secondary)"/>
            <xsl:text>;</xsl:text>
            <xsl:value-of select="normalize-space(tertiary)"/>
          </xsl:attribute>
        </fo:index-range-begin>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="primary" mode="noindex"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="index[@class='endofrange']" priority="75">
    <xsl:choose>
      <xsl:when test="$generate.index = '1'">
        <fo:index-range-end ref-id="{@startref}"> </fo:index-range-end>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="primary" mode="noindex"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="index">
    <xsl:choose>
      <xsl:when test="$generate.index = '1'">
        <fo:wrapper id="{generate-id(.)}">
          <xsl:attribute name="index-key">
            <xsl:value-of select="normalize-space(primary)"/>
            <xsl:text>;</xsl:text>
            <xsl:value-of select="normalize-space(secondary)"/>
            <xsl:text>;</xsl:text>
            <xsl:value-of select="normalize-space(tertiary)"/>
          </xsl:attribute>
        </fo:wrapper>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="primary" mode="noindex"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>

  <!-- Index element contents handling while indexing is disabled -->
  <!--<xsl:template match="index">
    <xsl:apply-templates/>
  </xsl:template>-->

  <xsl:template match="primary" mode="noindex">
    <!-- Primary should produce no content while indexing is disabled.-->
  </xsl:template>


  <!-- Index, keyed on first letter and on primary/secondary/tertiary 
    concatenation -->

  <xsl:key name="index-letter" match="//index"
    use="translate(substring(normalize-space(primary),1,1),'abcdefghijklmnopqrstuvwxyzåäö','ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ')"/>
  <xsl:key name="index-sorted" match="//index" use="concat(normalize-space(primary),';',normalize-space(secondary),';', normalize-space(tertiary))"/>


  <xsl:template name="index-sequence">
    <fo:page-sequence master-reference="index" id="index">

      <xsl:call-template name="region-before-index"/>
      <xsl:call-template name="region-after"/>

      <fo:flow flow-name="xsl-region-body">
        <fo:block space-after="8pt" font-size="{$heading1-font-size}" font-weight="bold"
          start-indent="-10mm">

          <xsl:call-template name="getString">
            <xsl:with-param name="stringName" select="'Index'"/>
          </xsl:call-template>

        </fo:block>

        <fo:block>

          <!-- Index begins here... -->

          <xsl:for-each
            select="//index[count(.|key('index-letter',translate(substring(normalize-space(primary),1,1),'abcdefghijklmnopqrstuvwxyzåäö','ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ'))[1]) = 1]">
            <xsl:sort select="normalize-space(primary)"/>

            <!-- Output first-letter headings... -->

            <xsl:variable name="first"
              select="translate(substring(normalize-space(primary),1,1),'abcdefghijklmnopqrstuvwxyzåäö','ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ')"/>
            <fo:block font-weight="bold" padding-before="3pt" keep-with-next.within-page="always">
              <xsl:value-of select="$first"/>
            </fo:block>

            <!-- Output each term beginning with that letter -->

            <xsl:for-each
              select="//index[count(.|key('index-sorted',concat(normalize-space(primary),';',normalize-space(secondary),';', normalize-space(tertiary)))[1]) = 1]">
              <xsl:sort
                select="translate(concat(normalize-space(primary),';',normalize-space(secondary),';',normalize-space(tertiary)),'abcdefghijklmnopqrstuvwxyzåäö','ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ')"/>
              <xsl:variable name="beg">
                <xsl:value-of
                  select="substring(translate(concat(normalize-space(primary),';',normalize-space(secondary),';',normalize-space(tertiary)),'abcdefghijklmnopqrstuvwxyzåäö','ABCDEFGHIJKLMNOPQRSTUVWXYZÅÄÖ'),1,1)"
                />
              </xsl:variable>
              <!--              <xsl:value-of select="$beg"/>-->
              <xsl:if test="$beg = $first">

                <!-- One-level index -->
                <xsl:if test="not(secondary)">
                  <fo:block start-indent="2mm" text-align-last="justify">
                    <xsl:value-of select="normalize-space(primary)"/>
                    <xsl:text>&#xA0;</xsl:text>
                    <xsl:if test="not(see)">
                      <fo:leader leader-pattern="dots"/>
                      <xsl:call-template name="page-numbers">
                        <xsl:with-param name="index-key">
                          <xsl:value-of select="concat(normalize-space(primary),';',normalize-space(secondary),';', normalize-space(tertiary))"/>
                        </xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </fo:block>
                  <xsl:if test="see">
                    <fo:block start-indent="4mm">
                      <xsl:call-template name="see"/>
                    </fo:block>
                  </xsl:if>
                  <xsl:if test="see-also">
                    <fo:block start-indent="4mm">
                      <xsl:call-template name="see-also"/>
                    </fo:block>
                  </xsl:if>
                </xsl:if>

                <!-- Two-level index -->
                <xsl:if test="primary and secondary and not(tertiary)">
                  <fo:block start-indent="4mm" padding-end="2mm" text-align-last="justify">
                    <xsl:value-of select="normalize-space(secondary)"/>
                    <xsl:text>&#xA0;</xsl:text>
                    <xsl:if test="not(see)">
                      <fo:leader leader-pattern="dots"/>
                      <xsl:call-template name="page-numbers">
                        <xsl:with-param name="index-key">
                          <xsl:value-of select="concat(normalize-space(primary),';',normalize-space(secondary),';', normalize-space(tertiary))"/>
                        </xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </fo:block>
                  <xsl:if test="see">
                    <fo:block start-indent="6mm">
                      <xsl:call-template name="see"/>
                    </fo:block>
                  </xsl:if>
                  <xsl:if test="see-also">
                    <fo:block start-indent="6mm">
                      <xsl:call-template name="see-also"/>
                    </fo:block>
                  </xsl:if>
                </xsl:if>

                <!-- Three-level index -->
                <xsl:if test="primary and secondary and tertiary">
                  <fo:block start-indent="6mm" padding-end="4mm" text-align-last="justify">
                    <xsl:value-of select="normalize-space(tertiary)"/>
                    <xsl:text>&#xA0;</xsl:text>
                    <xsl:if test="not(see)">
                      <fo:leader leader-pattern="dots"/>
                      <xsl:call-template name="page-numbers">
                        <xsl:with-param name="index-key">
                          <xsl:value-of select="concat(normalize-space(primary),';',normalize-space(secondary),';', normalize-space(tertiary))"/>
                        </xsl:with-param>
                      </xsl:call-template>
                    </xsl:if>
                  </fo:block>
                  <xsl:if test="see">
                    <fo:block start-indent="8mm">
                      <xsl:call-template name="see"/>
                    </fo:block>
                  </xsl:if>
                  <xsl:if test="see-also">
                    <fo:block start-indent="8mm">
                      <xsl:call-template name="see-also"/>
                    </fo:block>
                  </xsl:if>
                </xsl:if>
              </xsl:if>
            </xsl:for-each>
          </xsl:for-each>

        </fo:block>

        <!-- Total page count (without index, see back.xsl) -->
        <xsl:if test="$cover.page = '0'">
          <xsl:call-template name="total-page-count"/>
        </xsl:if>

      </fo:flow>
    </fo:page-sequence>
  </xsl:template>


  <xsl:template name="page-numbers">
    <xsl:param name="index-key"/>
    <fo:inline>
      <fo:index-page-citation-list>
        <fo:index-page-citation-list-separator>,&#x20;</fo:index-page-citation-list-separator>
        <fo:index-key-reference>
          <xsl:attribute name="ref-index-key">
            <xsl:value-of select="$index-key"/>
          </xsl:attribute>
        </fo:index-key-reference>
      </fo:index-page-citation-list>
    </fo:inline>
  </xsl:template>

  <xsl:template name="see-also">
    <fo:inline>
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'See also'"/>
        <xsl:with-param name="lang-context-node" select="ancestor::*[last()]"/>
      </xsl:call-template>
      <xsl:text>&#xA0;</xsl:text>
    </fo:inline>
    <xsl:for-each select="see-also">
      <fo:inline font-style="italic">
        <xsl:value-of select="."/>
        <xsl:if test="position() != last()">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </fo:inline>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="see">
    <fo:inline>
      <xsl:call-template name="getString">
        <xsl:with-param name="stringName" select="'See'"/>
        <xsl:with-param name="lang-context-node" select="ancestor::*[last()]"/>
      </xsl:call-template>
      <xsl:text>&#xA0;</xsl:text>
    </fo:inline>
    <fo:inline font-style="italic">
      <xsl:value-of select="normalize-space(see)"/>
    </fo:inline>
  </xsl:template>






  <!-- Warn about missing index-terms -->
  <xsl:template name="missing-terms">
    <fo:block space-after="4mm"/>
    <xsl:for-each select="//index[not(primary) and not(see)]">
      <fo:block color="red">
        <xsl:text>No index-term defined for </xsl:text>
        <fo:inline font-weight="bold">
          <xsl:value-of select="."/>
        </fo:inline>
        <xsl:text> on page </xsl:text>
        <fo:page-number-citation ref-id="{generate-id(.)}"/>
      </fo:block>
    </xsl:for-each>
  </xsl:template>


</xsl:stylesheet>
