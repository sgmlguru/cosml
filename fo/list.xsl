<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0">

  <!-- Two level deep "lists in lists" -->

  <!-- Ordered lists -->
  <!-- ============= -->
  <xsl:template match="list[@type='ordered'][not(parent::list-item or parent::step)]">
    <fo:block
      space-before="8pt"
      space-after="8pt">
      <xsl:call-template name="list-p"/>
      <fo:list-block>
        <xsl:for-each select="list-item">
          <xsl:call-template name="ordered-list-item"/>
        </xsl:for-each>
      </fo:list-block>
    </fo:block>
  </xsl:template>

  <xsl:template name="ordered-list-item">
    <fo:list-item
      keep-together.within-page="always"
      space-before="3pt"
      space-after="3pt">
      <fo:list-item-label
        start-indent="0mm"
        end-indent="label-end()">
        <fo:block>
          <xsl:number/>
        </fo:block>
      </fo:list-item-label>
      <fo:list-item-body
        start-indent="5mm"
        end-indent="5mm">
        <fo:block>
          <xsl:choose>
            <xsl:when test="list-item/list">
              <xsl:apply-templates select="list/list-item/list"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates/>
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


  <!-- Unordered lists -->
  <!-- =============== -->
  <xsl:template
    match="list[@type='unordered'][not(parent::list-item or parent::step)] |
           list[not(@type)][not(parent::list-item or parent::step)]">
    <fo:block
      space-before="8pt"
      space-after="8pt">
      <xsl:call-template name="list-p"/>
      <fo:list-block>

        <xsl:for-each select="list-item">
          <xsl:call-template name="unordered-list-item"/>
        </xsl:for-each>
      </fo:list-block>
    </fo:block>
  </xsl:template>

  <xsl:template name="unordered-list-item">
    <fo:list-item
      keep-together.within-page="always"
      space-before="3pt"
      space-after="3pt">
      <fo:list-item-label
        start-indent="0mm"
        end-indent="label-end()">
        <fo:block> &#x2022; </fo:block>
      </fo:list-item-label>

      <fo:list-item-body
        start-indent="5mm"
        end-indent="5mm">
        <fo:block>
          <xsl:choose>
            <xsl:when test="list-item/list">
              <xsl:apply-templates select="list/list-item/list"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:apply-templates/>
            </xsl:otherwise>
          </xsl:choose>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


  <!-- First para in a list or step-list before the first list-item or step -->
  <xsl:template name="list-p">
    <fo:block
      space-after="3pt"
      keep-with-next.within-page="always">
      <xsl:apply-templates
        select="p[not(preceding-sibling::step) and not(preceding-sibling::list-item)]"/>
    </fo:block>
  </xsl:template>

  <!-- List in a list item -->
  <xsl:template match="list/list-item/list">
    <xsl:apply-templates select="p"/>
    <fo:list-block
      space-before="2pt"
      space-after="2pt">
      <xsl:apply-templates select="list-item"/>
    </fo:list-block>
  </xsl:template>

  <!-- Paragraph in a list in a list item -->
  <xsl:template match="list-item/list/p">
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- List item in an unordered list in a list -->
  <xsl:template match="list/list-item/list[@type='unordered' or not(@type)]/list-item">

    <xsl:variable name="start-indent">
      <xsl:choose>
        <xsl:when test="count(ancestor::list) + count(ancestor::step-list) &gt; 2"> 15mm </xsl:when>
        <xsl:otherwise>10mm</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fo:list-item>
      <fo:list-item-label
        start-indent="{$start-indent}"
        end-indent="label-end()">
        <fo:block> - </fo:block>
      </fo:list-item-label>
      <fo:list-item-body
        start-indent="{$start-indent} + 5mm"
        end-indent="13mm">
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


  <!-- List item in an ordered list in a list -->
  <xsl:template match="list/list-item/list[@type='ordered']/list-item">

    <xsl:variable name="start-indent">
      <xsl:choose>
        <xsl:when test="count(ancestor::list) + count(ancestor::step-list) &gt; 2"> 15mm </xsl:when>
        <xsl:otherwise>10mm</xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <fo:list-item>
      <fo:list-item-label
        start-indent="{$start-indent}"
        end-indent="12mm">
        <fo:block>
          <xsl:number format="a"/>) </fo:block>
      </fo:list-item-label>
      <fo:list-item-body
        start-indent="{$start-indent} + 5mm"
        end-indent="13mm">
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template
    match="list-item/p |
           step/p |
           list//list/list-item/p |
           step-list//list/list-item/p">
    <fo:block>
      <xsl:if test="preceding-sibling::p">
        <xsl:attribute name="space-before">1pt</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


  <!-- Step lists -->
  <!-- ========== -->
  <xsl:template match="step-list">
    <fo:block
      space-before="8pt"
      space-after="8pt">
      
      <xsl:call-template name="list-p"/>

      <xsl:apply-templates select="step | p[preceding-sibling::step] | admonishment"/>

    </fo:block>
  </xsl:template>

  <xsl:template match="step">
    <fo:list-block>
      <fo:list-item
        keep-together.within-page="auto"
        space-before="3pt"
        space-after="3pt">
        <fo:list-item-label
          start-indent="0mm"
          end-indent="label-end()">
          <fo:block>
            <xsl:number/>
          </fo:block>
        </fo:list-item-label>

        <fo:list-item-body
          start-indent="6mm"
          end-indent="10mm">
          <fo:block>
            <xsl:choose>
              <xsl:when test="list">
                <xsl:apply-templates select="list"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates/>
              </xsl:otherwise>
            </xsl:choose>
          </fo:block>
        </fo:list-item-body>
      </fo:list-item>
    </fo:list-block>
  </xsl:template>

  <!-- A list in a step -->
  <xsl:template match="step-list/step/list">
    <xsl:apply-templates select="p"/>
    <fo:list-block
      space-before="2pt"
      space-after="2pt">
      <xsl:apply-templates select="list-item"/>
    </fo:list-block>
  </xsl:template>


  <!-- List item in a list in a step -->
  <xsl:template match="step-list/step/list[@type='unordered' or not(@type)]/list-item">
    <fo:list-item>
      <fo:list-item-label
        start-indent="10mm"
        end-indent="label-end()">
        <fo:block> &#x2022; </fo:block>
      </fo:list-item-label>
      <fo:list-item-body
        start-indent="15mm"
        end-indent="13mm">
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>

  <xsl:template match="step-list/step/list[@type='ordered']/list-item">
    <fo:list-item>
      <fo:list-item-label
        start-indent="10mm"
        end-indent="12mm">
        <fo:block>
          <xsl:number format="a"/>) </fo:block>
      </fo:list-item-label>
      <fo:list-item-body
        start-indent="15mm"
        end-indent="13mm">
        <fo:block>
          <xsl:apply-templates/>
        </fo:block>
      </fo:list-item-body>
    </fo:list-item>
  </xsl:template>


  <!-- Definition lists -->
  <!-- ================ -->
  <xsl:template match="def-list">
    <fo:block
      space-before="8pt"
      space-after="8pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="def-item">
    <fo:block
      keep-together.within-page="always"
      space-before="6pt">
      <xsl:apply-templates select="term"/>
      <xsl:apply-templates select="definition"/>
    </fo:block>
  </xsl:template>

  <xsl:template match="definition">
    <fo:block space-before="3pt">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="def-item/term">
    <fo:block font-style="italic">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <xsl:template match="definition/p">
    <fo:block start-indent="2em">
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>


</xsl:stylesheet>
