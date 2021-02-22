********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for Supplemtary Figure 1 (version 2021.02.21)
********************************************************************************

use wdb , clear

merge 1:m id using region_unsdm49
drop if _merge!=3

spmap region_num using wcoord /*
*/ , /*
*/ id(id) clmethod(unique) clnumber(22) /*
*/ fcolor(gold%7   gold%25  gold%50  gold%70 gold%100   /*
       */ blue%15  blue%35  blue%55          blue%100   /*
	   */ red%7    red%25   red%50   red%70  red%100    /*
	   */ gs10%15  gs10%35  gs10%55          gs10%100   /*
	   */ green%15 green%35 green%55         green%100) /*
*/ yline(0 , lp(dash)) /*
*/ legend(region(lstyle(white) fc(white) lc(white))) /*
*/ text(3 175 "Equator" , size(vsmall))
graph export "appendix_figure1.pdf" , replace

********************************************************************************
* End of do-file
********************************************************************************
