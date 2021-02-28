********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* Environmental Epidemiology 2021 (accepted for publication).
********************************************************************************
* Master do-file (version 2021.02.28)
********************************************************************************

* Install user-developed commands
ssc describe circular
ssc install  circular

* Clean up dataset
do "01.cr_covid19season.do"

* Figure 1
do "02.gr_figure1.do"

* Supplemental Digital Content
do "03.supplemental_content.do"

********************************************************************************
* End of do-file 
********************************************************************************
