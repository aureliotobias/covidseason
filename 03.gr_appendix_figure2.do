********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for Appendix Figure 2 (version 2021.02.07)
********************************************************************************


********************************************************************************
* SEASONALITY NORTHERN HEMISPHERE
********************************************************************************

*** AFRICA (North) *************************************************************

use "covid19season" , clear
keep if hemisphere == "N" & continent == "Africa"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(gold)) /*
*/ , /*
*/ title("Africa" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.0001)0.0004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Africa_N" , replace)

*** AMERICA (North) ************************************************************

use "covid19season" , clear
keep if hemisphere == "N" & continent == "America"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(blue)) /*
*/ , /*
*/ title("America" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.001)0.004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_America_N" , replace)

*** EUROPE *********************************************************************

use "covid19season" , clear
keep if hemisphere == "N" & continent == "Europe"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(gs10)) /*
*/ , /*
*/ title("Europe" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.001)0.004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Europe_N" , replace)

*** ASIA ***********************************************************************

use "covid19season" , clear
keep if hemisphere == "N" & continent == "Asia"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(red)) /*
*/ , /*
*/ title("Asia" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.0001)0.0004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Asia_N" , replace)

********************************************************************************
* SEASONALITY SOUTHERN HEMISPHERE
********************************************************************************

*** AFRICA (South) *************************************************************

use "covid19season" , clear
keep if hemisphere == "S" & continent == "Africa"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(gold)) /*
*/ , /*
*/ title("Africa" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.0001)0.0004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Africa_S" , replace)

*** AMERICA (South) ************************************************************

use "covid19season" , clear
keep if hemisphere == "S" & continent == "America"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(blue)) /*
*/ , /*
*/ title("America" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.001)0.004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_America_S" , replace)

*** OCEANIA ********************************************************************

use "covid19season" , clear
keep if hemisphere == "S" & continent == "Oceania"

encode country , generate(country_num) 
xtset t country_num 
drop country
reshape wide case pop , i(t) j(country_num)

egen cases = rsum(cases*)
egen pop   = rsum(pop*)
format pop %12.0f
generate rate = cases/pop

twoway (bar rate t , msize(small) mcol(gs12) lcol(black) fcol(green)) /*
*/ , /*
*/ title("Oceania" , col(black) size(small)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.0001)0.0004 , labsize(small)) /*
*/ l1("Incidence" , size(small)) ytitle("") xtitle("" , size(small)) /*
*/ legend(off ) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Oceania_S" , replace)

*** empty plot *****************************************************************

twoway (bar rate t , lc(white) lcol(white) fcol(white)) /*
*/ , /*
*/ title(" ") xtitle(" ") ytitle(" ") /*
*/ xlab( , labcolor(white)) ylab( , labcolor(white)) /*
*/ xscale(off) yscale(off) /*
*/ legend(off) /*
*/ plotregion(lc(white) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_empty" , replace)

********************************************************************************
* JOIN ALL PLOTS
********************************************************************************

graph combine plot_Africa_N.gph plot_America_N.gph plot_Europe_N.gph plot_Asia_N.gph /*
*/ , /*
*/ title("Northern hemisphere" , col(black) size(small)) /*
*/ row(1) xsize(9) graphregion(c(white)) title("Northern hemisphere" , col(black) size(small)) /*
*/ sav(North , replace)

graph combine plot_Africa_S.gph plot_America_S.gph plot_Oceania_S.gph plot_empty.gph /*
*/ , /*
*/ title("Southern hemisphere" , col(black) size(small)) /*
*/ row(1) xsize(9) graphregion(c(white)) title("Southern hemisphere" , col(black) size(small)) /*
*/ sav(South , replace)

graph combine North.gph South.gph /*
*/ , /*
*/ row(2) xsize(9) graphregion(c(white)) 
graph export "appendix_figure2.pdf" , replace

foreach g in plot_Africa_N plot_America_N plot_Europe_N plot_Asia_N plot_Africa_S plot_America_S plot_Oceania_S plot_empty North South {
	erase `g'.gph
} 

********************************************************************************
* End of do-file
********************************************************************************
