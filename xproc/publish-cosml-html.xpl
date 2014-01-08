<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    name="pub" 
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:c="http://www.w3.org/ns/xproc-step" 
    xmlns:cos="http://www.cassis.nu/cos"
    version="1.0">
    
    
    <!-- Input document -->
    <p:input port="document"/>
    
    <!-- XSLT COSML2HTML -->
    <p:input port="stylesheet"/>
    
    <!-- Normalize -->
    <p:input port="stylesheet-norm"/>
    
    <!-- Schema (COSML DTD) -->
    <p:input port="schema"/>
    
    <!-- Map URL -->
    <p:input port="map"/>
    
    <!-- Parameters -->
    <p:input port="xslt-params" kind="parameter"/>
    
    <!-- Options -->
    <p:option name="htm"/>
    
    <!-- Output ports -->
    <p:output port="result-htm">
        <p:pipe port="result" step="cosml-htm"/>
    </p:output>
    
    <!--<p:output port="validate">
        <p:pipe port="result" step="validate"></p:pipe>
    </p:output>-->
    
    
    <!-- Loading documents -->
    <!--<p:load name="norm-step">
        <p:with-option name="href" select="$normalize-stylesheet"/>
    </p:load>-->
    
    
    
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
        
    <!--<p:delete match="//*/@xml:base" name="del">
        <p:input port="source">
            <p:pipe port="result" step="filter"/>
        </p:input>
    </p:delete>-->
    
    <p:store><!-- doctype-public="-//COS//DTD COSML 1.0//ISO10646" doctype-system="cos.dtd" -->
        <p:with-option name="href" select="'debug-normalized.xml'"/><!-- //e:/SGML/DTD/Cassis/XProc/ -->
        <p:input port="source">
            <p:pipe port="result" step="normalize"></p:pipe>
        </p:input>
    </p:store>


    
    <!-- Validation -->
    <!--<p:try name="validate">
        <p:group>
            <p:output port="result"/>
            <p:load dtd-validate="true" href="normalized.xml"/><!-\- file:///e:/SGML/DTD/Cassis/XProc/ -\->
        </p:group>
        <p:catch name="catch">
            <p:output port="result"/>
            <p:error code="cos:errors">
                <p:input port="source">
                    <p:pipe step="catch" port="error"/>
                </p:input>
            </p:error>
        </p:catch>
    </p:try>-->
    
    
    
    <!-- Converts normalized doc to FO format -->
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
    </p:store>
    
    
    
    <!-- HTML result output from FO -->
    <p:identity name="cosml-htm">
        <p:input port="source">
            <p:pipe port="result" step="xml2htm"/>
        </p:input>
    </p:identity>
    
    
</p:declare-step>
