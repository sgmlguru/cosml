<p:declare-step xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:cos="http://www.cassis.nu/cos" xmlns:cx="http://xmlcalabash.com/ns/extensions" xmlns:p="http://www.w3.org/ns/xproc" name="pub" version="1.0">
    
    
    <!-- Input document -->
    <p:input port="document">
        <!--<p:document href="http://localhost:8080/exist/rest/db/work/docs/pdftest/test-root.xml"/>-->
    </p:input>
    
    <!-- XSLT COSML2HTML -->
    <p:input port="stylesheet">
        <!--<p:document href="http://localhost:8080/exist/rest/db/work/system/cosml/xslt/cosml2html-ti.xsl"/>-->
    </p:input>
    
    <!-- Normalize -->
    <p:input port="stylesheet-norm">
        <!--<p:document href="http://localhost:8080/exist/rest/db/work/system/cosml/xslt/normalize-2.xsl"/>-->
    </p:input>
    
    <!-- Map URL -->
    <p:input port="map"/>
    
    <!-- Parameters -->
    <p:input port="xslt-params" kind="parameter"/>
    
    <!-- Options -->
    <p:option name="normalized"/>
    <p:option name="htm"/>
    
    
    <!-- Output ports -->
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="cosml-htm"/>
    </p:output>
    
    
    
    <!-- Normalization -->
    <p:xslt name="normalize">
        <p:input port="source">
            <p:pipe port="document" step="pub"/>
        </p:input>
        <p:input port="parameters">
            <p:pipe port="xslt-params" step="pub"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet-norm" step="pub"/>
        </p:input>
    </p:xslt>
    <p:store>
        <p:with-option name="href" select="$normalized"/>
        <p:input port="source">
            <p:pipe port="result" step="normalize"/>
        </p:input>
    </p:store>
    
    
    
    <!-- Converts normalized doc to HTML format -->
    <p:xslt name="xml2htm">
        <p:input port="source">
            <p:pipe port="result" step="normalize"/>
        </p:input>
        <p:input port="parameters">
            <p:pipe port="xslt-params" step="pub"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet" step="pub"/>
        </p:input>
    </p:xslt>
    
    
    
    <!-- Stores HTML -->
    <p:store name="store-html">
        <p:with-option name="href" select="$htm"/>
        <p:input port="source">
            <p:pipe port="result" step="xml2htm"/>
        </p:input>
    </p:store>
    
    
    
    <!-- HTML result output -->
    <p:identity name="cosml-htm">
        <p:input port="source">
            <!--<p:pipe port="result" step="xml2htm"/>-->
            <p:inline>
                <p>Success!</p>
            </p:inline>
        </p:input>
    </p:identity>
</p:declare-step>