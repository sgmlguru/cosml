<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink"
    version="1.0">
    
    <!-- static-content.xsl -->
    <!-- For demo-specific templates, see the appropriate demo stylesheets.
         These are invoked from the demo.xsl stylesheet. -->
    
    
    <!-- Page Headers -->
    <!-- ============ -->
    
    <!-- Body Page Headers -->
    
    <xsl:template name="region-before">
        <xsl:if test="$page.headers = '1'">
            <!-- Left Page Header -->
            <fo:static-content flow-name="xsl-region-before-left">
                <xsl:call-template name="left-header"/>
            </fo:static-content>
            
            <!-- Right Page Header -->
            <fo:static-content flow-name="xsl-region-before-right">
                <xsl:call-template name="right-header"/>
            </fo:static-content>
        </xsl:if>
    </xsl:template>
    
    
    <!-- Metadata Page (Informal Docs) Headers -->
    
    <xsl:template name="meta-region-before">
        <xsl:if test="$page.headers = '1'">
            <!-- Left Page Header -->
            <fo:static-content flow-name="xsl-region-before-left">
                <xsl:call-template name="left-header"/>
            </fo:static-content>
            
            <!-- Right Page Header -->
            <fo:static-content flow-name="xsl-region-before-right">
                <xsl:call-template name="right-header"/>
            </fo:static-content>
        </xsl:if>
    </xsl:template>
    
    
    <!-- Appendix Page Headers -->
    
    <xsl:template name="region-before-appendix">
        <xsl:if test="$page.headers = '1'">
            <!-- Left Page Header -->
            <fo:static-content flow-name="xsl-region-before-left">
                <xsl:call-template name="left-header"/>
            </fo:static-content>
            
            <!-- Right Page Header -->
            <fo:static-content flow-name="xsl-region-before-right">
                <xsl:call-template name="right-header"/>
            </fo:static-content>
        </xsl:if>
    </xsl:template>
    
    
    <!-- Glossary Page Headers -->
    
    <xsl:template name="region-before-glossary">
        <xsl:if test="$page.headers = '1'">
            <!-- Left Page Header -->
            <fo:static-content flow-name="xsl-region-before-left">
                <xsl:call-template name="left-header"/>
            </fo:static-content>
            
            <!-- Right Page Header -->
            <fo:static-content flow-name="xsl-region-before-right">
                <xsl:call-template name="right-header"/>
            </fo:static-content>
        </xsl:if>
    </xsl:template>
    
    
    <!-- Reference List Page Headers -->
    
    <xsl:template name="region-before-reference">
        <xsl:if test="$page.headers = '1'">
            <!-- Left Page Header -->
            <fo:static-content flow-name="xsl-region-before-left">
                <xsl:call-template name="left-header"/>
            </fo:static-content>
            
            <!-- Right Page Header -->
            <fo:static-content flow-name="xsl-region-before-right">
                <xsl:call-template name="right-header"/>
            </fo:static-content>
        </xsl:if>
    </xsl:template>
    
    
    <!-- Index Page Headers -->
    
    <xsl:template name="region-before-index">
        <xsl:if test="$page.headers = '1'">
            <!-- Left Page Header -->
            <fo:static-content flow-name="xsl-region-before-left">
                <xsl:call-template name="left-header"/>
            </fo:static-content>
            
            <!-- Right Page Header -->
            <fo:static-content flow-name="xsl-region-before-right">
                <xsl:call-template name="right-header"/>
            </fo:static-content>
        </xsl:if>
    </xsl:template>
    
    
    
    <!-- Page Footers -->
    <!-- ============ -->
    
    <xsl:template name="region-after">
        <!-- Left Page Footer -->
        <fo:static-content flow-name="xsl-region-after-left">
            <xsl:call-template name="standard-footer"/>
        </fo:static-content>
        
        <!-- Right Page Footer -->
        <fo:static-content flow-name="xsl-region-after-right">
            <xsl:call-template name="standard-footer"/>
        </fo:static-content>
        
        <!-- Footnote Separator -->
        <xsl:call-template name="ftnote-separator"/>
    </xsl:template>
    
    
    
    <!-- Named Templates -->
    <!-- =============== -->
    
    <xsl:template name="logo-ref">
        <fo:external-graphic>
            <xsl:choose>
                <!-- Tux Demo -->
                <xsl:when test="contains($applic,'Grupp_A')">
                    <xsl:attribute name="height">20mm</xsl:attribute>
                    <xsl:attribute name="content-height">scale-to-fit</xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="concat('url(',$standard.files.dir,$tux.image,')')"/>
                    </xsl:attribute>
                </xsl:when>
                <!-- Standard COS -->
                <xsl:otherwise>
                    <xsl:attribute name="width">55mm</xsl:attribute>
                    <xsl:attribute name="content-width">scale-to-fit</xsl:attribute>
                    <xsl:attribute name="src">
                        <xsl:value-of select="concat('url(',$standard.files.dir,$logo.image,')')"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
        </fo:external-graphic>
    </xsl:template>
    
    <xsl:template name="ftnote-separator">
        <fo:static-content flow-name="xsl-footnote-separator">
            <fo:block>
                <fo:leader leader-pattern="rule"
                    leader-length="20%"
                    rule-style="solid"
                    rule-thickness="0.5pt"/>
            </fo:block>
        </fo:static-content>
    </xsl:template>
    
    <xsl:template name="left-header">
        <fo:table table-layout="fixed" font-size="9pt" font-family="{$heading-font-family}">
            <xsl:choose>
                <!-- Tux Demo -->
                <xsl:when test="contains($applic,'Grupp_A')">
                    <xsl:attribute name="border-after-style">solid</xsl:attribute>
                    <xsl:attribute name="border-after-width">1.0pt</xsl:attribute>
                </xsl:when>
                <!-- Standard COS -->
                <xsl:otherwise>
                    <!-- EMPTY -->
                </xsl:otherwise>
            </xsl:choose>            
            <fo:table-column column-width="15%" column-number="1"/>
            <fo:table-column column-width="50%" column-number="2"/>
            <fo:table-column column-width="35%" column-number="3"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell display-align="after">
                        <fo:block margin-bottom="2mm">
                            <fo:page-number/>
                            <xsl:text>(</xsl:text>
                            <fo:page-number-citation ref-id="id-last-page"/>
                            <xsl:text>)</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="end">
                            <xsl:call-template name="logo-ref"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <xsl:template name="right-header">
        <fo:table table-layout="fixed" font-size="9pt" font-family="{$heading-font-family}">
            <xsl:choose>
                <!-- Tux Demo -->
                <xsl:when test="contains($applic,'Grupp_A')">
                    <xsl:attribute name="border-after-style">solid</xsl:attribute>
                    <xsl:attribute name="border-after-width">1.0pt</xsl:attribute>
                </xsl:when>
                <!-- Standard COS -->
                <xsl:otherwise>
                    <!-- EMPTY -->
                </xsl:otherwise>
            </xsl:choose>
            <fo:table-column column-width="35%" column-number="1"/>
            <fo:table-column column-width="50%" column-number="2"/>
            <fo:table-column column-width="15%" column-number="3"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:call-template name="logo-ref"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block/>
                    </fo:table-cell>
                    <fo:table-cell display-align="after">
                        <fo:block margin-bottom="2mm">
                            <fo:page-number/>
                            <xsl:text>(</xsl:text>
                            <fo:page-number-citation ref-id="id-last-page"/>
                            <xsl:text>)</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
    <xsl:template name="standard-footer">
        <fo:table table-layout="fixed" font-size="9pt" border-before-style="solid" border-before-width="1.0pt" font-family="{$heading-font-family}">
            <fo:table-column column-width="37%" column-number="1"/>
            <fo:table-column column-width="20%" column-number="2"/>
            <fo:table-column column-width="20%" column-number="3"/>
            <fo:table-column column-width="23%" column-number="4"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="4">
                        <xsl:choose>
                            <!-- Tux Demo -->
                            <xsl:when test="contains($applic,'Grupp_A')">
<!--                                <fo:block font-weight="bold" margin-left="2mm" margin-top="1mm">The Linux Foundation</fo:block>-->
                                <fo:block></fo:block>
                            </xsl:when>
                            <!-- Standard COS -->
                            <xsl:otherwise>
                                <fo:block font-weight="bold" margin-left="2mm" margin-top="1mm">Condesign Operations Support AB</fo:block>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-size="7pt" margin-top="4pt" font-style="italic">
                    <fo:table-cell>
                        <fo:block margin-left="2mm">
                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'Address'"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'Registered Office'"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-right="2mm">
                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'Registered No'"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block>
                            <xsl:call-template name="getString">
                                <xsl:with-param name="stringName" select="'Document No'"/>
                            </xsl:call-template>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row margin-top="4pt">
                    <fo:table-cell>
                        <xsl:choose>
                            <!-- Tux Demo -->
                            <xsl:when test="contains($applic,'Grupp_A')">
                                <!--<fo:block margin-left="2mm">1796 18th Street, Suite C</fo:block>
                                <fo:block margin-left="2mm">San Francisco, CA 94107</fo:block>
                                <fo:block margin-left="2mm">USA</fo:block>
                                <fo:block margin-left="2mm">+1 415 723 9709</fo:block>-->
                                <fo:block></fo:block>
                            </xsl:when>
                            <!-- Standard COS -->
                            <xsl:otherwise>
                                <fo:block margin-left="2mm">Nya Tingstadsgatan 1</fo:block>
                                <fo:block margin-left="2mm">422 44 Hisings Backa</fo:block>
                                <fo:block margin-left="2mm">Sweden</fo:block>
                                <fo:block margin-left="2mm">+46 31 744 17 00</fo:block>
                            </xsl:otherwise>
                        </xsl:choose>                        
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:choose>
                            <!-- Tux Demo -->
                            <xsl:when test="contains($applic,'Grupp_A')">
<!--                                <fo:block>San Fransisco</fo:block>-->
                                <fo:block></fo:block>
                            </xsl:when>
                            <!-- Standard COS -->
                            <xsl:otherwise>
                                <fo:block>Göteborg</fo:block>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:table-cell>
                    <fo:table-cell>
                        <xsl:choose>
                            <!-- Tux Demo -->
                            <xsl:when test="contains($applic,'Grupp_A')">
                                <fo:block>N/A</fo:block>
                            </xsl:when>
                            <!-- Standard COS -->
                            <xsl:otherwise>
                                <fo:block>556307-1231</fo:block>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block margin-right="1mm">
                            <xsl:value-of select="//doc-info/doc-no"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    
</xsl:stylesheet>
