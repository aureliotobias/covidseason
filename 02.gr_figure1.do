********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for Figure 1 (version 2021.02.17)
********************************************************************************

* Define periodic models
global model1 = "sin_1 cos_1"
global model2 = "sin_1 cos_1 sin_2 cos_2"
global model3 = "sin_1 cos_1 sin_2 cos_2 sin_3 cos_3"

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model2 , exp(pop) 
predict p_africa_n , ir
keep t year week p_africa_n 
save aux_africa_n , replace

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model2 , exp(pop) 
predict p_america_n , ir
keep t year week p_america_n 
save aux_america_n , replace

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model2 , exp(pop) 
predict p_europe , ir
keep t year week p_europe 
save aux_europe , replace

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model2 , exp(pop) 
predict p_asia , ir
keep t year week p_asia 
save aux_asia , replace

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model2 , exp(pop) 
predict p_africa_s , ir
keep t year week p_africa_s
save aux_africa_s , replace

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model2 , exp(pop) 
predict p_america_s , ir
keep t year week p_america_s
save aux_america_s , replace

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
generate degrees = (t/52)*360 
fourier degrees , n(6)

poisson cases $model3 , exp(pop) 
predict p_oceania , ir
keep t year week p_oceania
save aux_oceania , replace

********************************************************************************
* JOIN ALL PREDICTIONS
********************************************************************************

use aux_africa_n , clear
merge 1:1 year week using aux_america_n
drop _merge
merge 1:1 year week using aux_europe
drop _merge
merge 1:1 year week using aux_asia
drop _merge
merge 1:1 year week using aux_africa_s
drop _merge
merge 1:1 year week using aux_america_s
drop _merge
merge 1:1 year week using aux_oceania
drop _merge

********************************************************************************
* PLOT
********************************************************************************

*** NORTHERN HEMISPHERE ********************************************************

twoway (line p_africa_n  t , lw(thick) lcolor(gold) sort yaxis(1)) /*
*/     (line p_america_n t , lw(thick) lcolor(blue) sort yaxis(2)) /*
*/     (line p_europe    t , lw(thick) lcolor(gs10) sort yaxis(2)) /*
*/     (line p_asia      t , lw(thick) lcolor(red)  sort yaxis(1)) /*
*/ , /*
*/ title("Northern hemisphere" , col(black) size(medsmall)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.0001)0.0003 , labsize(small) axis(1)) /*
*/ ylab(0(0.001)0.003   , labsize(small) axis(2)) /*
*/ ytitle("Incidence (America and Europe)" , size(small) axis(1)) /* 
*/ ytitle("Incidence (Africa and Asia)"    , size(small) axis(2)) /* 
*/ xtitle("" , size(small)) /*
*/ legend(order(1 "Africa" 3 "America" 4 "Europe" 2 "Asia") row(1) size(vsmall) symxsize(*.5) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_North" , replace)

*** SOUTHERN HEMISPHERE ********************************************************

twoway (line p_africa_s  t , lw(thick) lcolor(gold)  sort yaxis(1)) /*
*/     (line p_america_s t , lw(thick) lcolor(blue)  sort yaxis(2)) /*
*/     (line p_oceania   t , lw(thick) lcolor(green) sort yaxis(1)) /*
*/ , /*
*/ title("Southern hemisphere" , col(black) size(medsmall)) /*
*/ xlab(1 "Mar" 5 "Apr" 9 "May" 13 "Jun" 18 "Jul" 22 "Aug" 27 "Sep" 31 "Oct" 35 "Nov" 40 "Dec" 44 "Jan" 48 "Feb", labsize(small)) xscale(range(1 51))/*
*/ ylab(0(0.0001)0.0003 , labsize(small) axis(1)) /*
*/ ylab(0(0.001)0.003   , labsize(small) axis(2)) /*
*/ ytitle("Incidence (America)" , size(small) axis(1)) /* 
*/ ytitle("Incidence (Africa and Oceania)"    , size(small) axis(2)) /* 
*/ xtitle("" , size(small)) /*
*/ legend(order(1 "Africa" 3 "America" 2 "Oceania") row(1) size(vsmall) symxsize(*.5) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(black) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank)) /*
*/ sav("plot_South" , replace)

*** COMBINED GRAPH *************************************************************

graph combine plot_North.gph plot_South.gph /*
*/ , /*
*/ row(1) xsize(8) graphregion(c(white)) 
graph export "figure1.pdf" , replace

*** ERASE AUXILIARY FILES ******************************************************

foreach gr in plot_North plot_South {
	erase `gr'.gph
} 

foreach db in aux_africa_n aux_america_n aux_europe aux_asia aux_africa_s aux_america_s aux_oceania{
	erase `db'.dta
} 

********************************************************************************
* End of do-file
********************************************************************************
