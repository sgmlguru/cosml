<?PUBLIC "-//COS//ELEMENTS COSML 2.0//ISO10646"?>



<!-- This is the element declaration module for the COSML DTD -->
<!-- ======================================================== -->




<!-- ============ -->
<!-- Body Section -->
<!-- ============ -->


<!ELEMENT body    ((%block.content;)+ | (section | inset)+) >
<!ATTLIST body    %common.att; >



<!-- Section definition -->

<!ELEMENT section (title, (%block.content;)*, (section | inset)*) >
<!ATTLIST section %doc.element.att;
                  %applic.att;
                  %common.att; >



<!-- Block-level elements -->

<!ELEMENT inset      EMPTY >
<!ATTLIST inset      %applic.att;
                     %common.att;
                     %xlink.subdoc.att; >

<!ELEMENT block-inset   EMPTY >
<!ATTLIST block-inset   %xlink.subdoc.att;
                        %applic.att;
                        %common.att;
                        >

<!ELEMENT list       (p?, (list-item, list-item+)) >
<!ATTLIST list       type (unordered | ordered) "unordered"
                     %applic.att;
                     %common.att;>

<!ELEMENT step-list  (admonishment*, p?, step, (p?, step,
                     (p | step)*))
                     >
<!ATTLIST step-list  %applic.att;
                     %common.att; >

<!ELEMENT def-list   (p?, def-item, (p?, def-item, (p | def-item)*)) >
<!ATTLIST def-list   %applic.att;
                     %common.att; >

<!ELEMENT def-item   (term, definition) >
<!ATTLIST def-item   %applic.att;
                     %common.att; >

<!ELEMENT term       (#PCDATA | %inline.content;)* >
<!ATTLIST term       %common.att; >

<!ELEMENT definition (p | list)+ >
<!ATTLIST definition %common.att; >

<!ELEMENT p          (#PCDATA | %p.inline.content;)* >
<!ATTLIST p          %applic.att;
                     %common.att; >

<!ELEMENT list-item  ((p | graphics | note)+ | list) >
<!ATTLIST list-item  %applic.att;
                     %common.att; >

<!ELEMENT step       (admonishment*, ((p, (p | graphics | figure | note)*) | list)) >
<!ATTLIST step       %applic.att;
                     %common.att; >

<!ELEMENT figure  	 ((graphics+, caption?, poslist?) | figure+) >
<!ATTLIST figure  	 %applic.att;
                     %common.att; >

<!ELEMENT graphics   EMPTY >
<!ATTLIST graphics   %xlink.picture.att;
                     width CDATA #IMPLIED
                     height CDATA #IMPLIED
                     boxed (yes | no) "no"
                     %applic.att;
                     %common.att;
                     >

<!ELEMENT caption    (#PCDATA | wrap)* >
<!ATTLIST caption    %common.att; >

<!ELEMENT poslist    (p?, pos+) >
<!ATTLIST poslist    %applic.att;
                     %common.att; >

<!ELEMENT pos        (#PCDATA|%inline.content;)* >
<!ATTLIST pos        reset (yes | no) #IMPLIED
                     startno CDATA #IMPLIED
                     %applic.att;
                     %common.att; >

<!ELEMENT note       (p, p?) >
<!ATTLIST note       %common.att; >

<!ELEMENT admonishment  (p, p?) >
<!ATTLIST admonishment  type (caution | warning | danger) #REQUIRED
                        %applic.att;
                        %common.att;
                        >

<!ELEMENT example    (caption, (%block.component; | graphics)+) >
<!ATTLIST example    %applic.att;
                     %common.att; >

<!ELEMENT code-block (#PCDATA) >
<!ATTLIST code-block xml:space (preserve) #FIXED "preserve"
                     %applic.att;
                     %common.att;
                     >

<!ELEMENT block      (%block.content;)* >
<!ATTLIST block      %doc.element.att;
                     %applic.att;
                     %common.att; >



<!-- Inline elements -->

<!ELEMENT emph    (#PCDATA | %basic.inline.content; | %sscript.block;)* >
<!ATTLIST emph    %common.att; >

<!ELEMENT lit     (#PCDATA | %basic.inline.content; | %sscript.block;)* >
<!ATTLIST lit     %lang.att;
                  %common.att; >

<!ELEMENT quote   (#PCDATA | %inline.component;)* >
<!ATTLIST quote   %common.att; >

<!ELEMENT code    (#PCDATA | %basic.inline.content;)* >
<!ATTLIST code    xml:space (preserve) #FIXED "preserve"
                  %common.att;
                  >

<!ELEMENT gui     (#PCDATA | %basic.inline.content;)* >
<!ATTLIST gui     %common.att; >

<!ELEMENT keystroke  (#PCDATA | %basic.inline.content;)* >
<!ATTLIST keystroke  %common.att; >

<!ELEMENT uri     (#PCDATA | %basic.inline.content;)* >
<!ATTLIST uri     protocol (http | ftp | file | news | email | other)
                  "http"
                  %common.att;
                  >

<!ELEMENT file-path  (#PCDATA | %basic.inline.content;)* >
<!ATTLIST file-path  type (dos | unix | other) "dos"
                     %common.att;
                     >

<!ELEMENT subs    (#PCDATA | %basic.inline.content; | emph)* >
<!ATTLIST subs    %common.att; >

<!ELEMENT sups    (#PCDATA | %basic.inline.content; | emph)* >
<!ATTLIST sups    %common.att; >

<!--<!ELEMENT index   (#PCDATA | %inline.content;)* >
<!ATTLIST index   index-term CDATA #IMPLIED
                  index-term2 CDATA #IMPLIED
                  index-term3 CDATA #IMPLIED
                  see CDATA #IMPLIED
                  see-also CDATA #IMPLIED
                  %common.att;
                  >-->

<!-- The index model used below is the DocBook Index model; for usage,
     see http://www.docbook.org/tdg/en/html/indexterm.html -->

<!ELEMENT index    (primary, ( (secondary, ( (tertiary, (see | see-also+)?) |
                    see | see-also+)? ) | see | see-also+)?) >
<!ATTLIST index    significance (normal | preferred) "normal"
                   class (singular | endofrange | startofrange) #IMPLIED
                   startref CDATA #IMPLIED
                   %common.att; >

<!ELEMENT primary    (#PCDATA | %inline.content;)* >
<!ATTLIST primary    %common.att; >

<!ELEMENT secondary   (#PCDATA | %inline.content;)* >
<!ATTLIST secondary   %common.att; >

<!ELEMENT tertiary    (#PCDATA | %inline.content;)* >
<!ATTLIST tertiary    %common.att; >

<!ELEMENT see    (#PCDATA | %inline.content;)* >
<!ATTLIST see    %common.att; >

<!ELEMENT see-also    (#PCDATA | %inline.content;)* >
<!ATTLIST see-also    %common.att; >

<!ELEMENT gl-term (#PCDATA | %inline.content;)* >
<!ATTLIST gl-term glossary-term CDATA #IMPLIED
                  %common.att; >

<!ELEMENT xref    (#PCDATA | %inline.content; | locator | ftnote | ftnoteref)* >
<!ATTLIST xref    %applic.att;
                  %common.att; >

<!ELEMENT locator EMPTY >
<!ATTLIST locator %common.att;
                  %applic.att;
                  %xlink.simple.att; >

<!ELEMENT hlink   (#PCDATA | %inline.content; | ftnote | ftnoteref)* >
<!ATTLIST hlink   %common.att;
                  %applic.att;
                  %xlink.simple.att; >

<!ELEMENT ftnote    (#PCDATA | %ftnote.content;)* >
<!ATTLIST ftnote    %label.att;
                    %applic.att;
                    %common.att; >

<!ELEMENT ftnoteref (#PCDATA | %inline.component;)* >
<!ATTLIST ftnoteref %label.att;
                    %applic.att;
                    %xlink.simple.att;
                    %common.att; >

<!ELEMENT wrap    (#PCDATA | %p.inline.content;)* >
<!ATTLIST wrap    %doc.element.att;
                  %applic.att;
                  %common.att; >




<!-- =========== -->
<!-- Back matter -->
<!-- =========== -->


<!ELEMENT back       (section | glossary | reference | inset)* >
<!ATTLIST back       %common.att; >

<!-- Section in back is an appendix, by definition -->

<!ELEMENT glossary   (title?, p?, def-item+) >
<!ATTLIST glossary   %doc.element.att;
                     %applic.att;
                     %common.att; >

<!ELEMENT reference  (p?, ref-item+) >
<!ATTLIST reference  %doc.element.att;
                     %applic.att;
                     %common.att; >

<!ELEMENT ref-item   (doc-info, p?) >
<!ATTLIST ref-item   %applic.att;
                     %common.att; >

