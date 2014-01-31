<p:declare-step xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:cos="http://www.cassis.nu/cos" xmlns:p="http://www.w3.org/ns/xproc" name="pub" version="1.0">
    
    
    <!-- Input -->
    <p:input port="document"/>
    
    <!-- Stylesheets -->
    <p:input port="stylesheet">
        <!--<p:document href="cos-internal-fo.xsl"/>-->
    </p:input>
    <p:input port="stylesheet-norm">
        <!--<p:document href="normalize.xsl"/>-->
    </p:input>
    
    <!-- Schema -->
    <p:input port="schema">
<!--        <p:data href="cosml.dtd"/>-->
    </p:input>
    
    <!-- Map URL -->
    <p:input port="map"/>
    
    <!-- Parameters -->
    <p:input port="xslt-params" kind="parameter"/>
    
    <!-- Options -->
    <p:option name="normalized"/>
    <p:option name="pdf"/>
    
    
    <!-- Output ports -->
    <p:output port="result" sequence="true">
        <p:pipe port="result" step="id"/>
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
    
    <p:store><!-- doctype-public="-//COS//DTD COSML 1.0//ISO10646" doctype-system="cos.dtd" -->
        <p:with-option name="href" select="$normalized"/>
        <p:input port="source">
            <p:pipe port="result" step="normalize"/>
        </p:input>
    </p:store>

    
    
    <!-- Converts normalized doc to FO format -->
    <p:xslt name="xml2fo">
        <p:input port="source">
            <p:pipe port="result" step="normalize"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet" step="pub"/>
        </p:input>
        <p:input port="parameters">
            <p:pipe port="xslt-params" step="pub"/>
        </p:input>
    </p:xslt>
    
    <p:store name="save-fo">
        <p:with-option name="href" select="$pdf"/>
        <p:input port="source">
            <p:pipe port="result" step="xml2fo"/>
        </p:input>
    </p:store>
    
    
    
    <!-- PDF output from FO -->
    <!--<p:xsl-formatter content-type="application/pdf" name="cos-fo">
        <p:input port="source">
            <p:pipe port="result" step="xml2fo"/>
        </p:input>
        <p:with-option name="href" select="$pdf"/>
        <p:with-param name="CONFIG" select="'xmldb:exist:///db/xep.xml'">
            <p:empty/>
        </p:with-param>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xsl-formatter>-->
    
    
    
    <p:identity name="id">
        <p:input port="source">
            <!--<p:pipe port="result" step="xml2fo"/>-->
            <p:inline>
                <p>Success</p>
            </p:inline>
        </p:input>
    </p:identity>
</p:declare-step>