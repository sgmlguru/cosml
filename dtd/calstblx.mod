<?PUBLIC "-//COS//DTD CALS XML Table Model 3.0//EN" ?>

<!-- ====================================================================== -->
<!-- CALS Table Model XML V1.0
     Part of the DocBk30 XML V1.0 DTD
     http://nwalsh.com/docbook/
 
     See COPYRIGHT for more information

     Please direct all questions and comments about this DTD to
     Norman Walsh, <ndw@nwalsh.com>.

     This DTD is based on the CALS Table Model
     PUBLIC "-//USA-DOD//DTD Table Model 951010//EN"
                                                                            -->
<!-- ====================================================================== -->

<!-- These definitions are not directly related to the table model, but are 
     used in the default CALS table model and are usually defined elsewhere 
     (and prior to the inclusion of this table module) in a CALS DTD. -->
     
<!-- Changes for COSML 1.0, 2.0 in entites.mod. -->

<!ENTITY % bodyatt "">
<!ENTITY % secur "">

<!-- no if zero(s),
                                yes if any other digits value -->

<!ENTITY % yesorno 'CDATA'>
<!ENTITY % titles  'title?'>

<!-- default for use in entry content -->

<!ENTITY % paracon '#PCDATA'>

<!--
The parameter entities as defined below provide the CALS table model
as published (as part of the Example DTD) in MIL-HDBK-28001.

These following declarations provide the CALS-compliant default definitions
for these entities.  However, these entities can and should be redefined
(by giving the appropriate parameter entity declaration(s) prior to the
reference to this Table Model declaration set entity) to fit the needs
of the current application.
-->

<!ENTITY % tbl.table.name       "(table|chart)">
<!ENTITY % tbl.table-titles.mdl "%titles;,">
<!ENTITY % tbl.table-main.mdl   "(tgroup+|graphic+)">
<!ENTITY % tbl.table.mdl        "%tbl.table-titles.mdl; %tbl.table-main.mdl;">

<!--
<!ENTITY % tbl.table.excep      "">
-->

<!ENTITY % tbl.table.att        '
    tabstyle    CDATA           #IMPLIED
    tocentry    %yesorno;       #IMPLIED
    shortentry  %yesorno;       #IMPLIED
    orient      (port|land)     #IMPLIED
    pgwide      %yesorno;       #IMPLIED '>
<!ENTITY % tbl.tgroup.mdl       "colspec*,spanspec*,thead?,tfoot?,tbody">
<!ENTITY % tbl.tgroup.att       '
    tgroupstyle CDATA           #IMPLIED '>
<!ENTITY % tbl.hdft.mdl         "colspec*,row+">

<!--
<!ENTITY % tbl.hdft.excep       "">
-->

<!ENTITY % tbl.row.mdl          "(entry|entrytbl)+">

<!--
<!ENTITY % tbl.row.excep        "">
<!ENTITY % tbl.entrytbl.mdl     "colspec*,spanspec*,thead?,tbody">
-->

<!--
<!ENTITY % tbl.entrytbl.excep   "">
-->

<!ENTITY % tbl.entry.mdl        "(para|warning|caution|note|legend|%paracon;)*">

<!--
<!ENTITY % tbl.entry.excep      "">
-->

<!-- =====  Element and attribute declarations follow. =====  -->

<!ELEMENT %tbl.table.name;      (%tbl.table.mdl;)>

<!ATTLIST %tbl.table.name;
        frame           (top|bottom|topbot|all|sides|none)      #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        %tbl.table.att;
        %bodyatt;
        %secur;
>

<!--
<!ATTLIST table
        frame           (top|bottom|topbot|all|sides|none)      #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        %tbl.table.att;
        %bodyatt;
        %secur;
>
-->

<!ELEMENT tgroup      (%tbl.tgroup.mdl;) >

<!ATTLIST tgroup
        cols            CDATA                                   #REQUIRED
        %tbl.tgroup.att;
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
        %secur;
>

<!ELEMENT colspec       EMPTY >

<!ATTLIST colspec
        colnum          CDATA                                   #IMPLIED
        colname         CDATA                                   #IMPLIED
        colwidth        CDATA                                   #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
>

<!ELEMENT spanspec      EMPTY >

<!ATTLIST spanspec
        namest          CDATA                                   #REQUIRED
        nameend         CDATA                                   #REQUIRED
        spanname        CDATA                                   #REQUIRED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
>

<!ELEMENT thead      (%tbl.hdft.mdl;)>
<!ATTLIST thead
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT tfoot      (%tbl.hdft.mdl;)>
<!ATTLIST tfoot
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT tbody      (row+)>

<!ATTLIST tbody
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!ELEMENT row      (%tbl.row.mdl;)>

<!ATTLIST row
        rowsep          %yesorno;                               #IMPLIED
        valign          (top|middle|bottom)                     #IMPLIED
        %applic.att;
        %secur;
>

<!--
<!ELEMENT entrytbl      (%tbl.entrytbl.mdl;)>

<!ATTLIST entrytbl
        cols            CDATA                                   #REQUIRED
        %tbl.tgroup.att;
        colname         CDATA                                   #IMPLIED
        spanname        CDATA                                   #IMPLIED
        namest          CDATA                                   #IMPLIED
        nameend         CDATA                                   #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
        %secur;
>
-->

<!ELEMENT entry      (%tbl.entry.mdl;)*>

<!ATTLIST entry
        colname         CDATA                                   #IMPLIED
        namest          CDATA                                   #IMPLIED
        nameend         CDATA                                   #IMPLIED
        spanname        CDATA                                   #IMPLIED
        morerows        CDATA                                   #IMPLIED
        colsep          %yesorno;                               #IMPLIED
        rowsep          %yesorno;                               #IMPLIED
        align           (left|right|center|justify|char)        #IMPLIED
        char            CDATA                                   #IMPLIED
        charoff         CDATA                                   #IMPLIED
        rotate          %yesorno;                               #IMPLIED
        valign          (top|middle|bottom)                     #IMPLIED
        %secur;
>

<!-- End of CALS Table Model XML V1.0 ..................................... -->
<!-- ...................................................................... -->
