<p:declare-step xmlns:cos="http://www.cassis.nu/cos" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:p="http://www.w3.org/ns/xproc" name="main" version="1.0">
    
    
    <!-- Inputs -->
    
    <!-- Resource map document -->
    <p:input port="map" sequence="true">
        <!--<p:document href="http://www.sgmlguru.org/exist/rest/db/work/system/common/xml/resource-map.xml"/>-->
    </p:input>
    
    <!-- XSLT link target check -->
    <p:input port="stylesheet" sequence="true">
        <!--<p:document href="http://www.sgmlguru.org/exist/rest/db/work/system/cosml/xslt/link-target-check-multifile.xsl"/>-->
    </p:input>
    
    
    <!-- Parameters -->
    <p:input port="xslt-params" kind="parameter"/>
    
    
    <!-- Options -->
    
    <!-- HTML report filename -->
    <p:option name="htm"/>
    
    <!-- File URL for files list (input to XSLT) -->
    <p:option name="file-url">
        <!-- No longer needed. Replaced by resource-map.xml. -->
    </p:option>
    
    
    <!-- Output ports -->
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="xref-report"/>
    </p:output>
    
    
    
    <!-- Checks xrefs -->
    <p:xslt name="xref-check">
        <p:input port="source">
            <p:pipe port="map" step="main"/>
        </p:input>
        <p:with-param name="map-url" select="base-uri()">
            <p:pipe port="map" step="main"/>
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