<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">

    <!-- Localization of autogenerated content -->
    <!-- See http://www.dpawson.co.uk/xsl/sect2/N4876.html -->
    <!-- The strings are in strings.xml -->
    <!-- ===================================== -->

    <xsl:template name="getString">

        <xsl:param name="stringName"/>

        <xsl:variable name="doclang" select="/*/@xml:lang"/>
        <xsl:variable name="StringFile" select="document('strings.xml')"/>
        <xsl:variable name="PrimaryLang" select="substring-before($doclang,'-')"/>
        <xsl:variable name="str" select="$StringFile/strings/string[@name=$stringName]"/>

        <xsl:choose>

            <!-- Test for e.g. xml:lang="sv-SE" -->
            <xsl:when test="$str[lang($doclang)]">
                <xsl:value-of select="$str[lang($doclang)][1]"/>
            </xsl:when>
            <!-- Test for e.g. xml:lang="sv" -->
            <xsl:when test="$str[lang($PrimaryLang)]">
                <xsl:value-of select="$str[lang($PrimaryLang)][1]"/>
            </xsl:when>
            <xsl:when test="$str">
                <xsl:value-of select="$str[1]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:message terminate="no">
                    <xsl:text>Warning: no string named '</xsl:text>
                    <xsl:value-of select="$stringName"/>
                    <xsl:text>' found.</xsl:text>
                </xsl:message>
            </xsl:otherwise>

        </xsl:choose>

    </xsl:template>

</xsl:stylesheet>
