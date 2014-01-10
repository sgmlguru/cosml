<p:declare-step xmlns:cos="http://www.cassis.nu/cos" xmlns:c="http://www.w3.org/ns/xproc-step" xmlns:p="http://www.w3.org/ns/xproc" name="pub" version="1.0">
    
    
    <!-- Input -->
    <p:input port="document">
        <p:document href="http://www.sgmlguru.org/exist/rest/db/work/docs/pdftest/test-root.xml"/>
    </p:input>
    
    <!-- Stylesheets -->
    <p:input port="stylesheet">
        <p:document href="http://www.sgmlguru.org/exist/rest/db/work/system/cosml/fo/cos-fo-internal.xsl"/>
    </p:input>
    <p:input port="stylesheet-norm">
        <p:document href="http://www.sgmlguru.org/exist/rest/db/work/system/cosml/xslt/normalize-2.xsl"/>
    </p:input>
    
    
    
    <!-- Map URL -->
    <p:input port="map"/>
    
    <!-- Parameters -->
    <p:input port="xslt-params" kind="parameter"/>
    
    <!-- Options -->
    <p:option name="normalized" select="'file:///mnt/win7-work/SGML/DTD/cosml/test-out.xml'"/>
    <p:option name="pdf" select="'http://www.sgmlguru.org/exist/rest/db/work/docs/pdftest/test-out.pdf'"/>
    
    <!-- Output ports -->
    <!--<p:output port="result-fo">
        <p:pipe port="result" step="cos-fo"/>
    </p:output>-->
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
    <p:store>
        <p:with-option name="href" select="$normalized"/>
        <!-- xmldb:exist:///db/work/docs/test/ -->
    </p:store>
    
    
    
    <!-- Converts normalized doc to FO format -->
    <p:xslt name="xml2fo">
        <p:input port="source">
            <p:pipe port="result" step="normalize"/>
        </p:input>
        <p:input port="stylesheet">
            <p:pipe port="stylesheet" step="pub"/>
        </p:input>
    </p:xslt>
    
    
    
    <!-- PDF output from FO -->
    <!--<p:xsl-formatter content-type="application/pdf" name="cos-fo">
        <p:input port="source">
            <p:pipe port="result" step="xml2fo"/>
        </p:input>
        <p:with-option name="href" select="'xmldb:exist:///db/docs/test/out.pdf'"/>-->
    <!--<p:with-param name="CONFIG" select="'file:/c:/XEP/xep.xml'">
            <p:empty/>
        </p:with-param>-->
    <!--<p:with-param name="CONFIG" select="'file:///Users/System/XEP/xep.xml'"><!-//- com.renderx.xep.CONFIG -//->
            <p:empty/>
        </p:with-param>-->
    <!--<p:with-param name="CONFIG" select="'com.xmlcalabash.util.FoFOP'">
            <p:empty/>
        </p:with-param>
        <p:input port="parameters">
            <p:empty/>
        </p:input>
    </p:xsl-formatter>-->
    <p:identity name="id">
        <p:input port="source">
            <p:pipe port="result" step="xml2fo"/>
        </p:input>
    </p:identity>
</p:declare-step>