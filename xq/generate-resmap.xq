xquery version "1.0";

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

let $login := xmldb:login('xmldb:exist:///db/work/docs/test','admin','Favorit70')

let $file := request:get-data()
(:let $file := <data> <value>/db/work/docs/pdftest/test-root.xml</value> </data>:)

let $filename := tokenize($file,'/')[last()]

let $input := if ((contains($file,'.xml') and local-name(doc(concat('http://localhost:8080/exist/rest',$file))/*)='cos')) 
      then $file
      else ""

let $parameters := <parameters><param name="root-xml" value="{concat('http://localhost:8080/exist/rest',$file)}"/></parameters>

let $result := 
    if ($input !='') 
        then (transform:transform(doc(concat('http://localhost:8080/exist/rest',$file)),'http://localhost:8080/exist/rest/db/work/system/cosml/xslt/doc-resources.xsl', $parameters))
        else ""

let $store := if ($result != '')
    then xmldb:store("xmldb:exist:///db/work/docs/test","test-resmap.xml",$result)
    else ""


(:return doc('../select-prox.xhtml')/*:)

return $store

(:return if ($result!='') 
    then xmldb:store("xmldb:exist:///db/work/docs/test","test-resmap.xml",$result) 
    (\:<p>{$result}</p>:\)
    else "":)

(:return (<p>Input file: {$file}, Output file: {concat('/db/work/',$targetparent,'/',$filename)}</p>):)
