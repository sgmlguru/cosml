<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0">

  <!-- MJ 030201: All code taken from monolith iom-fo.xsl -->
  <!-- MJ 030213: Added code for proportional column widths 
       Added entry-attributes template -->
  <!-- MJ 030419: Some small additions: border-collapse, table-layout 
       MJ 030521: Modified templates for border settings (major contributions from HA) 
       MJ 030622: Tweaked borders and more
       -->

  <!-- Ignore whitespace in table rows -->
  <xsl:strip-space elements="row"/>

  <xsl:template match="tgroup">

    <xsl:apply-templates select="table/caption"/>

    <!-- Note: XEP only supports border-collapse="separate" -->
    <!-- http://xep.xattic.com/lists/xep-support/0529.html -->
    <!-- http://www.biglist.com/lists/xsl-list/archives/200211/msg00722.html -->
    <!-- AntennaHouse supports collapsing borders -->

    <fo:table font-family="{$body-font-family}" border-collapse="collapse" space-after="12pt"
      border-color="black" border-style="solid" border-width="0.1pt">

      <!-- If there are any proportional-width columns, use "fixed" -->
      <xsl:variable name="prop-columns" select=".//colspec[contains(@colwidth, '*')]"/>
      <xsl:if test="count($prop-columns) != 0">
        <xsl:attribute name="table-layout">fixed</xsl:attribute>
      </xsl:if>

      <!-- HA 030425: handle "frame" attribute w. predefined values -->
      <xsl:if test="ancestor::table[1][@frame='top']">
        <xsl:attribute name="border-left-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
      </xsl:if>

      <xsl:if test="ancestor::table[1][@frame='bottom']">
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-left-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
      </xsl:if>

      <xsl:if test="ancestor::table[1][@frame='topbot']">
        <xsl:attribute name="border-left-style">none</xsl:attribute>
        <xsl:attribute name="border-right-style">none</xsl:attribute>
      </xsl:if>

      <xsl:if test="ancestor::table[1][@frame='all']">
        <xsl:attribute name="border-style">solid</xsl:attribute>
      </xsl:if>

      <xsl:if test="ancestor::table[1][@frame='sides']">
        <xsl:attribute name="border-top-style">none</xsl:attribute>
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
      </xsl:if>

      <xsl:if test="ancestor::table[1][@frame='none']">
        <xsl:attribute name="border-style">none</xsl:attribute>
      </xsl:if>

      <xsl:call-template name="tablegroup"/>
      <xsl:apply-templates select="thead"/>

      <xsl:if test="tfoot or .//ftnote">
        <fo:table-footer>
          <xsl:apply-templates select="tfoot"/>
          <xsl:if test=".//ftnote">
            <xsl:call-template name="ftnote-row"/>
          </xsl:if>
        </fo:table-footer>
      </xsl:if>
      
      <xsl:apply-templates select="tbody"/>
      
    </fo:table>
  </xsl:template>


  <xsl:template name="tablegroup">

    <xsl:if test="colspec">
      <xsl:for-each select="colspec">

        <!-- colwidth is in fact not required by the DTD and could be missing -->
        <xsl:choose>
          <xsl:when test="not(@colwidth)">
            <fo:table-column column-width="floor(130 div @cols)"/>
          </xsl:when>

          <xsl:otherwise>
            <xsl:choose>

              <!-- Absolute column width -->
              <xsl:when test="not(contains(@colwidth, '*'))">
                <fo:table-column column-width="{@colwidth}"/>
              </xsl:when>

              <!-- Proportional column width -->
              <xsl:otherwise>
                <xsl:variable name="colwidth">
                  <xsl:if test="@colwidth='*'">
                    <xsl:value-of select="concat('1', @colwidth)"/>
                  </xsl:if>
                  <xsl:if test="not(@colwidth='*')">
                    <xsl:value-of select="@colwidth"/>
                  </xsl:if>
                </xsl:variable>
                <fo:table-column>
                  <xsl:attribute name="column-width"> proportional-column-width(<xsl:value-of
                      select="substring-before($colwidth, '*')"/>) </xsl:attribute>
                </fo:table-column>
              </xsl:otherwise>
            </xsl:choose>

          </xsl:otherwise>
        </xsl:choose>

      </xsl:for-each>
    </xsl:if>

    <!-- Generate table-columns for tables with no colspec -->
    <xsl:if test="not(colspec)">
      <xsl:call-template name="produce-tcols">
        <xsl:with-param name="count" select="@cols"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>

  <xsl:template name="produce-tcols">

    <xsl:param name="count"/>
    <xsl:if test="$count!=0">
      <fo:table-column>
        <xsl:attribute name="column-width">
          <xsl:value-of select="floor(130 div @cols)"/>
          <xsl:text>mm</xsl:text>
        </xsl:attribute>
      </fo:table-column>
      <xsl:call-template name="produce-tcols">
        <xsl:with-param name="count" select="$count -1"/>
      </xsl:call-template>
    </xsl:if>

  </xsl:template>


  <xsl:template match="thead">
    <fo:table-header>
      <xsl:apply-templates/>
    </fo:table-header>
  </xsl:template>

  <xsl:template match="tfoot">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="tbody">
    <fo:table-body>
      <xsl:apply-templates/>
    </fo:table-body>
  </xsl:template>


  <!-- Table rows -->
  <xsl:template match="row">
    <fo:table-row keep-together.within-page="always">
      <xsl:apply-templates/>
    </fo:table-row>
  </xsl:template>

  <xsl:template match="row[parent::thead]">
    <fo:table-row keep-with-next.within-page="always">
      <xsl:apply-templates/>
    </fo:table-row>
  </xsl:template>

  <xsl:template match="thead//entry">

    <fo:table-cell xsl:use-attribute-sets="tablecell-properties">
      <xsl:call-template name="entry-attributes"/>
      <xsl:if test="ancestor::table[1][@frame='none' or @frame='bottom']">
        <xsl:call-template name="table-firstrow"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='top' or @frame='topbot']">
        <xsl:call-template name="table-firstrow-top"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='sides']">
        <xsl:call-template name="table-firstrow-sides"/>
      </xsl:if>
      <fo:block font-size="9pt" font-weight="bold" hyphenate="true">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>

  </xsl:template>

  <xsl:template match="tfoot//entry">

    <fo:table-cell xsl:use-attribute-sets="tablecell-properties">
      <xsl:call-template name="entry-attributes"/>
      <xsl:if test="ancestor::table[1][@frame='none' or @frame='top']">
        <xsl:call-template name="table-lastrow"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='bottom' or @frame='topbot']">
        <xsl:call-template name="table-lastrow-bottom"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='sides']">
        <xsl:call-template name="table-lastrow-sides"/>
      </xsl:if>
      <fo:block font-size="9pt" font-weight="bold" hyphenate="true">
        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>

  </xsl:template>


  <!-- Table cells in the first row -->
  <xsl:template match="tbody/row[1]/entry">

    <fo:table-cell xsl:use-attribute-sets="tablecell-properties">
      <xsl:call-template name="entry-attributes"/>
      <xsl:if test="ancestor::table[1][@frame='none' or @frame='bottom'] and not(ancestor::thead)">
        <xsl:call-template name="table-firstrow"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='top' or @frame='topbot'] and not(ancestor::thead)">
        <xsl:call-template name="table-firstrow-top"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='sides'] and not(ancestor::thead)">
        <xsl:call-template name="table-firstrow-sides"/>
      </xsl:if>
      <fo:block font-size="9pt" hyphenate="true">

        <!-- Preserve the height in rows with all cells empty -->
        <xsl:if test="normalize-space(.)=''">
          <fo:leader/>
        </xsl:if>

        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>

  </xsl:template>

  <!-- Cells in the in-between rows -->
  <xsl:template match="tbody/row[position() &gt; 1 and position() &lt; last()]/entry">

    <fo:table-cell xsl:use-attribute-sets="tablecell-properties">
      <xsl:call-template name="entry-attributes"/>
      <xsl:if
        test="ancestor::table[1][@frame='none' or @frame='top' or @frame='bottom' or @frame='topbot']">
        <xsl:call-template name="table-middlerow"/>
      </xsl:if>
      <fo:block font-size="9pt" hyphenate="true">

        <xsl:if test="normalize-space(.)=''">
          <fo:leader/>
        </xsl:if>

        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>

  </xsl:template>

  <!-- Cells in the last row -->
  <!-- 1. Cell is in the last row  OR -->
  <!-- 2. Cell is in a row whose "morerows" includes the last row -->
  <xsl:template
    match="tbody/row[position() = last()]/entry|tbody/row/entry[count(parent::row/following-sibling::row) = @morerows]">

    <fo:table-cell xsl:use-attribute-sets="tablecell-properties">

      <!-- The straddling cell is in the first row -->
      <xsl:if test="count(ancestor::tbody/row) = 1+@morerows">
        <xsl:attribute name="border-top-style">none</xsl:attribute>
      </xsl:if>

      <!-- The straddling cell is not in the first row -->
      <xsl:if test="count(parent::row/following-sibling::row) = @morerows">
        <xsl:attribute name="border-bottom-style">none</xsl:attribute>
      </xsl:if>

      <xsl:call-template name="entry-attributes"/>

      <xsl:if test="ancestor::table[1][@frame='none' or @frame='top'] and not(ancestor::tfoot)">
        <xsl:call-template name="table-lastrow"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='bottom' or @frame='topbot'] and not(ancestor::tfoot)">
        <xsl:call-template name="table-lastrow-bottom"/>
      </xsl:if>
      <xsl:if test="ancestor::table[1][@frame='sides'] and not(ancestor::tfoot)">
        <xsl:call-template name="table-lastrow-sides"/>
      </xsl:if>
      <fo:block font-size="9pt" hyphenate="true">

        <xsl:if test="normalize-space(.)=''">
          <fo:leader/>
        </xsl:if>

        <xsl:apply-templates/>
      </fo:block>
    </fo:table-cell>
  </xsl:template>


  <!-- Table cell attributes -->
  <!-- ===================== -->
  <xsl:template name="entry-attributes">

    <!-- 030428 HA: honour rowsep=0 and colsep=0 -->
    <xsl:if test="ancestor::tgroup[@colsep='0'] or ancestor::table[@colsep='0']">
      <xsl:attribute name="border-left-style">none</xsl:attribute>
      <xsl:attribute name="border-right-style">none</xsl:attribute>
    </xsl:if>

    <xsl:if test="ancestor::tgroup[@rowsep='0'] or ancestor::table[@rowsep='0']">
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>

    <!-- Cell spanning several columns (note: current()) -->
    <xsl:if test="@namest">
      <xsl:variable name="endcolnum" select="../../../colspec[@colname=current()/@nameend]/@colnum"/>
      <xsl:variable name="startcolnum" select="../../../colspec[@colname=current()/@namest]/@colnum"/>

      <xsl:attribute name="number-columns-spanned">
        <xsl:value-of select="1 + $endcolnum - $startcolnum"/>
      </xsl:attribute>
    </xsl:if>

    <!-- Cell straddling several rows -->
    <xsl:if test="@morerows">
      <xsl:attribute name="number-rows-spanned">
        <xsl:value-of select="1 + @morerows"/>
      </xsl:attribute>
    </xsl:if>

    <!-- Horizontal and vertical alignment -->
    <xsl:if test="not(@align)">
      <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:if>

    <xsl:if test="@align='left'">
      <xsl:attribute name="text-align">start</xsl:attribute>
    </xsl:if>

    <xsl:if test="@align='center'">
      <xsl:attribute name="text-align">center</xsl:attribute>
    </xsl:if>

    <xsl:if test="@align='right'">
      <xsl:attribute name="text-align">end</xsl:attribute>
    </xsl:if>

    <xsl:if test="not(@valign)">
      <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign='top'">
      <xsl:attribute name="display-align">before</xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign='middle'">
      <xsl:attribute name="display-align">center</xsl:attribute>
    </xsl:if>

    <xsl:if test="@valign='bottom'">
      <xsl:attribute name="display-align">after</xsl:attribute>
    </xsl:if>

  </xsl:template>

  <!-- Border attributes in table cells -->
  <!-- ================================ -->
  <!-- Note: correct value for position() in rows requires stripped whitespace. -->

  <xsl:template name="table-firstrow">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-left-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>

    <xsl:if test="position() &gt; 1 and position() &lt; last()">
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>

    <xsl:if test="position() = last()">
      <xsl:attribute name="border-right-style">none</xsl:attribute>
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template name="table-firstrow-top">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-left-style">none</xsl:attribute>
    </xsl:if>

    <xsl:if test="position() = last()">
      <xsl:attribute name="border-right-style">none</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="table-firstrow-sides">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>

    <xsl:if test="position() &gt; 1 and position() &lt; last()">
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>

    <xsl:if test="position() = last()">
      <xsl:attribute name="border-top-style">none</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="table-lastrow">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-left-style">none</xsl:attribute>
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>
    <xsl:if test="position() &gt; 1 and position() &lt; last()">
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>
    <xsl:if test="position() = last()">
      <xsl:attribute name="border-right-style">none</xsl:attribute>
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="table-lastrow-bottom">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-left-style">none</xsl:attribute>
    </xsl:if>
    <xsl:if test="position() = last()">
      <xsl:attribute name="border-right-style">none</xsl:attribute>
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>
  </xsl:template>

  <xsl:template name="table-lastrow-sides">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>
    <xsl:if test="position() &gt; 1 and position() &lt; last()">
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>
    <xsl:if test="position() = last()">
      <xsl:attribute name="border-bottom-style">none</xsl:attribute>
    </xsl:if>

  </xsl:template>

  <xsl:template name="table-middlerow">

    <xsl:if test="position() = 1">
      <xsl:attribute name="border-left-style">none</xsl:attribute>
    </xsl:if>
    <xsl:if test="position() = last()">
      <xsl:attribute name="border-right-style">none</xsl:attribute>
    </xsl:if>

  </xsl:template>


  <!-- Table cell paragraph -->
  <xsl:template match="entry/p">
    <fo:block>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

  <!-- Table caption -->
  <xsl:template match="table/caption">
    <fo:block keep-with-next.within-page="always" space-before="16pt" space-after="6pt"
      id="{generate-id(.)}">

      <fo:inline font-style="italic">
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'Table'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:choose>
          <xsl:when test="ancestor::body">
            <xsl:number count="body/section"/>
          </xsl:when>
          <xsl:when test="ancestor::back">
            <xsl:number count="back/section" format="A"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:number count="/section"/>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>-</xsl:text>
        <xsl:number count="table" level="any" from="body/section"/>
        <xsl:text>: </xsl:text>
        <xsl:apply-templates/>
      </fo:inline>
    </fo:block>
  </xsl:template>
  
  
  
  <!-- Footnotes in Tables -->
  <!-- =================== -->
  
  <xsl:template match="ftnote[ancestor::tgroup]">
    <fo:inline font-size="0.63em" baseline-shift="super">
      <xsl:number count="ftnote[ancestor::tgroup]" format="a)" from="tgroup" level="any"/>
    </fo:inline>
  </xsl:template>
  
  
  
  <!-- Table Row for Table Notes in Footer -->
  <!-- =================================== -->
  
  <xsl:template name="ftnote-row">
    <fo:table-row>
      <fo:table-cell number-columns-spanned="{@cols}">
        <fo:list-block padding-before="4pt" padding-after="2pt" margin-left="2mm" provisional-distance-between-starts="20pt" provisional-label-separation="5pt">
          <xsl:for-each select=".//ftnote">
            <fo:list-item margin-top="0.1em">
              <fo:list-item-label end-indent="label-end()">
                <fo:block  font-size="0.63em" line-height="0.9em">
                  <xsl:number level="any" count="ftnote[ancestor::tgroup]" format="a)" from="tgroup"/>
                </fo:block>
              </fo:list-item-label>
              <fo:list-item-body start-indent="body-start()">
                <fo:block  font-size="0.63em" line-height="0.9em">
                  <xsl:apply-templates/>
                </fo:block>
              </fo:list-item-body>
            </fo:list-item>
          </xsl:for-each>
        </fo:list-block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

</xsl:stylesheet>
