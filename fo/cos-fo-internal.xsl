<?xml version="1.0" encoding="UTF-8"?>

<!-- XSLT stylesheet for conversion of COSML 2.0 documents to XSL FO -->
<!-- Driver for the "internal" version: no cover page, fewer pagebreaks -->

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" 
    xmlns:xlink="http://www.w3.org/1999/xlink"
    version="2.0">


    <xsl:import href="param.xsl"/>
    <xsl:include href="attribute-set.xsl"/>
    <xsl:include href="layout.xsl"/>
    <xsl:include href="bookmarks.xsl"/>
    <xsl:include href="static-content.xsl"/>
    <xsl:include href="meta-data.xsl"/>
    <xsl:include href="toc.xsl"/>
    <xsl:include href="body.xsl"/>
    <xsl:include href="sections.xsl"/>
    <xsl:include href="block.xsl"/>
    <xsl:include href="inline.xsl"/>
    <xsl:include href="list.xsl"/>
    <xsl:include href="table.xsl"/>
    <xsl:include href="xref.xsl"/>
    <xsl:include href="back.xsl"/>
    <xsl:include href="index.xsl"/>
    <xsl:include href="inset.xsl"/>
    <xsl:include href="l10n.xsl"/>
    <xsl:include href="extension.xsl"/>

    <!-- Demo stylesheet additions -->
    <xsl:include href="demo.xsl"/>

    <xsl:param name="generate.index">0</xsl:param>
    <xsl:param name="xep.extensions">0</xsl:param>
    <xsl:param name="xslfo.bookmarks">1</xsl:param>

    <!-- FOP extensions no longer work. Use standard FO 1.1 functionality. -->
    <xsl:param name="fop.extensions">0</xsl:param>

    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

</xsl:stylesheet>
