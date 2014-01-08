<!-- XSLT stylesheet to convert COSML to HTML -->
<!-- Based on IOML conversion XSLT -->
<!-- 2010-01-28 Condesign Operations Support AB -->

<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:xlink="http://www.w3.org/1999/xlink" exclude-result-prefixes="#all"
	version="2.0">

	<xsl:output indent="yes" method="xhtml"/>




	<!-- Variable definitions -->
	<!-- ==================== -->
	
	<xsl:variable name="doc-title">
		<xsl:choose>
			<xsl:when test="//meta-data">
				<xsl:value-of select="//meta-data/doc-info/title"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="/section/title"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="doc-id" select="//meta-data//doc-id"/>
	<xsl:variable name="year">
		<!-- select="//meta-data//first-date/y" -->
		<xsl:for-each select="//pub-info//y[not(preceding::y = .)]">
			<xsl:sort order="ascending"/>
			<xsl:apply-templates/>
			<xsl:if test="position() != last()">
				<xsl:text>, </xsl:text>
			</xsl:if>
		</xsl:for-each>
	</xsl:variable>
	



	<!-- Start of transformation -->
	<!-- ======================= -->

	<xsl:template match="/">

		<!--
	<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN">
	
-->

		<html>
			<head>
				<title>
					<xsl:value-of select="$doc-title"/>
				</title>
				<style type="text/css" xml:space="preserve">
  #nav      {color:red;}
  #logo     {color:lime;}
  #branding {color:black;}
  .code     {color:gray;
  			 whitespace:pre}
</style>
			</head>
			<body>
				<xsl:apply-templates/>
				<hr/>
				<div>
					<xsl:call-template name="ftnotes"/>
				</div>
				<hr/>
				<div>
					<!--					<img src=""/>-->
					<!-- Company logotype here -->
					<p>
						<em>&#xA9;<xsl:value-of select="$year"/> Condesign Operations Support AB</em>
					</p>
				</div>
			</body>
		</html>
	</xsl:template>
	
	<xsl:template match="cos">
		<xsl:apply-templates/>
	</xsl:template>



	<!-- Meta-data -->
	<!-- ========= -->

	<xsl:template match="meta-data">
		<h2>
			<xsl:value-of select="$doc-title"/>
		</h2>
		<hr/>
		<p>Document number: <em><xsl:apply-templates select="$doc-id"/></em></p>
		<p>
			<xsl:text>Copyright &#xA9; </xsl:text>
			<xsl:value-of select="$year"/>
			<xsl:text> </xsl:text>
			<xsl:value-of select="//copyright"/>
		</p>
	</xsl:template>



	<!-- Document body transformations -->
	<!-- ============================= -->
	
	<xsl:template match="body">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="section">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="title[count(ancestor-or-self::section) = 1]">
		<h2>
			<xsl:attribute name="id">
				<xsl:value-of select="../@id"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</h2>
	</xsl:template>
	
	<xsl:template match="title[count(ancestor-or-self::section) = 2]">
		<h3>
			<xsl:attribute name="id">
				<xsl:value-of select="../@id"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</h3>
	</xsl:template>
	
	<xsl:template match="title[count(ancestor-or-self::section) = 3]">
		<h4>
			<xsl:attribute name="id">
				<xsl:value-of select="../@id"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</h4>
	</xsl:template>
	
	<xsl:template match="title[count(ancestor-or-self::section) = 4]">
		<h5>
			<xsl:attribute name="id">
				<xsl:value-of select="../@id"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</h5>
	</xsl:template>




	<!-- Block-level elements transformation -->
	<!-- =================================== -->

	<xsl:template match="p">
		<p>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="note">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="p[parent::note]">
		<p>
			<strong>Not: </strong>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="admonishment">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="p[parent::admonishment/@type='caution']">
		<p>
			<strong>Obs!</strong>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="p[parent::admonishment/@type='warning']">
		<p>
			<strong>Varning!</strong>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="p[parent::admonishment/@type='danger']">
		<p>
			<strong>Fara!</strong>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="list | list[@type='unordered']">
		<div/>
		<p>
			<xsl:value-of select="p"/>
		</p>
		<ul>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:apply-templates select="list-item"/>
		</ul>
	</xsl:template>

	<xsl:template match="list[@type='ordered'] | step-list">
		<div/>
		<p>
			<xsl:value-of select="p"/>
		</p>
		<ol>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:apply-templates select="list-item|step"/>
		</ol>
	</xsl:template>

	<xsl:template match="list-item | step">
		<li>
			<xsl:attribute name="id">
				<xsl:value-of select="@id"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</li>
	</xsl:template>

	<xsl:template match="p[parent::list-item|parent::step]">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Add note and admonishment handling in list itemns and steps -->

	<xsl:template match="code-block">
		<p class="code">
			<code>
				<xsl:value-of select="."/>
			</code>
		</p>
	</xsl:template>
	
	
	
	<!-- Examples -->
	
	<xsl:template match="example">
		<div>
			<xsl:if test="caption">
				<xsl:text>Exempel </xsl:text>
				<xsl:apply-templates select="caption"/>
			</xsl:if>
			<xsl:apply-templates select="*[local-name(.)!='caption']"/>
		</div>	
	</xsl:template>
	
	
	
	
	<!-- Images -->

	<xsl:template match="figure">
		<div>
			<xsl:apply-templates/>	
		</div>
	</xsl:template>

	<xsl:template match="graphics">
		<img src="{@xlink:href}">
			<!-- xlink:role contains the URL, xlink:href the URN -->
			<xsl:choose>
				<xsl:when test="ancestor::figure">
					<xsl:if test="../@id">
						<xsl:attribute name="id">
							<xsl:value-of select="../@id"/>
						</xsl:attribute>
					</xsl:if>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="@id">
						<xsl:attribute name="id">
							<xsl:value-of select="@id"/>
						</xsl:attribute>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			
			<xsl:attribute name="alt">
<!--				<xsl:value-of select="matches(@xlink:href,'[a-zA-Z\-0-9]\.[a-zA-Z]+')"/>-->
				<xsl:value-of select="@xlink:href"/>
			</xsl:attribute>
		</img>
	</xsl:template>

	<xsl:template match="caption[parent::figure]">
		<p>
			<em>
				<xsl:apply-templates/>
			</em>
		</p>
	</xsl:template>

	<xsl:template match="caption[parent::table]">
		<caption>
			<em>
				<xsl:text>Tabell: </xsl:text>
			</em>
			<xsl:apply-templates/>
		</caption>
	</xsl:template>
	
	<xsl:template match="poslist">
		<div/>
		<ol>
			<xsl:apply-templates/>
		</ol>
	</xsl:template>
	
	<xsl:template match="pos">
		<li>
			<xsl:apply-templates/>
		</li>
	</xsl:template>



	<!-- CALS table conversion               -->
	<!-- =================================== -->

	<xsl:template match="table">
		<table width="90%" frame="border" border="3">
			<xsl:if test="@id!=''">
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</table>
	</xsl:template>
	
	<xsl:template match="tgroup">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="thead">
		<thead>
			<xsl:apply-templates/>
		</thead>
	</xsl:template>

	<xsl:template match="tfoot">
		<tfoot>
			<xsl:apply-templates/>
		</tfoot>
	</xsl:template>

	<xsl:template match="tbody">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="row">
		<tr>
			<xsl:apply-templates/>
		</tr>
	</xsl:template>

	<xsl:template match="entry[ancestor::thead]">
		<th>
			<xsl:apply-templates/>
		</th>
	</xsl:template>

	<xsl:template match="entry[ancestor::tfoot]">
		<td>
			<small>
				<xsl:apply-templates/>
			</small>
		</td>
	</xsl:template>

	<xsl:template match="entry[ancestor::tbody]">
		<td>
			<xsl:apply-templates/>
		</td>
	</xsl:template>

	<!-- Add span handling, borders, etc to table conversion -->



	<!-- Inline elements transformation      -->
	<!-- =================================== -->

	<xsl:template match="emph | uri">
		<em>
			<xsl:apply-templates/>
		</em>
	</xsl:template>

	<xsl:template match="code | file-path">
		<code>
			<xsl:apply-templates/>
		</code>
	</xsl:template>

	<xsl:template match="gui">
		<strong>
			<xsl:apply-templates/>
		</strong>
	</xsl:template>

	<xsl:template match="keystroke">
		<b>
			<xsl:apply-templates/>
		</b>
	</xsl:template>

	<xsl:template match="quote">
		<q>
			<xsl:apply-templates/>
		</q>
	</xsl:template>
	
	<xsl:template match="ftnote">
		<sup>
			<xsl:number count="ftnote" level="any" format="[1]"/>
		</sup>
	</xsl:template>
	
	<xsl:template match="ftnoteref">
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
		<sup>
			<xsl:apply-templates select="//*[@id = $idref-value]" mode="ftnote-numbering"/>
		</sup>
		<xsl:if test="normalize-space(.) != ''">
			<sup>
				<!-- If the ftnote ref has inline text, include it -->
				<xsl:text> </xsl:text>
				<xsl:apply-templates/>
				<xsl:text> </xsl:text>
			</sup>
		</xsl:if>
	</xsl:template>
	
	<!-- Footnote numbering -->
	<xsl:template match="*" mode="ftnote-numbering">
		<xsl:number level="any" count="ftnote" format="[1]" from="body|back"/>
	</xsl:template>

	<xsl:template match="xref">
		<!-- The xref element is for paper publishing only -->
	</xsl:template>

	<xsl:template match="hlink">
		<a>
			<xsl:attribute name="href">
				<xsl:value-of select="@xlink:href"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</a>
	</xsl:template>



	<!-- Back matter elements transformation -->
	<!-- =================================== -->

	<xsl:template match="back">
		<hr/>
		<xsl:if test="reference">
			<div/>
			<h2>Referenser</h2>
			<xsl:apply-templates/>
		</xsl:if>
		<xsl:if test="glossary">
			<div/>
			<h2>Ordlista</h2>
			<xsl:apply-templates/>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ref-item">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="doc-info">
		<p>
			<em>
				<xsl:value-of select="title"/>
				<br/>
				<xsl:value-of select="subtitle"/>
				<br/>
				<xsl:apply-templates select="doc-no"/>
			</em>
			<br/>
			<xsl:value-of select="p"/>
		</p>
	</xsl:template>

	<xsl:template match="glossary-item">
		<dl>
			<dt>
				<xsl:apply-templates select="term"/>
			</dt>
			<dd>
				<xsl:apply-templates select="definition/p"/>
			</dd>
		</dl>
	</xsl:template>
	
	
	
	<!-- Footnote list -->
	<!-- ============= -->
	
	<xsl:template name="ftnotes">
		<xsl:apply-templates select="//ftnote" mode="footnotelist"/>
	</xsl:template>
	
	<xsl:template match="ftnote" mode="footnotelist">
		<p>
			<xsl:number count="ftnote" level="any" format="[1]"/>
			<xsl:text> </xsl:text>
			<xsl:apply-templates/>
		</p>
	</xsl:template>




</xsl:stylesheet>
