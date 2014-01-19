xquery version "1.0";

(: Copies XML in LRF eXist, from work/$domain/* to $domain/export/*
   and images from work/$domain/* to $domain/pub/images :)

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

let $login := xmldb:login('/db','admin','Favorit70')
(:let $files := request:get-data():)



let $files := <data> <value>/db/work/docs/pdftest/test-root.xml</value> </data>



for $file in tokenize($files//value,' ')
    
    (: We only allow root XML as input :)
    let $targetparent := if ((contains($file,'.xml') and local-name(doc($file)/*)='cos')) 
      then ('docs/test')
      else <p>File not XML or not root</p>
    let $filename := tokenize($file,'/')[last()]
    (:let $move-db := xmldb:copy(substring-before($file,tokenize($file,'/')[last()]),concat('/db/work/',$targetparent),$filename):)

return (<p>Output: {concat('/db/work/',$targetparent,'/',$filename)}</p>)
