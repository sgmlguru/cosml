xquery version "1.0";

declare namespace db="http://docbook.org/ns/docbook";
declare namespace request="http://exist-db.org/xquery/request";
declare namespace exist="http://exist.sourceforge.net/NS/exist";
declare namespace util="http://exist-db.org/xquery/util";
declare option exist:serialize "method=xml media-type=text/xml indent=no";

(: let $filter := request:get-parameter('filter', '') :)

(:let $login := xmldb:login('/db','admin','condesign')
let $filter := request:get-parameter('filter', ''):)
(:let $domain := "":)
let $xml := collection(concat('/db/work/','docs'))
(:let $work-mhs-stdtexts := collection(concat('/db/work/','mhs','/standard-texts'))
let $work-rhs-facts := collection(concat('/db/lrf/work/','rhs','/facts')):)

return <data>
    
    {
    for $doc in ($xml)
    order by base-uri($doc)
    
    return if (contains(base-uri($doc),'.xml') and local-name($doc/*)='cos')
        then <item> 
            <string>{tokenize(base-uri($doc),'/')[last()]} - root XML, ({base-uri($doc)})</string>
            <value>{base-uri($doc)}</value>
            <type>root</type>
        </item>
        else if (contains(base-uri($doc),'.xml') and local-name($doc/*)!='cos')
            then <item> 
            <string>{tokenize(base-uri($doc),'/')[last()]} ({tokenize(base-uri($doc),'\.')[last()]} XML module, {base-uri($doc)})</string>
            <value>{base-uri($doc)}</value>
            <type>xmlmodules</type>
        </item>
        else (<item> 
            <string>{tokenize(base-uri($doc),'/')[last()]} ({tokenize(base-uri($doc),'\.')[last()]} module, {base-uri($doc)})</string>
            <value>{base-uri($doc)}</value>
            <type>other</type>
        </item>)
    }
</data>