xquery version "1.0";

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

let $login := xmldb:login('/db','admin','Favorit70')

(:let $files := request:get-data():)
let $files := <data> <value>http://localhost:8080/exist/rest/db/work/docs/pdftest/test-root.xml</value> </data>


for $file in tokenize($files//value,' ')
    
    (: We only allow root XML as input :)
    let $input := if ((contains($file,'.xml') and local-name(doc($file)/*)='cos')) 
      then $file
      else ""
      
    let $filename := tokenize($file,'/')[last()]
    
    let $parameters := <parameters><param name="root-xml" value="{$file}"/></parameters>

    let $result := if ($input !='') then (transform:transform(doc($file),'file:///mnt/win7-work/SGML/DTD/cosml/xslt/doc-resources.xsl', $parameters))
        else ""
        
    return if ($result!='') 
        then xmldb:store("xmldb:exist:///db/work/docs/test","test-resmap.xml",$result) (:$result:)
        else ""
