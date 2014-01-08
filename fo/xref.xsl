<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  version="1.0">

  <!-- 030214: added localization stuff -->
  <!-- 030218: modified xrefs to reference items -->
  <!-- 030607: removed all uses of the id() function -->
  <!-- 030627: added code for xrefs when section.numbering!=1 -->
  
  
  
  <!-- Explicit xref wrapper handling -->
  
  <xsl:template match="xref">
    <fo:inline>
      <xsl:apply-templates/>
    </fo:inline>
  </xsl:template>
  
  <xsl:key name="id-nodes" match="*" use="@id"/>
  
  
  
  <!-- Inline xrefs -->
  
  <xsl:template match="locator">
    
    <!-- Find out target ID value -->
    <xsl:variable name="idref-value">
      <xsl:choose>
        <xsl:when test="contains(@xlink:href,'#')">
          <xsl:value-of select="substring-after(@xlink:href, '#')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@xlink:href"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <!-- Find out target element type -->
    <xsl:variable name="idref-type">
      <xsl:choose>
        <xsl:when test="local-name(key('id-nodes',$idref-value)) = 'section'">
          <xsl:choose>
            <xsl:when test="/cos/back//*[@id = $idref-value]">
              <xsl:value-of select="'appendix'"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="'section'"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="local-name(key('id-nodes', $idref-value))"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    
    <!-- Create the xref string itself -->
    <xsl:choose>
      
      <!-- Xref to a section -->
      <!-- ================= -->
      <xsl:when test="$idref-type='section'">
                
        <xsl:if test="$section.numbering=1">
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="sect-numbering"/>
            <xsl:text>, </xsl:text>
          </fo:inline>
        </xsl:if>
        
        <xsl:if test="$section.numbering!=1">
          <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="no-numbering"/>
        </xsl:if>
  
        <fo:inline font-weight="bold">
          <xsl:value-of select="//*[@id = $idref-value]/title"/>
        </fo:inline>
            
        <xsl:text>, </xsl:text>
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'page'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        
        <fo:page-number-citation ref-id="{generate-id(key('id-nodes', $idref-value)/title)}"/>
      </xsl:when>
      
      
      <!-- Xref to an appendix -->
      <!-- =================== -->
      <xsl:when test="$idref-type='appendix'">
        
        <xsl:if test="$section.numbering=1">
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="app-numbering"/>
            <xsl:text>, </xsl:text>
          </fo:inline>
        </xsl:if>
        
        <xsl:if test="$section.numbering!=1">
          <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="no-numbering"/>
        </xsl:if>
        
        <fo:inline font-weight="bold">
          <xsl:value-of select="//*[@id = $idref-value]/title"/>
        </fo:inline>
        
        <xsl:text>, </xsl:text>
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'page'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        
        <fo:page-number-citation ref-id="{generate-id(key('id-nodes', $idref-value)/title)}"/>
      </xsl:when>
  
  
      <!-- Xref to a figure -->
      <!-- ================ -->
      <xsl:when test="$idref-type='figure'">
        <fo:inline font-style="italic">
          
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="fig-numbering"/>
            <xsl:text>, </xsl:text>
          </fo:inline>

<!--          <xsl:value-of select="//*[@id = $idref-value]/caption"/>-->
        </fo:inline>
          <!--xsl:text>, </xsl:text-->
  
          <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'page'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        
        <fo:page-number-citation ref-id="{generate-id(//*[@id=$idref-value])}"/>
      </xsl:when>
  
  
      <!-- Xref to an example -->
      <!-- ================== -->
      <xsl:when test="$idref-type='example'">
        <fo:inline font-style="italic">
  
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="ex-numbering"/>
            <xsl:text>, </xsl:text>
          </fo:inline>
  
<!--          <xsl:value-of select="//*[@id = $idref-value]/caption"/>-->
          <!--<xsl:text>, </xsl:text-->
  
        </fo:inline>
  
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'page'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
  
        <fo:page-number-citation ref-id="{generate-id(//*[@id=$idref-value])}"/>
      </xsl:when>
  
  
      <!-- Xref to a table -->
      <!-- =============== -->
      <xsl:when test="$idref-type='table'">
        <fo:inline font-style="italic">
          
          <fo:inline font-weight="bold">
            <xsl:apply-templates select="key('id-nodes', $idref-value)" mode="table-numbering"/>          <xsl:text>, </xsl:text>
          </fo:inline>
          
<!--          <xsl:value-of select="//*[@id = $idref-value]/caption"/>-->
          
        </fo:inline>
          <!--xsl:text>, </xsl:text-->
        <xsl:call-template name="getString">
          <xsl:with-param name="stringName" select="'page'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        
        <fo:page-number-citation ref-id="{generate-id(//*[@id=$idref-value]/caption)}"/>
      </xsl:when>
  
  
      <!-- Xref to a reference item -->
      <!-- ======================== -->
      <!-- Modified to point to "reference [1]" etc -->
      <xsl:when test="$idref-type='ref-item'">
        
        <fo:inline font-style="italic" font-weight="bold">
           <xsl:apply-templates select="//*[@id=$idref-value]" mode="ref-numbering"/>
           <xsl:text> </xsl:text>
         </fo:inline>     
         <fo:inline font-style="italic">
           <xsl:value-of select="//*[@id = $idref-value]//title"/>
         </fo:inline>
       
      </xsl:when>
      
    </xsl:choose>
    
  </xsl:template>
  
  
  
  <!-- Footnote References in Text -->
  <!-- =========================== -->
  
  <xsl:template match="ftnoteref[not(ancestor::table)]">
    <!-- Find out target ID value -->
    <xsl:variable name="idref-value">
      <xsl:choose>
        <xsl:when test="contains(@xlink:href,'#')">
          <xsl:value-of select="substring-after(@xlink:href, '#')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@xlink:href"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <fo:inline font-size="0.63em" baseline-shift="super">
      <xsl:apply-templates select="//*[@id = $idref-value]" mode="ftnote-numbering"/>
    </fo:inline>
    <xsl:if test="normalize-space(.) != ''">
      <fo:inline font-size="0.63em" baseline-shift="super" keep-with-previous.within-line="always" keep-together.within-line="always">
        <!-- If the ftnote ref has inline text, include it -->
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
      </fo:inline>
    </xsl:if>
  </xsl:template>
  
  
  <!-- Footnote References Within Tables-->
  <xsl:template match="ftnoteref[ancestor::tgroup]">
    <!-- Find out target ID value -->
    <xsl:variable name="idref-value">
      <xsl:choose>
        <xsl:when test="contains(@xlink:href,'#')">
          <xsl:value-of select="substring-after(@xlink:href, '#')"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@xlink:href"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <fo:inline font-size="0.63em" baseline-shift="super">
      <xsl:apply-templates select="//*[@id = $idref-value]" mode="tnote-numbering"/>
    </fo:inline>
    <xsl:if test="normalize-space(//*[@id = $idref-value]) != ''">
      <fo:inline font-size="0.63em" baseline-shift="super" keep-with-previous.within-line="always" keep-together.within-line="always">
        <!-- If the ftnote ref has inline text, include it -->
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:text> </xsl:text>
      </fo:inline>
    </xsl:if>
  </xsl:template>
  
  
  
  <!-- Get gentext + number of the referenced node -->
  <!-- =========================================== -->
  
  <!-- Section -->
  <xsl:template match="*" mode="sect-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Section'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:number
      level="multiple"
      format="1.1"
      count="section"
      from="body"/> <!-- count added för xsltproc -->
  </xsl:template>
  
  
  <!-- Appendix -->
  <xsl:template match="*" mode="app-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Appendix'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:number
      level="multiple"
      format="A.1"
      count="section"
      from="back"/> <!-- count added för xsltproc -->
  </xsl:template>
  
  
  
  <!-- Unnumbered Section -->
  <xsl:template match="*" mode="no-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'Section-no-number'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
  </xsl:template>
  
 
  <!-- Figure -->
  <xsl:template match="*" mode="fig-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'figure'"/>
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
    <xsl:number
      count="figure"
      level="any"
      from="body/section"/>
  </xsl:template>
  
  
  <!-- Example -->
  <xsl:template match="*" mode="ex-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'example'"/>
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
    <xsl:number
      count="example"
      level="any"
      from="body/section"/>
  </xsl:template>
  
  
  <!-- Table -->
  <xsl:template match="*" mode="table-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'table'"/>
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
    <xsl:number
      count="table"
      level="any"
      from="body/section"/>
  </xsl:template>
  
  
  <!-- Ref-item -->
  <xsl:template match="*" mode="ref-numbering">
    <xsl:call-template name="getString">
      <xsl:with-param name="stringName" select="'ref-doc'"/>
    </xsl:call-template>
    <xsl:text> [</xsl:text>
    <xsl:number count="ref-item"/> 
    <xsl:text>]</xsl:text>
  </xsl:template>
  
  
  <!-- Footnote -->
  <xsl:template match="*" mode="ftnote-numbering">
    <xsl:number level="any" count="ftnote[not(ancestor::table)]" format="[1]" from="body|back"/>
  </xsl:template>
  
  
  <!-- Table Note -->
  <xsl:template match="*" mode="tnote-numbering">
    <xsl:number level="any" count="ftnote[ancestor::tgroup]" format="a)" from="tgroup"/>
  </xsl:template>


</xsl:stylesheet>
