xquery version "1.0";

(: Copies XML in LRF eXist, from work/$domain/* to $domain/export/*
   and images from work/$domain/* to $domain/pub/images :)

declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace xmldb="http://exist-db.org/xquery/xmldb";

let $login := xmldb:login('/db','admin','Favorit70')
let $files := request:get-data()



for $file in tokenize($files//value,' ')
    (: Decide which domain to use in eXist :)
    let $domain := if (contains($file,'rhs')) 
      then 'rhs/'
      else 'mhs/'
    (: Facts or standard texts are the only allowed text types :)
    let $targetparent := if (contains($file,'images')) 
      then 'pub/images'
      else if (contains($file,'standard-texts')) 
      then 'export/standard-texts'
      else ('export/facts')
    let $filename := tokenize($file,'/')[last()]
    let $move-db := xmldb:copy(substring-before($file,tokenize($file,'/')[last()]),concat('/db/lrf/',$domain,$targetparent),$filename)

return (<p>Publicerade till {concat('/db/lrf/',$domain,$targetparent,'/',$filename)}</p>)
