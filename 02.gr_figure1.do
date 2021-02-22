********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for Figure 1 (version 2021.02.21)
********************************************************************************

cd "/Users/aureliotobias/Dropbox/WORK/NEKKEN/WORK/COVID Sesonality/Letter R1"

* Define periodic models
global model1 = "sin_1 cos_1"
global model1 = "sin_1 cos_1 sin_2 cos_2"
global model3 = "sin_1 cos_1 sin_2 cos_2 sin_3 cos_3"

********************************************************************************
* LOOP
********************************************************************************

foreach num of numlist 1/22 {

	* Load dataset and keep selected region
	use "covid19season" , clear
	keep if region_num == `num'

	* Reshape to wide format	
	encode country , generate(country_num) 
	xtset t country_num 
	drop country region hemisphere
	reshape wide case pop , i(t) j(country_num)

	* Generate cases and population
	egen cases_`num' = rsum(cases*)
	egen pop_`num'   = rsum(pop*)
	format pop_`num' %12.0f
	
	* Generate periodic functions
	generate degrees = (t/52)*360 
	fourier degrees , n(3)
	
	* Fit seasonal model and keep predicted incidence rate
	poisson cases_`num' $model1 , exp(pop_`num') 
	predict p_`num' , ir
		
	* Standardize the predicted incidence rate
	summarize p_`num'
	generate z_`num' = (p_`num'-r(mean))/r(sd)
	
	* Save auxiliary dataset
	order t week cases_`num' pop_`num' p_`num' z_`num' 
	keep  t week cases_`num' pop_`num' p_`num' z_`num' 
	save aux_pred_`num' , replace

}

use aux_pred_1 , clear
foreach num of numlist 2/22 {
	merge 1:1 t using aux_pred_`num'
	drop _merge
}

********************************************************************************
* AFRICA
********************************************************************************

twoway (line z_1 t , lw(thick) lcolor(gold%10)  sort) /*
*/     (line z_2 t , lw(thick) lcolor(gold%25)  sort) /*
*/     (line z_3 t , lw(thick) lcolor(gold%50)  sort) /*
*/     (line z_4 t , lw(thick) lcolor(gold%70)  sort) /*
*/     (line z_5 t , lw(thick) lcolor(gold%100) sort) /*
*/ , /*
*/ title("Africa" , col(black) size(small)) /*
*/ xtitle(" " , size(vsmall)) /*
*/ l1("Stardadized Incidence Rate" , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1(1)3 , labsize(vsmall) axis(1)) yscale(range(-1.25 3.25)) /*
*/ legend(order(1 "Northern Africa" 2 "Eastern Africa" 3 "Middle Africa" 4 "Southern Africa" 5 "Western Africa") row(2) rowgap(*.1) size(vsmall) symxsize(*.25) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Africa" , replace)		  
 
********************************************************************************
* AMERICA
********************************************************************************
		  
twoway (line z_6 t , lw(thick) lcolor(blue%15)  sort) /*
*/     (line z_7 t , lw(thick) lcolor(blue%35)  sort) /*
*/     (line z_8 t , lw(thick) lcolor(blue%55)  sort) /*
*/     (line z_9 t , lw(thick) lcolor(blue%100) sort) /*
*/ , /*
*/ title("America" , col(black) size(small)) /*
*/ xtitle(" " , col(black) size(small)) /*
*/ l1("Stardadized Incidence Rate" , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1(1)3 , labsize(vsmall) axis(1)) yscale(range(-1.25 3.25)) /*
*/ legend(order(1 "Caribbean" 2 "Central America" 3 "South America" 4 "Northern America") row(2) rowgap(*.1) size(vsmall) symxsize(*.25) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_America" , replace)	

********************************************************************************
* ASIA
********************************************************************************

twoway (line z_10 t , lw(thick) lcolor(red%10)  sort) /*
*/     (line z_11 t , lw(thick) lcolor(red%25)  sort) /*
*/     (line z_12 t , lw(thick) lcolor(red%50)  sort) /*
*/     (line z_13 t , lw(thick) lcolor(red%70)  sort) /*
*/     (line z_14 t , lw(thick) lcolor(red%100) sort) /*
*/ , /*
*/ title("Asia" , col(black) size(small)) /*
*/ xtitle(" " , col(black) size(medsmall)) /*
*/ l1("Stardadized Incidence Rate" , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1(1)3 , labsize(vsmall) axis(1)) yscale(range(-1.25 3.25)) /*
*/ legend(order(1 "Central Asia" 2 "Eastern Asia" 3 "South-eastern Asia" 4 "Southern Asia" 5 "Western Asia") row(2) rowgap(*.1) size(vsmall) symxsize(*.25) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Asia" , replace)				  
		  
********************************************************************************
* EUROPE
********************************************************************************
		  
twoway (line z_15 t , lw(thick) lcolor(gs10%15)  sort) /*
*/     (line z_16 t , lw(thick) lcolor(gs10%35)  sort) /*
*/     (line z_17 t , lw(thick) lcolor(gs10%55)  sort) /*
*/     (line z_18 t , lw(thick) lcolor(gs10%100) sort) /*
*/ , /*
*/ title("Europe" , col(black) size(small)) /*
*/ xtitle(" " , size(vsmall)) /*
*/ l1("Stardadized Incidence Rate" , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1(1)3 , labsize(vsmall) axis(1)) yscale(range(-1.25 3.25)) /*
*/ legend(order(1 "Eastern Europe" 2 "Northern Europe" 3 "Southern Europe" 4 "Western Europe") row(2) rowgap(*.1) size(vsmall) symxsize(*.25) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Europe" , replace)		
		  	  
********************************************************************************
* OCEANIA
********************************************************************************

twoway (line z_19 t , lw(thick) lcolor(green%15)  sort) /*
*/     (line z_20 t , lw(thick) lcolor(green%35)  sort) /*
*/     (line z_21 t , lw(thick) lcolor(green%55)  sort) /*
*/     (line z_22 t , lw(thick) lcolor(green%100) sort) /*
*/ , /*
*/ title("Oceania" , col(black) size(small)) /*
*/ xtitle(" " ,  size(vsmall)) /*
*/ l1("Stardadized Incidence Rate" , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1(1)3 , labsize(vsmall) axis(1)) yscale(range(-1.25 3.25)) /*
*/ legend(order(1 "Australia and New Zealand" 2 "Melanesia" 3 "Micronesia" 4 "Polynesia") row(2) rowgap(*.1) size(vsmall) symxsize(*.25) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Oceania" , replace)

********************************************************************************
* FIGURE 1
********************************************************************************

graph combine plot_Africa.gph plot_America.gph plot_Asia.gph plot_Europe.gph plot_Oceania.gph /*
*/ , /*
*/ row(3) xsize(9) ysize(12) graphregion(c(white)) ycommon  iscale(.5)
graph export "figure1.pdf" , replace

*** ERASE AUXILIARY FILES ******************************************************

foreach gr in plot_Africa.gph plot_America.gph plot_Asia.gph plot_Europe.gph plot_Oceania.gph {
	erase `gr'
} 
foreach num of numlist 1/22 {
	erase aux_pred_`num'.dta
} 

********************************************************************************
* End of do-file
********************************************************************************
