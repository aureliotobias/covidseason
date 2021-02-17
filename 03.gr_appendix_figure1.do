********************************************************************************
* Can SARS-CoV-2 seasonality be determined after one year of pandemic?
* Tobias A, Madaniyazi L, Ng CFS, Seposo X, Hashizume M.
* (submitted for publication).
********************************************************************************
* Do-file for Appendix Figure 1 (version 2021.02.09)
********************************************************************************

* Generate empty dataset for 52 weeks.
clear
set obs 52

* Northern hemispehere.
generate t = _n
generate degrees = (t/52)*360 
fourier degrees , n(3)
regress t sin_1 cos_1
predict p

* Southern hemispehere.
generate t2 = -1*(t-53)
regress t2 sin_1 cos_1
predict p2

* Appendix Figure 1.
twoway (line p t , lw(medthick) lcolor(black) sort) (line p2 t , lw(medthick) lcolor(black) sort lp(dash)) /*
*/ , /*
*/ title(" " , col(black) size(small)) /*
*/ xlab(1 "Jan" 5.3 "Feb" 9.6 "Mar" 13.9 "Abr" 18.2 "May" 22.5 "Jun" 26.8 "Jul" 31.1 "Aug" 35.4 "Sep" 39.7 "Oct" 44 "Nov" 48.3 "Dic" , labsize(small)) /*
*/ ylab(6.5 " " 10.5 "Low" 43 "High" 47 " " , labsize(small) tlength(0) angle(0)) /*
*/ ytitle("Incidence" , size(small)) xtitle("" , size(small)) /*
*/ legend(order(1 "Northern hemisphere" 2 "Southern hemsphere") size(vsmall) symxsize(*.66) region(lstyle(none) lc(white))) /*
*/ plotregion(lc(white) lw(medthin)) graphregion(c(white)) bgcolor(white) ylab(, glp(blank) ) 
graph export "appendix_figure1.pdf" , replace

********************************************************************************
* End of do-file
********************************************************************************
