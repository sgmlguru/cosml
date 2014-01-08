<?PUBLIC "-//COS//ENTITIES COSML 2.0//ISO10646"?>

<!--.This is the entity declaration module for the COSML DTD -->
<!-- ======================================================= -->




<!-- Namespace declarations                    -->
<!-- ========================================= -->

<!ENTITY % xlink.namespace.att "xmlns:xlink   CDATA    #FIXED     'http://www.w3.org/1999/xlink'" >

<!ENTITY % namespaces.att      "%xlink.namespace.att;" >




<!-- Element parameters                        -->
<!-- ========================================= -->

<!ENTITY % person.content    "name, contact-info?" >

<!ENTITY % date.block        "y, m, d" >

<!ENTITY % block.component   "list | step-list | code-block | p" >

<!ENTITY % block.content     "%block.component; | table | figure | note |
			      			  admonishment | example | def-list |
			      			  block | block-inset" >

<!ENTITY % basic.inline.content "wrap" >

<!ENTITY % sscript.block     "subs | sups" >

<!ENTITY % inline.component  "%basic.inline.content; | emph | lit | code | gui | keystroke |
							  %sscript.block; | index | gl-term | uri | file-path" >

<!ENTITY % inline.content    "%inline.component; | quote | graphics" >

<!ENTITY % ftnote.content    "%inline.content; | hlink | xref" >

<!ENTITY % p.inline.content  "%ftnote.content; | ftnote | ftnoteref" >




<!-- Attribute parameters                      -->
<!-- ========================================= -->

<!ENTITY % lang.att	     		"xml:lang NMTOKEN #IMPLIED" >

<!ENTITY % id.att	     	  	"id ID #IMPLIED" >

<!ENTITY % role.att	     		"role CDATA #IMPLIED" >

<!ENTITY % label.att            "label CDATA #IMPLIED" >

<!ENTITY % extension.att     	"" >

<!ENTITY % common.att	     	"%role.att;
								 %extension.att;
								 %id.att;" >

<!ENTITY % applic.att           "applic CDATA #IMPLIED
                                 audience CDATA #IMPLIED 
                                 platform CDATA #IMPLIED
                                 boolean (AND | OR) #IMPLIED" >

<!ENTITY % doc-type.att         "type (quote | order-conf | whitepaper | report |
                                       use-cases | test-spec | system-spec | rs |
                                       ip | other) #IMPLIED" >

<!ENTITY % doc.custom.att    	"" >

<!ENTITY % doc.element.att   	"%doc.custom.att;
								 %namespaces.att;
								 %lang.att;
								 help-id CDATA #IMPLIED" >




<!-- Simple Xlink attributes                   -->
<!-- ========================================= -->

<!ENTITY % xlink.basic.att '
 	%xlink.namespace.att;
	xlink:type    (simple) #FIXED     "simple"	
	xlink:href    CDATA    #REQUIRED
	xlink:title   CDATA    #IMPLIED
  '>



<!ENTITY % xlink.subdoc.att   '
 	%xlink.basic.att;
	xlink:role    CDATA    #IMPLIED
 '>
 
 <!ENTITY % xlink.picture.att '
               %xlink.subdoc.att;
               xlink:show      (embed)              #FIXED     "embed"
               xlink:actuate   (onLoad)             #FIXED     "onLoad"
 ' >
 
<!ENTITY % xlink.simple.att   '
                               %xlink.subdoc.att;
                               xlink:show      (new       |
                            	                 replace   |
                            	                 embed     |
                            	                 other     |
                            	                 none)               #IMPLIED
                               xlink:actuate   (onLoad    |
                            	                 onRequest |
                            	                 other     |
                            	                 none)               #IMPLIED
                              '>





<!-- CALS table model modifications            -->
<!-- ========================================= -->

<!ENTITY % tbl.table.name       "table">
<!ENTITY % tbl.table-titles.mdl "caption?,">
<!ENTITY % tbl.table-main.mdl   "(tgroup+)">
<!ENTITY % tbl.table.mdl        "%tbl.table-titles.mdl; %tbl.table-main.mdl;">
<!ENTITY % yesorno              'CDATA'>
<!ENTITY % tbl.table.att        '
                                 tabstyle    CDATA           #IMPLIED
                                 tocentry    %yesorno;       #IMPLIED
                                 shortentry  %yesorno;       #IMPLIED
                                 orient      (port|land)     #IMPLIED
                                 pgwide      %yesorno;       #IMPLIED
                                 %common.att; '>
<!ENTITY % tbl.row.mdl          "(entry)+">
<!ENTITY % tbl.entry.mdl        "(p|graphics)*">