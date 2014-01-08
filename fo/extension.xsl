<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:rx="http://www.renderx.com/XSL/Extensions"
    xmlns:axf="http://www.antennahouse.com/names/XSL/Extensions"
    xmlns:fox="http://xml.apache.org/fop/extensions" 
    version="2.0">

    <!-- Sundry XSL extensions -->
    <!-- Some extensions might not work with versions earlier than XEP 3.5, AH 2.5, FOP 0.20.4 -->

    <!-- RenderX XEP -->
    <!-- =========== -->

    <!-- PDF document info -->
    <xsl:template name="xep-meta">
        <rx:meta-info>
            <rx:meta-field name="author">
                <xsl:attribute name="value">
                    <xsl:for-each select="//author/name">
                        <xsl:value-of select="first"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="last"/>
                        <xsl:if test="position() != last()">,&#x20;</xsl:if>
                    </xsl:for-each>
                </xsl:attribute>
            </rx:meta-field>

            <rx:meta-field name="title">
                <xsl:attribute name="value">
                    <xsl:value-of select="$doc-title"/>
                </xsl:attribute>
            </rx:meta-field>

            <!--rx:meta-field name="subject">
         </rx:meta-field>
         <rx:meta-field name="keywords">
         </rx:meta-field-->

        </rx:meta-info>
    </xsl:template>


    <!-- PDF bookmarks -->
    <xsl:template match="cos" mode="outline">
        <rx:bookmark internal-destination="doc-title">
            <rx:bookmark-label>
                <xsl:value-of select="$doc-title"/>
            </rx:bookmark-label>
            <xsl:apply-templates
                select="meta-data/abstract|body/section|back/section|//reference|//glossary"
                mode="outline"/>
            <xsl:call-template name="indexoutline"/>
        </rx:bookmark>
    </xsl:template>

    <xsl:template match="abstract" mode="outline">
        <rx:bookmark internal-destination="abstract">
            <rx:bookmark-label>
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Abstract'"/>
                </xsl:call-template>
            </rx:bookmark-label>
        </rx:bookmark>
    </xsl:template>


    <xsl:template match="section" mode="outline">
        <rx:bookmark internal-destination="{generate-id(.)}">
            <rx:bookmark-label>
                <!--xsl:number level="multiple" count="section|inset" format="1.1"/-->
                <!--xsl:text>&#x20;</xsl:text-->
                <xsl:value-of select="title"/>
            </rx:bookmark-label>
            <xsl:apply-templates select="section" mode="outline"/>
        </rx:bookmark>
    </xsl:template>

    <xsl:template match="reference" mode="outline">
        <rx:bookmark internal-destination="{generate-id(./ref-item[1])}">
            <rx:bookmark-label>

                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'References'"/>
                </xsl:call-template>

            </rx:bookmark-label>
        </rx:bookmark>
    </xsl:template>

    <xsl:template match="glossary" mode="outline">
        <rx:bookmark internal-destination="glossary">
            <rx:bookmark-label>

                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Glossary'"/>
                </xsl:call-template>

            </rx:bookmark-label>
        </rx:bookmark>
    </xsl:template>

    <xsl:template name="indexoutline">
        <xsl:if test="$generate.index = '1'">
            <rx:bookmark internal-destination="index">
                <rx:bookmark-label>

                    <xsl:call-template name="getString">
                        <xsl:with-param name="stringName" select="'Index'"/>
                    </xsl:call-template>

                </rx:bookmark-label>
            </rx:bookmark>
        </xsl:if>
    </xsl:template>


    <!-- AntennaHouse XSL Formatter -->
    <!-- ========================== -->

    <!-- PDF document info -->
    <xsl:template name="axf-meta">

        <axf:document-info name="title" value="{$doc-title}"/>

        <axf:document-info name="author">
            <xsl:attribute name="value">
                <xsl:for-each select="//author/name">
                    <xsl:value-of select="first"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="last"/>
                    <xsl:if test="position() != last()">,&#x20;</xsl:if>
                </xsl:for-each>
            </xsl:attribute>
        </axf:document-info>

    </xsl:template>


    <!-- PDF bookmarks -->
    <xsl:template name="axf-bookmarks">

        <xsl:param name="outline-title"/>

        <!-- a group of bookmarks -->
        <xsl:attribute name="axf:outline-group">
            <xsl:value-of select="$doc-title"/>
        </xsl:attribute>

        <!-- a bookmark -->
        <xsl:attribute name="axf:outline-title">
            <!--xsl:number level="multiple" count="section|inset" format="1.1"/>
    <xsl:text>&#x20;</xsl:text-->
            <xsl:value-of select="$outline-title"/>
        </xsl:attribute>

        <!-- hierarchy level -->
        <xsl:attribute name="axf:outline-level">
            <xsl:value-of
                select="count(ancestor::section) + count(self::back) + count(self::meta-data)"/>
        </xsl:attribute>

        <!-- expand/collapse -->
        <xsl:attribute name="axf:outline-expand">
            <xsl:value-of select="'false'"/>
        </xsl:attribute>

    </xsl:template>


    <!-- Apache FOP -->
    <!-- ========== -->

    <!-- PDF bookmarks -->
    <xsl:template match="cos" mode="fop.outline">
        <fox:outline internal-destination="{generate-id(.)}">
            <fox:label>
                <xsl:value-of select="$doc-title"/>
            </fox:label>
            <xsl:apply-templates select="meta-data|body|back" mode="fop.outline"/>
            <xsl:call-template name="fop-indexoutline"/>
        </fox:outline>
    </xsl:template>

    <xsl:template match="abstract" mode="fop.outline">
        <fox:outline internal-destination="abstract">
            <fox:label>
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Abstract'"/>
                </xsl:call-template>
            </fox:label>
        </fox:outline>
    </xsl:template>

    <xsl:template match="section" mode="fop.outline">
        <fox:outline internal-destination="{generate-id(.)}">
            <fox:label>
                <!--xsl:number level="multiple" count="section|inset" format="1.1"/-->
                <!--xsl:text>&#x20;</xsl:text-->
                <xsl:value-of select="normalize-space(title)"/>
            </fox:label>
            <xsl:apply-templates select="section" mode="fop.outline"/>
        </fox:outline>
    </xsl:template>

    <xsl:template match="reference" mode="fop.outline">
        <fox:outline internal-destination="{generate-id(./ref-item[1])}">
            <fox:label>
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'References'"/>
                </xsl:call-template>
            </fox:label>
        </fox:outline>
    </xsl:template>

    <xsl:template match="glossary" mode="fop.outline">
        <fox:outline internal-destination="{generate-id(./def-item[1])}">
            <fox:label>
                <xsl:call-template name="getString">
                    <xsl:with-param name="stringName" select="'Glossary'"/>
                </xsl:call-template>
            </fox:label>
        </fox:outline>
    </xsl:template>

    <xsl:template name="fop-indexoutline">
        <xsl:if test="$generate.index = '1'">
            <fox:outline internal-destination="index">
                <fox:label>
                    <xsl:call-template name="getString">
                        <xsl:with-param name="stringName" select="'Index'"/>
                    </xsl:call-template>
                </fox:label>
            </fox:outline>
        </xsl:if>
    </xsl:template>


</xsl:stylesheet>
