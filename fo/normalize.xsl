<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">

    <!-- normalize.xsl -->

    <xsl:output indent="yes" method="xml"/>
<!--    <xsl:output doctype-public="-//COS//DTD COSML 1.0//ISO10646" doctype-system="cos.dtd" />-->



    <!-- Parameters for Applics Handling -->
    <!-- =============================== -->

    <!-- The applics string to filter on -->
    <xsl:param name="test-applic" select="normalize-space(/*/@applic)"/>

    <!-- Number of applics in root -->
    <xsl:param name="no-of-applics">
        <xsl:value-of
            select="string-length($test-applic) - string-length(translate($test-applic,' ','')) + 1"/>
    </xsl:param>
    <xsl:param name="i" select="$no-of-applics"/>

    <!-- The delimiter character used to separate between applics values -->
    <xsl:param name="delimiter" select="' '"/>



    <!-- Normalize Templates -->
    <!-- =================== -->

    <xsl:template match="*">
        <xsl:param name="no-of-applic-in-current-node" select="string-length(@applic) - string-length(translate(@applic,' ','')) + 1"/>
        <xsl:param name="result">
            <xsl:call-template name="use-node">
                <xsl:with-param name="i" select="$i"/>
                <xsl:with-param name="test-applic" select="$test-applic"/>
            </xsl:call-template>
        </xsl:param>
        <xsl:param name="no-of-matching-applics" select="string-length($result) - string-length(translate($result,'1',''))"/>
        <xsl:param name="print">
            <xsl:choose>
                <!-- Ordinary applics -->
                <xsl:when test="contains($result,'1') and (not(@boolean) or @boolean[.='OR'])">
                    <xsl:value-of select="'yes'"/>
                </xsl:when>
                
                <!-- Boolean applics conditions apply -->
                <xsl:when test="($no-of-applic-in-current-node = $no-of-matching-applics) and @boolean[.='AND']">
                    <xsl:value-of select="'yes'"/>
                </xsl:when>
                
                <!-- No applics match -->
                <xsl:otherwise>
                    <xsl:value-of select="'no'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:if test="not(@applic) or $print='yes'">
            <xsl:element name="{name(.)}">
                <xsl:call-template name="attribute-copy"/>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template name="attribute-copy">
        <xsl:choose>
            <xsl:when
                test="local-name(.) = 'section' or
                      local-name(.) = 'table' or
                      local-name(.) = 'figure' or
                      local-name(.) = 'step' or
                      local-name(.) = 'ftnote' or
                      local-name(.) = 'example' or
                      local-name(.) = 'ref-item'">
                <xsl:copy-of select="@*"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="@*[name(.) != 'id']"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="inset">
        <xsl:param name="no-of-applic-in-current-node" select="string-length(@applic) - string-length(translate(@applic,' ','')) + 1"/>
        <xsl:param name="result">
            <xsl:call-template name="use-node">
                <xsl:with-param name="i" select="$i"/>
                <xsl:with-param name="test-applic" select="$test-applic"/>
            </xsl:call-template>
        </xsl:param>
        <xsl:param name="no-of-matching-applics" select="string-length($result) - string-length(translate($result,'1',''))"/>
        <xsl:param name="print">
            <xsl:choose>
                <!-- Ordinary applics -->
                <xsl:when test="contains($result,'1') and (not(@boolean) or @boolean[.='OR'])">
                    <xsl:value-of select="'yes'"/>
                </xsl:when>
                
                <!-- Boolean applics conditions apply -->
                <xsl:when test="($no-of-applic-in-current-node = $no-of-matching-applics) and @boolean[.='AND']">
                    <xsl:value-of select="'yes'"/>
                </xsl:when>
                
                <!-- No applics match -->
                <xsl:otherwise>
                    <xsl:value-of select="'no'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:if test="not(@applic) or $print='yes'">
            <xsl:call-template name="inset-common"/>
        </xsl:if>
    </xsl:template>

    <xsl:template match="block-inset">
        <xsl:param name="no-of-applic-in-current-node" select="string-length(@applic) - string-length(translate(@applic,' ','')) + 1"/>
        <xsl:param name="result">
            <xsl:call-template name="use-node">
                <xsl:with-param name="i" select="$i"/>
                <xsl:with-param name="test-applic" select="$test-applic"/>
            </xsl:call-template>
        </xsl:param>
        <xsl:param name="no-of-matching-applics" select="string-length($result) - string-length(translate($result,'1',''))"/>
        <xsl:param name="print">
            <xsl:choose>
                <!-- Ordinary applics -->
                <xsl:when test="contains($result,'1') and (not(@boolean) or @boolean[.='OR'])">
                    <xsl:value-of select="'yes'"/>
                </xsl:when>
                
                <!-- Boolean applics conditions apply -->
                <xsl:when test="($no-of-applic-in-current-node = $no-of-matching-applics) and @boolean[.='AND']">
                    <xsl:value-of select="'yes'"/>
                </xsl:when>
                
                <!-- No applics match -->
                <xsl:otherwise>
                    <xsl:value-of select="'no'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:param>
        
        <xsl:if test="not(@applic) or $print='yes'">
            <xsl:call-template name="inset-common"/>
        </xsl:if>
    </xsl:template>

    <xsl:template name="inset-common">
        <xsl:variable name="doc" select="string(substring-before(@xlink:href,'#'))"/>
        <xsl:variable name="id" select="substring-after(@xlink:href,'#')"/>
        
        <xsl:choose>
            <xsl:when test="contains(@xlink:href,'#')">
                <xsl:variable name="inset" select="document($doc)"/>
                <xsl:choose>
                    <xsl:when test="local-name($inset/*) = 'section-group'">
                        <xsl:apply-templates select="$inset//*[@id=$id]/*"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="$inset//*[@id=$id]"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="inset" select="document(@xlink:href)"/>
                <xsl:choose>
                    <xsl:when test="local-name($inset/*) = 'section-group'">
                        <xsl:apply-templates select="$inset/*/*"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="$inset/*"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Keep leading and trailing whitespace (because of mixed content)
         but normalize the rest... -->
    <!--<xsl:template match="text()">
        <xsl:param name="no-of-characters" select="string-length(.)"/>
        <xsl:value-of select="$no-of-characters"/>
        <xsl:if
            test="starts-with(.,'&#xA;') or
            starts-with(.,'&#xD;') or
            starts-with(.,'&#x20;') or
            starts-with(.,'&#x9;')">
            <xsl:text>&#xA0;</xsl:text>
        </xsl:if>
        <xsl:value-of select="normalize-space(.)"/>
        <xsl:if
            test="(substring(.,$no-of-characters,1) = '&#xA;') or
            (substring(.,$no-of-characters,1) = '&#xD;') or
            (substring(.,$no-of-characters,1) = '&#x20;') or
            (substring(.,$no-of-characters,1) = '&#x9;')">
            <xsl:text>&#xA0;</xsl:text>
        </xsl:if>
    </xsl:template>-->

    <xsl:template match="comment()">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="processing-instruction()">
        <xsl:copy-of select="."/>
    </xsl:template>



    <!-- Named Templates for Applics Handling -->
    <!-- ==================================== -->

    <xsl:template name="use-node">
        <xsl:param name="i"/>
        <xsl:param name="test-applic"/>
        <xsl:param name="compare-string">
            <xsl:call-template name="get-last-substring">
                <xsl:with-param name="string">
                    <xsl:value-of select="$test-applic"/>
                </xsl:with-param>
                <xsl:with-param name="delimiter" select="' '"/>
            </xsl:call-template>
        </xsl:param>

        <xsl:if test="$i>0">
            <xsl:choose>
                <xsl:when test="contains(@applic,$compare-string)">
                    <xsl:call-template name="use-node">
                        <xsl:with-param name="i" select="$i - 1"/>
                        <xsl:with-param name="test-applic">
                            <xsl:value-of
                                select="normalize-space(substring-before($test-applic,$compare-string))"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:value-of select="'1'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:call-template name="use-node">
                        <xsl:with-param name="i" select="$i - 1"/>
                        <xsl:with-param name="test-applic">
                            <xsl:value-of
                                select="normalize-space(substring-before($test-applic,$compare-string))"/>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:value-of select="'0'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:template>

    <xsl:template name="get-last-substring">
        <xsl:param name="string"/>
        <xsl:param name="delimiter"/>
        <xsl:choose>
            <xsl:when test="contains($string, $delimiter)">
                <xsl:call-template name="get-last-substring">
                    <xsl:with-param name="string" select="substring-after($string, $delimiter)"/>
                    <xsl:with-param name="delimiter" select="$delimiter"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$string"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


</xsl:stylesheet>
