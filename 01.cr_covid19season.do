********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for data management (version 2021.02.07)
********************************************************************************


********************************************************************************
* IMPORT COVID-19 DATA FROM ECDC
********************************************************************************

import delimited "https://opendata.ecdc.europa.eu/covid19/casedistribution/csv" , clear

********************************************************************************
* DATA MANAGEMENT
********************************************************************************

* Drop non-classified data
drop if continentexp == "Other"

* Merge hemisphere
merge m:1 countriesandterritories using hemisphere
drop _merge

* Generate date variables
generate YY = substr(year_week, 1, 4)
generate WW = substr(year_week, 6, 2)
generate year = real(YY)
generate week = real(WW)

generate datew = yw(year, week)
format datew %tw
generate datem = mofd(dofw(yw(year, week)))
recode   datem .=731
format datem %tm

sort countriesandterritories year week

* Drop weeks before WHO declaration of pandemic (Jan-Feb 2020)
drop if year == 2020 & (week >= 1 & week <= 9)

* Generate time variable to avoid problem with week 53 in Stata
generate t = week    if year==2020
replace  t = week+53 if year==2021
replace  t = t-9  

* Rename, sort and order
rename cases_weekly cases
rename popdata2019 pop
rename countriesandterritories country
rename continentexp continent
foreach var of varlist country continent hemisphere year week cases pop {
	label var `var' 
}
sort  hemisphere continent country year week
order t daterep year_week datew datem country continent hemisphere year week cases pop
keep  t daterep year_week datew datem country continent hemisphere year week cases pop

* Save dataset for analysis
save "covid19season" , replace

********************************************************************************
* End of do-file 
********************************************************************************
