<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xlink="http://www.w3.org/1999/xlink" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    exclude-result-prefixes="xs xlink" 
    version="2.0">
    
    <xsl:output indent="yes" method="xml" encoding="UTF-8"/>

    <!-- Root XML URI -->
    <xsl:param name="root-xml"/><!-- select="'file:///mnt/win7-work/SGML/DTD/cosml/local-tests/test-root.xml'" -->
    
    <xsl:param name="tmp-base-uri"/>
    <!-- select="'xmldb:exist:///db/work/tmp'" -->
    
    <!-- Resource map template -->
    <xsl:param name="resmap-template-uri"/>
    
    <xsl:param name="res-map-template" select="document($resmap-template-uri)/*"/>
    <!-- 'http://localhost:8080/exist/rest/db/work/system/prox/xml/resource-map-template.xml' -->
    
    <!-- ProX blueprint -->
    <xsl:param name="prox-blueprint-uri"/>
    
    <xsl:param name="prox-blueprint" select="document($prox-blueprint-uri)/*"/>
    <!-- 'http://localhost:8080/exist/rest/db/work/system/prox/xml/prox-blueprint.xml' -->

    <!-- Raw list of URIs into links to participating modules, recursive -->
    <xsl:param name="files">
        <doc>
            <root>
                <resource>
                    <urn/>
                    <url>
                        <!-- Root also needs to be included -->
                        <xsl:value-of select="base-uri(document($root-xml)/*)"/>
                    </url>
                    <type>doc-root</type>
                    
                    <!-- Get allowed ProX IDs for root XML from blueprint -->
                    <xsl:for-each select="$prox-blueprint//value[@type='external' and @input-type='doc-root']">
                        <prox-id>
                            <xsl:value-of select="@id"/>
                        </prox-id>
                    </xsl:for-each>
                </resource>
            </root>
            
            <!-- Modules referenced by root and descendants -->
            <modules>
                <xsl:for-each select="document($root-xml)//graphics">
                    <xsl:call-template name="graphics"/>
                </xsl:for-each>
                <xsl:for-each select="document($root-xml)//inset|document($root-xml)//block-inset">
                    <xsl:call-template name="file">
                        <xsl:with-param name="href" select="substring-before(@xlink:href,'#')"/>
                    </xsl:call-template>
                </xsl:for-each>
            </modules>
        </doc>
    </xsl:param>
    
    <!-- Build resource map -->
    <xsl:template match="/">
        <resource-map>
            <!-- Input document and modules -->
            <docs>
                <xsl:call-template name="doc"/>
            </docs>
            
            <!-- Targets -->
            <xsl:call-template name="targets"/>
            
            <!-- Standard resources -->
            <xsl:copy-of select="$res-map-template//prox |                  $res-map-template//prox-resources |                  $res-map-template//wrapper-pipeline"/>
        </resource-map>
    </xsl:template>
    
    <!-- Template for doc structure in resource map -->
    <xsl:template name="doc">
        <doc>
            <root>
                <xsl:copy-of select="$files/doc/root/resource"/>
            </root>
            <modules>
                <!-- Only list unique file URIs -->
                <xsl:for-each select="$files/doc/modules/resource[not(url=preceding::*)]">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
            </modules>
        </doc>
    </xsl:template>
    
    <!-- XML module handling for $files -->
    <xsl:template name="file">
        <xsl:param name="href"/>
        
        <!-- Include the current XML file -->
        <resource>
            <urn/>
            <url>
                <xsl:value-of select="$href"/>
            </url>
            <type>xml</type>
        </resource>
        
        <!-- List any image refs in the current XML -->
        <xsl:for-each select="document($href)//graphics">
            <xsl:call-template name="graphics"/>
        </xsl:for-each>
        
        <!-- Locate any inset links to other XML in the current XML,
             and recursively list any links in them. -->
        <xsl:for-each select="document($href)//inset|document($href)//block-inset">
            <xsl:call-template name="file">
                <xsl:with-param name="href" select="substring-before(@xlink:href,'#')"/>
            </xsl:call-template>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Graphics link handling -->
    <xsl:template name="graphics">
        <resource>
            <urn/>
            <url>
                <xsl:value-of select="@xlink:href"/>
            </url>
            <type>
                <xsl:value-of select="tokenize(@xlink:href,'\.')[last()]"/>
            </type>
        </resource>
    </xsl:template>
    
    <!-- Targets -->
    <xsl:template name="targets">
        <targets>
            <xsl:for-each select="$prox-blueprint//value[@type = 'external' and @mimetype and @output-type]">
                <xsl:variable name="name">
                    <xsl:value-of select="substring-before(tokenize($files//root//url,'/')[last()],'.xml')"/>
                </xsl:variable>
                <resource>
                    <urn/>
                    <url>
                        <xsl:choose>
                            <xsl:when test="@output-type='primary'">
                                <xsl:value-of select="concat($tmp-base-uri,'/',$name,'.',substring-after(@mimetype,'/'))"/>
                            </xsl:when>
                            <xsl:when test="@output-type='secondary'">
                                <xsl:value-of select="concat($tmp-base-uri,'/',$name,'-')"/>
                                <xsl:value-of select="@id"/>
                                <xsl:value-of select="concat('.',substring-after(@mimetype,'/'))"/>
                            </xsl:when>
                            <xsl:when test="@output-type='fixed'">
                                <xsl:value-of select="concat($tmp-base-uri,'/',@id,'.',substring-after(@mimetype,'/'))"/>
                            </xsl:when>
                        </xsl:choose>
                    </url>
                    <type>
                        <xsl:value-of select="@output-type"/>
                    </type>
                    <prox-id>
                        <xsl:value-of select="@id"/>
                    </prox-id>
                </resource>
            </xsl:for-each>
        </targets>
    </xsl:template>
</xsl:stylesheet>