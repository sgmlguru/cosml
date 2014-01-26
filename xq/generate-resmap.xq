xquery version "1.0";

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

let $login := xmldb:login('/db','admin','Favorit70')

let $files := request:get-data()
(:let $files := <data> <value>http://localhost:8080/exist/rest/db/work/docs/pdftest/test-root.xml</value> </data>:)


for $file in tokenize($files//value,' ')
    
    (: We only allow root XML as input :)
    let $input := if ((contains($file,'.xml') and local-name(doc(concat('http://localhost:8080/exist/rest',$file))/*)='cos')) 
      then $file
      else ""
      
    let $filename := tokenize($file,'/')[last()]
    
    let $parameters := <parameters><param name="root-xml" value="{concat('http://localhost:8080/exist/rest',$file)}"/></parameters>

    let $result := 
        if ($input !='') 
        then (transform:transform(doc(concat('http://localhost:8080/exist/rest',$file)),'http://localhost:8080/exist/rest/db/work/system/cosml/xslt/doc-resources.xsl', $parameters))
        else ""
        
    return if ($result!='') 
        then xmldb:store("xmldb:exist:///db/work/docs/test","test-resmap.xml",$result) (:$result:)
        else ""
