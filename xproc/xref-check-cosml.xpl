<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    name="main" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" 
    xmlns:cos="http://www.cassis.nu/cos"
    version="1.0">
    
    
    <!-- Inputs -->
    
    <!-- Resource map document -->
    <p:input port="map"/>
    
    <!-- XSLT link target check -->
    <p:input port="stylesheet"/>
    
    
    <!-- Parameters -->
    
    <p:input port="xslt-params" kind="parameter"/>
    
    
    <!-- Options -->
    
    <!-- HTML report filename -->
    <p:option name="htm"/>
    
    <!-- File URL for files list (input to XSLT) -->
    <p:option name="file-url"/>
    
    
    <!-- Output ports -->
    <p:output port="result-htm">
        <p:pipe port="result" step="xref-report"/>
    </p:output>
    
    
    
    <!-- Generate list of files to check -->
    <p:xslt name="files">
        <p:input port="source">
            <p:pipe port="map" step="main"/>
        </p:input>
        <p:input port="parameters">
            <p:pipe port="xslt-params" step="main"/>
        </p:input>
        <p:input port="stylesheet">
            <p:inline>
                <xsl:stylesheet 
                    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                    exclude-result-prefixes="#all" 
                    version="2.0">
                    <xsl:template match="/resource-map">
                        <files>
                            <xsl:apply-templates 
                                select="docs/doc/root/resource[type='doc-root']/url|docs/doc/modules/resource[type='xml']/url"/>
                        </files>
                    </xsl:template>
                    <xsl:template match="url">
                        <file>
                            <xsl:value-of select="."/>
                        </file>
                    </xsl:template>
                </xsl:stylesheet>
            </p:inline>
        </p:input>
    </p:xslt>
    
    <p:store>
        <p:with-option name="href" select="$file-url"/>
    </p:store>
    
    
    
    
    <!-- Checks xrefs -->
    <p:xslt name="xref-check">
        <p:input port="source">
            <p:pipe port="result" step="files"/>
        </p:input>
        <p:with-param name="file-list-url" select="$file-url">
            <p:empty/>
        </p:with-param>
        <p:with-param name="files" select="/">
            <p:pipe port="result" step="files"/>
        </p:with-param>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet" step="main"/>
        </p:input>
    </p:xslt>
    
    
    
    <!-- Stores HTML report -->
    <p:store name="store-html">
        <p:with-option name="href" select="$htm"/>
    </p:store>
    
    
    
    <!-- HTML result output from FO -->
    <p:identity name="xref-report">
        <p:input port="source">
            <p:pipe port="result" step="xref-check"/>
        </p:input>
    </p:identity>
    
    
</p:declare-step>
