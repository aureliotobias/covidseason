********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* Environmental Epidemiology 2021 (accepted for publication).
********************************************************************************
* Do-file for Figure 1 (version 2021.02.28)
********************************************************************************

* Define periodic models
global model1 = "sin_1 cos_1"
global model2 = "sin_1 cos_1 sin_2 cos_2"
global model3 = "sin_1 cos_1 sin_2 cos_2 sin_3 cos_3"

********************************************************************************
* LOOP FOR PREDICTED INCIDENCE RATE
********************************************************************************

foreach num of numlist 1/22 {

	* Load dataset and keep selected region
	use "covid19season" , clear
	keep if region_num == `num'

	* Reshape to wide format	
	encode country , generate(country_num) 
	levelsof country_num
	global N = r(levels)
	xtset t country_num 
	drop country region hemisphere
	reshape wide case pop , i(t) j(country_num)

	* Recode weekly country negative counts
	foreach n of numlist $N {
		replace cases`n' = . if cases`n'<0
	}
	
	* Generate total cases and population by region
	egen cases_`num' = rsum(cases*)
	egen pop_`num'   = rsum(pop*)
	format pop_`num' %12.0f
	
	* Generate periodic functions
	generate degrees = (t/52)*360 
	fourier degrees , n(3)
	
	* Fit seasonal model and get predicted incidence rate
	poisson cases_`num' $model2 , exp(pop_`num') 
	predict p_`num' , ir
		
	* z-scores for predicted incidence rate
	summarize p_`num'
	generate z_`num' = (p_`num'-r(mean))/r(sd)
	
	* Save auxiliary dataset
	order t week cases_`num' pop_`num' p_`num' z_`num' 
	keep  t week cases_`num' pop_`num' p_`num' z_`num' 
	save aux_pred_`num' , replace
}

* Append auxiliary datasets for each region
use aux_pred_1 , clear
foreach num of numlist 2/22 {
	merge 1:1 t using aux_pred_`num'
	drop _merge
}

********************************************************************************
* SUBGRAPH FOR AMERICA
********************************************************************************

generate yz_1 = z_1+20
generate yz_2 = z_2+15
generate yz_3 = z_3+10
generate yz_4 = z_4+5
		  
twoway (line yz_1 t , lw(thick) lcolor(blue%100) sort) /*
*/     (line yz_2 t , lw(thick) lcolor(blue%100) sort) /*
*/     (line yz_3 t , lw(thick) lcolor(blue%100) sort) /*
*/     (line yz_4 t , lw(thick) lcolor(blue%100) sort) /*
*/ , /*
*/ title("America" , col(black) size(small)) /*
*/ xtitle(" " , col(black) size(small)) /*
*/ l1(" " , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13.5 "Jun" 18 "Jul" 22.5 "Aug" 27 "Sep" 31 "Oct" 35.5 "Nov" 40 "Dec" 44 "Jan" 48 "Feb" , labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1.25 " " 2.5 " "  3.75 "0" 7.5 "150"     8.75 "0" 12.5 "60"  13.75 "0" 17.5 "80"       18.75 "0" 22.5 "500"       , tlength(0) labsize(vsmall) angle(0)) /*
*/ text(2.5 1 ""           7.5 1 "South America"  12.5 1 "Caribbean"  17.5 1 "Central America"  22.5 1 "Northern America"  , placement(east) size(vsmall)) /*
*/ yline(3 8 13 18 , lcol(gs12)) /*
*/ legend(off) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_America" , replace)	
  
********************************************************************************
* SUBGRAPH FOR EUROPE
********************************************************************************

generate yz_5 = z_5+20
generate yz_6 = z_6+15
generate yz_7 = z_7+10
generate yz_8 = z_8+5
		  
twoway (line yz_5 t , lw(thick) lcolor(gs10%100) sort) /*
*/     (line yz_6 t , lw(thick) lcolor(gs10%100) sort) /*
*/     (line yz_7 t , lw(thick) lcolor(gs10%100) sort) /*
*/     (line yz_8 t , lw(thick) lcolor(gs10%100) sort) /*
*/ , /*
*/ title("Europe" , col(black) size(small)) /*
*/ xtitle(" " , size(vsmall)) /*
*/ l1(" " , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13.5 "Jun" 18 "Jul" 22.5 "Aug" 27 "Sep" 31 "Oct" 35.5 "Nov" 40 "Dec" 44 "Jan" 48 "Feb" , labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1.25 " " 2.5 " "  3.75 "0" 7.5 "275"       8.75 "0" 12.5 "250"      13.75 "0" 17.5 "215"     18.75 "0" 22 "350"      , tlength(0) labsize(vsmall) angle(0)) /*
*/ text(2.5 1 ""           7.5 1 "Southern Europe"  12.5 1 "Western Europe"  17.5 1 "Eastern Europe"  22 1 "Northern Europe"  , placement(east) size(vsmall)) /*
*/ yline(3 8 13 18 , lcol(gs12)) /*
*/ legend(off) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Europe" , replace)		

********************************************************************************
* SUBGRAPH FOR AFRICA
********************************************************************************

generate yz_9  = z_9+20
generate yz_10 = z_10+15
generate yz_11 = z_11+10
generate yz_12 = z_12+5
generate yz_13 = z_13+0

twoway (line yz_9  t , lw(thick) lcolor(gold%100) sort) /*
*/     (line yz_10 t , lw(thick) lcolor(gold%100) sort) /*
*/     (line yz_11 t , lw(thick) lcolor(gold%100) sort) /*
*/     (line yz_12 t , lw(thick) lcolor(gold%100) sort) /*
*/     (line yz_13 t , lw(thick) lcolor(gold%100) sort) /*
*/ , /*
*/ title("Africa" , col(black) size(small)) /*
*/ xtitle(" " , size(vsmall)) /*
*/ l1("Predicted weekly incidence rate (cases/100,000 pop.)" , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13.5 "Jun" 18 "Jul" 22.5 "Aug" 27 "Sep" 31 "Oct" 35.5 "Nov" 40 "Dec" 44 "Jan" 48 "Feb" , labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1.25 "0" 2.5 "150"       3.75 "0" 7.5 "6"       8.75 "0" 12.5 "2.5"     13.75 "0" 17.5 "5"       18.75 "0" 22 "25"      , tlength(0) labsize(vsmall) angle(0)) /*
*/ text(2.5 1 "Southern Africa"  7.5 1 "Eastern Africa"  12.5 1 "Middle Africa"  17.5 1 "Western Africa"  22 1 "Northern Africa" , placement(east) size(vsmall)) /*
*/ yline(3 8 13 18 , lcol(gs12)) /*
*/ leg(off) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Africa" , replace)		  

********************************************************************************
* SUBGRAPH FOR ASIA
********************************************************************************

generate yz_14 = z_14+20
generate yz_15 = z_15+15
generate yz_16 = z_16+10
generate yz_17 = z_17+5
generate yz_18 = z_18+0

twoway (line yz_14 t , lw(thick) lcolor(red%100) sort) /*
*/     (line yz_15 t , lw(thick) lcolor(red%100) sort) /*
*/     (line yz_16 t , lw(thick) lcolor(red%100) sort) /*
*/     (line yz_17 t , lw(thick) lcolor(red%100) sort) /*
*/     (line yz_18 t , lw(thick) lcolor(red%100) sort) /*
*/ , /*
*/ title("Asia" , col(black) size(small)) /*
*/ xtitle(" " , col(black) size(medsmall)) /*
*/ l1(" " , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13.5 "Jun" 18 "Jul" 22.5 "Aug" 27 "Sep" 31 "Oct" 35.5 "Nov" 40 "Dec" 44 "Jan" 48 "Feb" , labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1.25 "0" 2.5 "20"          3.75 "0" 7.5 "30"      8.75 "0" 12.5 "110"     13.75 "0" 17.5 "2.5"   18.75 "0" 22.5 "30"  , tlength(0) labsize(vsmall) angle(0)) /*
*/ text(2.5 1 "South-eastern Asia"  7.5 1 "Southern Asia"  12.5 1 "Western Asia"  17.5 1 "Eastern Asia"  22.5 1 "Central Asia" , placement(east) size(vsmall)) /*

*/ yline(3 8 13 18 , lcol(gs12)) /*
*/ legend(off) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Asia" , replace)				  
		  	  
********************************************************************************
* SUBGRAPH FOR OCEANIA
********************************************************************************

generate yz_19 = z_19+20
generate yz_20 = z_20+15
generate yz_21 = z_21+10
generate yz_22 = z_22+5

twoway (line yz_19 t , lw(thick) lcolor(green%100) sort) /*
*/     (line yz_20 t , lw(thick) lcolor(green%100) sort) /*
*/     (line yz_21 t , lw(thick) lcolor(green%100) sort) /*
*/     (line yz_22 t , lw(thick) lcolor(green%100) sort) /*
*/ , /*
*/ title("Oceania" , col(black) size(small)) /*
*/ xtitle(" " ,  size(vsmall)) /*
*/ l1(" " , size(vsmall) ) /* 
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13.5 "Jun" 18 "Jul" 22.5 "Aug" 27 "Sep" 31 "Oct" 35.5 "Nov" 40 "Dec" 44 "Jan" 48 "Feb" , labsize(vsmall)) xscale(range(1 51)) /*
*/ ylab(-1.25 " " 2.5 " "  3.75 "0" 7.5 "8"                         8.75 "0" 12.5 "0.6"  13.75 "0" 17.5 "600"  18.75 "0" 22.5 "230" , tlength(0) labsize(vsmall) angle(0)) /*
*/ text(2.5 1 ""           7.5 1 "Australia and" 7 1 "New Zealand"  12.5 1 "Melanesia"   17.5 1 "Polynesia"    22.5 1 "Micronesia"  , placement(east) size(vsmall)) /*
*/ yline(3 8 13 18 , lcol(gs12)) /*
*/ legend(off) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_Oceania" , replace)

********************************************************************************
* FIGURE 1
********************************************************************************

graph combine plot_America.gph plot_Europe.gph plot_Africa.gph plot_Asia.gph plot_Oceania.gph /*
*/ , /*
*/ row(1) xsize(10) graphregion(c(white)) 
graph export "Figure_1.pdf" , replace

*** ERASE AUXILIARY FILES ******************************************************

foreach gr in plot_America.gph plot_Europe.gph plot_Africa.gph plot_Asia.gph plot_Oceania.gph {
	erase `gr'
} 
foreach num of numlist 1/22 {
	erase aux_pred_`num'.dta
} 

********************************************************************************
* End of do-file
********************************************************************************
