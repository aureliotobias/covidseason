********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* Environmental Epidemiology 2021 (accepted for publication).
********************************************************************************
* Do-file for Supplemental Digital Material (version 2021.02.28)
********************************************************************************

********************************************************************************
* Supplementary Table 1
********************************************************************************

use "wdb" , clear

merge 1:m id using "region_unsdm49"
keep if continent!=""

sort continent region_num ïcountry
list continent region_num ïcountry , noobs sepby(continent)

********************************************************************************
* Supplementary Figure 1
********************************************************************************

use "wdb" , clear

merge 1:m id using "region_unsdm49"
drop if _merge!=3

spmap region_num using wcoord /*
*/ , /*
*/ id(id) clmethod(unique) clnumber(22) /*
*/ fcolor(blue%15  blue%35  blue%65           blue%100  /*
 */       gs10%15  gs10%35  gs10%65           gs10%100  /*
 */       gold%10  gold%25  gold%45  gold%60  gold%100  /*
 */        red%10   red%25   red%45   red%60   red%100  /*
 */      green%15 green%35 green%65          green%100) /*
*/ yline(0 , lp(dot)) text(2 179 "Equator"  , size(tiny) col(gs0)) /*
*/ xline(0 , lp(dot)) text(83  7 "Prime meridian" , size(tiny) col(gs0))/*
*/ legend(region(lstyle(white) fc(white) lc(white))) 
graph export "Supplemental_eFigure_1.pdf" , replace

********************************************************************************
* End of do-file
********************************************************************************
