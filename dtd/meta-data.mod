<?PUBLIC "-//COS//ELEMENTS Meta-data Structures 2.0//ISO10646"?>

<!-- ================= -->
<!-- Meta-data section -->
<!-- ================= -->


<!ELEMENT meta-data  (doc-info, covers*, author+, review*, company-info?,
                      recipient-info?, abstract?, pub-info?) >
<!ATTLIST meta-data  %common.att; >

<!ELEMENT doc-info   (title, subtitle?, doc-no?, doc-type?) >
<!ATTLIST doc-info   %common.att; >

<!ELEMENT title      (#PCDATA | %basic.inline.content;)* >
<!ATTLIST title      %common.att; >

<!ELEMENT subtitle   (#PCDATA | %basic.inline.content;)* >
<!ATTLIST subtitle   %common.att; >

<!ELEMENT doc-no     (number, rev?) >
<!ATTLIST doc-no     %common.att; >

<!ELEMENT doc-type   (#PCDATA | %basic.inline.content;)* >
<!ATTLIST doc-type   %doc-type.att;
                     %common.att; >

<!ELEMENT number     (#PCDATA | %basic.inline.content;)* >
<!ATTLIST number     %common.att; >

<!ELEMENT rev        (#PCDATA | %basic.inline.content;)* >
<!ATTLIST rev        %common.att; >

<!ELEMENT covers     (cover+) >
<!ATTLIST covers     %applic.att;
                     %common.att; >
                     
<!ELEMENT cover      (graphics+) >
<!ATTLIST cover      %applic.att;
                     type (front|back|other) #IMPLIED
                     %common.att; >

<!ELEMENT author     (%person.content;) >
<!ATTLIST author     %common.att; >

<!ELEMENT name       (first, last) >
<!ATTLIST name       %common.att; >

<!ELEMENT first      (#PCDATA | %basic.inline.content;)* >
<!ATTLIST first      %common.att; >

<!ELEMENT last       (#PCDATA | %basic.inline.content;)* >
<!ATTLIST last       %common.att; >

<!ELEMENT contact-info  (dept?, tel, mobile?, email) >
<!ATTLIST contact-info  %common.att; >

<!ELEMENT dept       (#PCDATA | %basic.inline.content;)* >
<!ATTLIST dept       %common.att; >

<!ELEMENT tel        (#PCDATA | %basic.inline.content;)* >
<!ATTLIST tel        %common.att; >

<!ELEMENT mobile     (#PCDATA | %basic.inline.content;)* >
<!ATTLIST mobile     %common.att; >

<!ELEMENT email      (#PCDATA | %basic.inline.content;)* >
<!ATTLIST email      %common.att; >

<!ELEMENT recipient-info    (recipient)+ >
<!ATTLIST recipient-info    %common.att; >

<!ELEMENT recipient  (name?, company-info?, contact-info?) >

<!ELEMENT review     (%person.content;) >
<!ATTLIST review     %common.att; >

<!ELEMENT company-info  (company-name, address?, tel?, email?) >
<!ATTLIST company-info  %common.att; >

<!ELEMENT company-name  (#PCDATA | %basic.inline.content;)* >
<!ATTLIST company-name  %common.att; >

<!ELEMENT address    (line+) >
<!ATTLIST address    %common.att; >

<!ELEMENT line       (#PCDATA | %basic.inline.content;)* >
<!ATTLIST line       %common.att; >

<!ELEMENT abstract   (p+) >
<!ATTLIST abstract   %common.att; >

<!ELEMENT pub-info   (rev-date*, first-date?, signed-info?, disclaimer?,
                      tm-list*, copyright?, graphics*) >
<!ATTLIST pub-info   %common.att; >

<!ELEMENT rev-date   (%date.block;) >
<!ATTLIST rev-date   %common.att; >

<!ELEMENT first-date (%date.block;) >
<!ATTLIST first-date %common.att; >

<!ELEMENT signed-info   (name*, signed-date?, address?) >
<!ATTLIST signed-info   %common.att; >

<!ELEMENT signed-date   (%date.block;) >
<!ATTLIST signed-date   %common.att; >

<!ELEMENT y          (#PCDATA | %basic.inline.content;)* >
<!ATTLIST y          %common.att; >

<!ELEMENT m          (#PCDATA | %basic.inline.content;)* >
<!ATTLIST m          %common.att; >

<!ELEMENT d          (#PCDATA | %basic.inline.content;)* >
<!ATTLIST d          %common.att; >

<!ELEMENT disclaimer (p)+ >
<!ATTLIST disclaimer %common.att; >

<!ELEMENT tm-list    (tm-item+) >
<!ATTLIST tm-list    %common.att; >

<!ELEMENT tm-item    (graphics?, trademark, owner) >
<!ATTLIST tm-item    %common.att; >

<!ELEMENT trademark  (#PCDATA | %basic.inline.content;)* >
<!ATTLIST trademark  %common.att; >

<!ELEMENT owner      (#PCDATA | %basic.inline.content;)* >
<!ATTLIST owner      %common.att; >

<!ELEMENT copyright  (#PCDATA | %basic.inline.content;)* >
<!ATTLIST copyright  %common.att; >
