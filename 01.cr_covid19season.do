********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for data management (version 2021.02.17)
********************************************************************************


********************************************************************************
* IMPORT COVID-19 DATA FROM ECDC
********************************************************************************

import delimited "https://opendata.ecdc.europa.eu/covid19/nationalcasedeath/csv" , clear

********************************************************************************
* DATA MANAGEMENT
********************************************************************************

* Keep COVID-19 cases 
keep if indicator == "cases"

* Drop non-classified data and totals
drop if continent == "Other"
drop if ïcountry == "Africa (total)" | ïcountry == "America (total)" | ïcountry == "Asia (total)" | ïcountry == "EU/EEA (total)" | ïcountry == "Europe (total)" | ïcountry == "Oceania (total)" 

* Merge hemisphere
merge m:1 ïcountry using hemisphere
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

sort ïcountry year week

* Drop weeks before WHO declaration of pandemic (Jan-Feb 2020)
drop if year == 2020 & (week >= 1 & week <= 9)

* Generate time variable to avoid problem with week 53 in Stata
generate t = week    if year==2020
replace  t = week+53 if year==2021
replace  t = t-9  

* Rename, sort and order
rename weekly_count cases
rename population pop
rename ïcountry country
foreach var of varlist country continent hemisphere year week cases pop {
	label var `var' 
}
sort  hemisphere continent country year week
order t year_week datew datem country continent hemisphere year week cases pop
keep  t year_week datew datem country continent hemisphere year week cases pop

* Save dataset for analysis
save "covid19season" , replace

********************************************************************************
* End of do-file 
********************************************************************************
