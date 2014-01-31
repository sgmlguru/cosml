xquery version "1.0";

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

let $login := xmldb:login('xmldb:exist:///db/work/tmp','admin','Favorit70')

(: Selected input using eXist path :)
let $file := request:get-data()
(:let $file := <data> <value>/db/work/docs/pdftest/test-root.xml</value> </data>:)

let $filename := tokenize($file,'/')[last()]

(: Check if root XML file -should read start elements from Relax NG schema but is hard-coded for now :)
let $input := if ((contains($file,'.xml') and local-name(doc(concat('http://localhost:8080/exist/rest',$file))/*)='cos')) 
      then $file
      else ""

(: Input parameters for resource map generation XSLT.
   Needs the following:
   ProX blueprint (REST URI), 
   tmp collection URI for ProX output (xmldb:exist URI), 
   resource map template (REST URI), 
   root XML (eXist path) :)
let $parameters := <parameters><param name="root-xml" value="{concat('http://localhost:8080/exist/rest',$file)}"/>
<param name="tmp-base-uri" value="xmldb:exist:///db/work/tmp"/>
<param name="resmap-template-uri" value="http://localhost:8080/exist/rest/db/work/system/prox/xml/resource-map-template.xml"/>
<param name="prox-blueprint-uri" value="http://localhost:8080/exist/rest/db/work/system/prox/xml/prox-blueprint.xml"/></parameters>

(: Generates resource map :)
let $result := 
    if ($input !='') 
        then (transform:transform(doc(concat('http://localhost:8080/exist/rest',$file)),'http://localhost:8080/exist/rest/db/work/system/cosml/xslt/doc-resources.xsl', $parameters))
        else ""

(: Save generated resource map in temp collection :)
let $store := if ($result != '')
    then xmldb:store("xmldb:exist:///db/work/tmp","resource-map.xml",$result)
    else ""


(:return doc('../select-prox.xhtml')/*:)

return $store

(:return if ($result!='') 
    then xmldb:store("xmldb:exist:///db/work/docs/test","test-resmap.xml",$result) 
    (\:<p>{$result}</p>:\)
    else "":)

(:return (<p>Input file: {$file}, Output file: {concat('/db/work/',$targetparent,'/',$filename)}</p>):)
