<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:svg="http://www.w3.org/2000/svg" 
    version="2.0" 
    exclude-result-prefixes="svg">

    
    <!-- Block-level element handling -->
    


    <xsl:template
        match="p[not(parent::list or 
        parent::step or 
        parent::list-item or 
        parent::entry or 
        parent::definition or 
        parent::ref-item or 
        parent::admonishment or 
        parent::note or 
        parent::section/@xml:lang='he' or 
        parent::abstract)]">
        <fo:block 
            font-family="{$body-font-family}" 
            space-before="7pt" 
            space-after="7pt"
            line-height-shift-adjustment="disregard-shifts">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="p[parent::abstract]">
        <fo:block 
            font-family="sans-serif" 
            space-before="7pt" 
            space-after="7pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>


    <!-- Test: Hebrew -->
    <xsl:template match="p[parent::section/@xml:lang='he']">
        <fo:block 
            font-family="Tahoma" 
            direction="rtl" 
            space-before="7pt" 
            space-after="7pt">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>


    <!-- Notes -->
    <!-- ===== -->
    <xsl:template match="note">
        <fo:block xsl:use-attribute-sets="indented-block-properties">

            <fo:inline font-family="sans-serif" font-weight="bold">

                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Note'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>

            </fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>


    <xsl:template match="note[parent::list-item or parent::step]">
        <fo:block>
            <xsl:attribute name="space-before">4pt</xsl:attribute>
            <xsl:attribute name="space-after">4pt</xsl:attribute>

            <fo:inline font-family="sans-serif" font-weight="bold">

                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Note'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>

            </fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>


    <!-- Admonishments -->
    <!-- ============= -->
    <xsl:template match="admonishment[@type='caution']">
        <fo:block xsl:use-attribute-sets="indented-block-properties">

            <fo:inline font-family="sans-serif" font-weight="bold">
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Caution'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
            </fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="admonishment[@type='warning']">
        <fo:block xsl:use-attribute-sets="indented-block-properties">

            <fo:inline font-family="sans-serif" font-weight="bold">
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Warning'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
            </fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="admonishment[@type='danger']">
        <fo:block xsl:use-attribute-sets="indented-block-properties">

            <fo:inline font-family="sans-serif" font-weight="bold" color="red">
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Danger'"/>
                </xsl:call-template>
                <xsl:text> </xsl:text>
            </fo:inline>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="admonishment">
        <fo:block xsl:use-attribute-sets="indented-block-properties">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- First para is inline -->
    <xsl:template match="note/p[1]|admonishment/p[1]">
        <fo:inline>
            <xsl:apply-templates/>
        </fo:inline>
    </xsl:template>

    <xsl:template match="note/p[position()>1]|admonishment/p[position()>1]">
        <fo:block>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>


    <xsl:template match="code-block">
        <fo:block 
            xsl:use-attribute-sets="indented-block-properties" 
            font-family="Courier"
            font-size="7pt" 
            white-space="pre" 
            wrap-option="wrap" 
            linefeed-treatment="preserve"
            white-space-collapse="false">
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <!-- Remove leading and trailing whitespace in code-blocks -->
    <!-- Adapted from http://sources.redhat.com/ml/docbook-apps/2003-q2/msg00334.html -->
    <xsl:template match="code-block/text()">

        <xsl:variable name="conts" select="."/>

        <xsl:variable name="contsl">
            <xsl:choose>
                <!-- If it is the first node, remove any leading whitespace -->
                <xsl:when test="position() = 1">
                    <xsl:call-template name="remove-ws-left">
                        <xsl:with-param name="astr" select="$conts"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$conts"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:variable name="contslr">
            <xsl:choose>
                <!-- If it is the last node, remove any trailing whitespace -->
                <xsl:when test="position() = last()">
                    <xsl:call-template name="remove-ws-right">
                        <xsl:with-param name="astr" select="$contsl"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$contsl"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <xsl:value-of select="$contslr"/>

    </xsl:template>

    <!-- eat whitespace from the left -->
    <xsl:template name="remove-ws-left">
        <xsl:param name="astr"/>

        <xsl:choose>
            <!-- LINE FEED, CARRIAGE RETURN, SPACE, TAB -->
            <xsl:when
                test="starts-with($astr,'&#xA;') or
              starts-with($astr,'&#xD;') or 
              starts-with($astr,'&#x20;') or
              starts-with($astr,'&#x9;')">
                <xsl:call-template name="remove-ws-left">
                    <xsl:with-param name="astr" select="substring($astr, 2)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$astr"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- eat whitespace from the right -->
    <xsl:template name="remove-ws-right">
        <xsl:param name="astr"/>

        <xsl:variable name="last-char">
            <xsl:value-of select="substring($astr, string-length($astr), 1)"/>
        </xsl:variable>

        <xsl:choose>
            <xsl:when
                test="($last-char = '&#xA;') or
              ($last-char = '&#xD;') or
              ($last-char = '&#x20;') or
              ($last-char = '&#x9;')">
                <xsl:call-template name="remove-ws-right">
                    <xsl:with-param name="astr"
                        select="substring($astr, 1, string-length($astr) - 1)"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$astr"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <!-- Examples -->
    <!-- ======== -->
    <xsl:template match="example">
        <fo:block 
            space-before="12pt" 
            space-after="20pt" 
            id="{generate-id(.)}">

            <xsl:apply-templates select="caption"/>

            <fo:block 
                border-before-style="solid" 
                border-after-style="solid"
                border-before-width="0.3pt" 
                border-after-width="0.3pt">

                <xsl:apply-templates select="*[not(self::caption)]"/>
            </fo:block>

        </fo:block>
    </xsl:template>

    <xsl:template match="caption[parent::example]">
        <fo:block 
            space-before="10pt" 
            space-after="4pt" 
            keep-with-next.within-page="always">
            <fo:inline font-style="italic">
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Example'"/>
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
                <xsl:number count="example" level="any" from="body/section"/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </fo:inline>
        </fo:block>

    </xsl:template>



    <!-- Figures -->
    <!-- ======= -->
    <xsl:template match="figure">
        <fo:block id="{generate-id(.)}">
            <xsl:if test="parent::step and preceding-sibling::*">
                <xsl:attribute name="keep-with-previous">always</xsl:attribute>
            </xsl:if>
            <xsl:if test="@role = 'span'">
                <xsl:attribute name="span">all</xsl:attribute>
            </xsl:if>
            <xsl:if test="not(parent::figure)">
                <xsl:attribute name="space-before">12pt</xsl:attribute>
                <xsl:attribute name="space-after">12pt</xsl:attribute>
            </xsl:if>
            <xsl:if test="parent::figure">
                <xsl:attribute name="space-before">6pt</xsl:attribute>
            </xsl:if>
            <xsl:if test="local-name(following-sibling::*[1]) = 'caption'">
                <xsl:attribute name="keep-with-next.within-page">always</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </fo:block>
    </xsl:template>

    <xsl:template match="graphics">

        <xsl:choose>
            <xsl:when test="ancestor::p">
                <fo:inline>
                    <xsl:call-template name="external-image"/>
                </fo:inline>
            </xsl:when>
            <xsl:otherwise>
                <fo:block>
                    <xsl:call-template name="external-image"/>
                </fo:block>
            </xsl:otherwise>
        </xsl:choose>

    </xsl:template>

    <xsl:template name="external-image">
        <!-- This is actually not required by XSL Rec (see XepOp.java) -->
        <xsl:variable name="start">url(&apos;</xsl:variable>
        <xsl:variable name="end">&apos;)</xsl:variable>
        <fo:external-graphic scaling="uniform" overflow="hidden">

            <xsl:choose>
                <xsl:when test="@width != '' and @height != '' and ancestor::figure/@role = 'span'">
                    <xsl:if test="$paper.type = 'A4'">
                        <xsl:attribute name="content-width">180mm</xsl:attribute>
                    </xsl:if>
                    <xsl:if test="$paper.type = 'A5'">
                        <xsl:attribute name="content-width">133mm</xsl:attribute>
                    </xsl:if>
                </xsl:when>

                <xsl:when test="@width != '' and @height != '' and not(../*/@role)">
                    <xsl:choose>

                        <!-- Inline -->
                        <xsl:when test="ancestor::p">
                            <xsl:attribute name="content-height">
                                <xsl:value-of select="concat('12','pt')"/>
                            </xsl:attribute>
                        </xsl:when>

                        <!-- Block level and @height > @width, not in procedure -->
                        <xsl:when test="(@height &gt; @width) and not(ancestor::step)">
                            <xsl:attribute name="content-height">
                                <xsl:choose>
                                    <xsl:when test="@height &gt; '250' and /*/@role = '2-col'">
                                        <xsl:value-of select="concat('250','px')"/>
                                    </xsl:when>
                                    <!--@height &gt; '300' and (/*/@role != '2-col' or not(/*/@role))-->
                                    <xsl:when
                                        test="@height &gt; '220' and (/*/@role != '2-col' or not(/*/@role))">
                                        <xsl:value-of select="concat('220','px')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(@height,'px')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:when>

                        <!-- Block level and @width > @height, not in procedure -->
                        <xsl:when test="(@height &lt; @width) and not(ancestor::step)">
                            <xsl:attribute name="content-width">
                                <xsl:choose>
                                    <xsl:when test="@width &gt; '250' and /*/@role = '2-col'">
                                        <xsl:value-of select="concat('250','px')"/>
                                    </xsl:when>
                                    <!-- @width &gt; '350' and (/*/@role != '2-col' or not(/*/@role)) -->
                                    <xsl:when
                                        test="@width &gt; '350' and (/*/@role != '2-col' or not(/*/@role))">
                                        <xsl:value-of select="concat('350','px')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(@width,'px')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:when>

                        <!-- Block level and @height > @width, in procedure -->
                        <xsl:when test="(@height &gt; @width) and ancestor::step">
                            <xsl:attribute name="content-height">
                                <xsl:choose>
                                    <xsl:when test="@height &gt; '180'">
                                        <xsl:value-of select="concat('180','px')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(@height,'px')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:when>

                        <!-- Block level and @width > @height, in procedure -->
                        <xsl:when test="(@width &gt; @height) and ancestor::step">
                            <xsl:attribute name="content-width">
                                <xsl:choose>
                                    <xsl:when test="@width &gt; '150'">
                                        <xsl:value-of select="concat('150','px')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(@width,'px')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:when>

                        <xsl:otherwise>
                            <xsl:attribute name="content-width">
                                <xsl:choose>
                                    <xsl:when test="@width &gt; '200'">
                                        <xsl:value-of select="concat('200','px')"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="concat(@width,'px')"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:otherwise>

                    </xsl:choose>
                </xsl:when>


                <!-- Height or width attribute, or both, missing -->
                <xsl:when test="not(@width) and not(@height) and not(ancestor::p)">
                    <xsl:attribute name="content-width">
                        <xsl:value-of select="concat('180','px')"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="not(@width) and not(@height) and ancestor::p">
                    <xsl:attribute name="content-width">
                        <xsl:value-of select="concat('12','px')"/>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="@width != '' and not(@height)">
                    <xsl:attribute name="content-width">
                        <xsl:choose>
                            <xsl:when test="@width &gt; '250' and /*/@role = '2-col'">
                                <xsl:value-of select="concat('250','px')"/>
                            </xsl:when>
                            <xsl:when
                                test="@width &gt; '300' and (/*/@role != '2-col' or not(/*/@role))">
                                <xsl:value-of select="concat('300','px')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(@width,'px')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="not(@width) and @height != ''">
                    <xsl:attribute name="content-height">
                        <xsl:choose>
                            <xsl:when test="@height &gt; '300' and /*/@role = '2-col'">
                                <xsl:value-of select="concat('300','px')"/>
                            </xsl:when>
                            <xsl:when
                                test="@height &gt; '300' and (/*/@role != '2-col' or not(/*/@role))">
                                <xsl:value-of select="concat('300','px')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(@height,'px')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </xsl:when>
            </xsl:choose>


            <xsl:if test="parent::step and preceding-sibling::*">
                <xsl:attribute name="keep-with-previous">always</xsl:attribute>
            </xsl:if>

            <xsl:choose>
                <!-- Replace Flash image with still alternative -->
                <!-- Assumes a JPG image with the same name in the same directory -->
                <xsl:when test="contains(@xlink:href,'.swf')">
                    <xsl:attribute name="src">
                        <xsl:value-of
                            select="concat($start, substring-before(@xlink:href, 'swf'),'jpg', $end)"
                        />
                    </xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="src">
                        <xsl:value-of select="concat($start, @xlink:href, $end)"/>
                    </xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>

        </fo:external-graphic>
    </xsl:template>


    <xsl:template match="caption[parent::figure]">
        <fo:block 
            space-before="4pt" 
            keep-with-previous="always">
            <fo:inline font-style="italic">
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Figure'"/>
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
                <xsl:number count="figure" level="any" from="body/section"/>
                <xsl:text>: </xsl:text>
                <xsl:apply-templates/>
            </fo:inline>
        </fo:block>
    </xsl:template>

    <xsl:template match="poslist">
        <fo:list-block 
            font-size="8pt" 
            font-family="{$heading-font-family}"
            keep-together.within-column="always" 
            margin-top="6pt">
            <xsl:apply-templates/>
        </fo:list-block>
    </xsl:template>

    <xsl:template match="pos">
        <fo:list-item id="{generate-id(.)}">
            <fo:list-item-label end-indent="label-end()">
                <fo:block>
                    <xsl:number count="pos" from="poslist"/>
                    <xsl:text>.</xsl:text>
                </fo:block>
            </fo:list-item-label>
            <fo:list-item-body start-indent="body-start()">
                <fo:block>
                    <xsl:apply-templates/>
                </fo:block>
            </fo:list-item-body>
        </fo:list-item>
    </xsl:template>

    <xsl:template match="block">
        <!-- Currently a no-op -->
    </xsl:template>



    <!-- "Track changes" processing instructions in XMetaL -->
    <!-- ================================================= -->

    <!-- Inserted text: red -->
    <xsl:template
        match="text()[following::processing-instruction('xm-insertion_mark_end')][preceding::processing-instruction('xm-insertion_mark_start')]">
        <fo:inline color="red">
            <xsl:value-of select="."/>
        </fo:inline>
    </xsl:template>

    <!-- Deleted text: strikethrough -->
    <xsl:template match="processing-instruction('xm-deletion_mark')">
        <fo:inline text-decoration="line-through">
            <xsl:value-of select="substring-before(substring-after(., 'data=&#x0022;'), '&#x0022;')"
            />
        </fo:inline>
    </xsl:template>


</xsl:stylesheet>
