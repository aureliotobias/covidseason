********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Master do-file (version 2021.02.22)
********************************************************************************


* Install user-developed commands
ssc describe circular
*ssc install circular

* Clean up dataset
do "01.cr_covid19season.do"

* Figure 1
do "02.gr_figure1.do"

* Appendix figures
do "03.gr_appendix_figure1.do"

********************************************************************************
* End of do-file 
********************************************************************************
