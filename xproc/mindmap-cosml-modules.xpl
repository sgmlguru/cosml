<p:declare-step 
    xmlns:cos="http://www.cassis.nu/cos" 
    xmlns:c="http://www.w3.org/ns/xproc-step" 
    xmlns:p="http://www.w3.org/ns/xproc" 
    xmlns:cx="http://xmlcalabash.com/ns/extensions" 
    name="main" 
    version="1.0">
    
    
    <!-- Input document -->
    <p:input port="document">
        <p:document href="http://localhost:8080/exist/rest/db/work/docs/XMLPrague/prague-demo-root.xml"/>
    </p:input>
    
    <!-- XSLT COSML2MINDMAP -->
    <p:input port="stylesheet">
        <p:document href="http://localhost:8080/exist/rest/db/work/system/cosml/xslt/links2mindmap.xsl"/>
    </p:input>
    
    <!-- Normalize -->
    <p:input port="stylesheet-norm">
        <p:document href="http://localhost:8080/exist/rest/db/work/system/cosml/xslt/normalize-2.xsl"/>
    </p:input>
    
    <!-- Map URL -->
    <p:input port="map"/>
    
    <!-- Parameters -->
    <p:input port="xslt-params" kind="parameter"/>
    
    <!-- Options -->
    <p:option name="normalized" select="'testoutmindmap.xml'"/>
    <p:option name="mm" select="'testmindmap.mm'"/>
    
    
    <!-- Output ports -->
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="cosml-mindmap"/>
    </p:output>
    
    
    
    <!-- Normalization for debug only -->
    <p:xslt name="normalize">
        <p:input port="source">
            <p:pipe port="document" step="main"/>
        </p:input>
        <p:input port="parameters">
            <p:pipe port="xslt-params" step="main"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet-norm" step="main"/>
        </p:input>
    </p:xslt>
    
    <p:store>
        <p:with-option name="href" select="$normalized"/>
        <p:input port="source">
            <p:pipe port="result" step="normalize"/>
        </p:input>
    </p:store>
    
    
    
    <!-- Converts modularised document links to a mindmap -->
    <p:xslt name="xml2mindmap">
        <p:input port="source">
            <p:pipe port="document" step="main"/>
        </p:input>
        <p:input port="parameters">
            <p:pipe port="xslt-params" step="main"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet" step="main"/>
        </p:input>
    </p:xslt>
    
    
    
    <!-- Stores HTML -->
    <!--<p:store name="store-html">
        <p:with-option name="href" select="$htm"/>
        <p:input port="source">
            <p:pipe port="result" step="xml2htm"/>
        </p:input>
    </p:store>-->
    
    
    
    <!-- Mindmap output -->
    <p:identity name="cosml-mindmap">
        <p:input port="source">
            <p:pipe port="result" step="xml2mindmap"/>
        </p:input>
    </p:identity>
    
</p:declare-step>