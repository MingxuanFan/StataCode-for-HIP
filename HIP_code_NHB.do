use data.dta, clear
drop if ext==1
*Main 
**Figure 1
cap drop mwat
bysort HIP post_comp time: egen mwat=mean(wat)
bysort HIP post_comp time: gen hcn=_n
tw (line mwat time if HIP==0  & hcn==1) ///
(line mwat time if HIP==1 & post_comp==0  & hcn==1, lp(shortdash)) (line mwat time if HIP==1 & post_comp==1 & hcn==1), legend(lab(1 "non-HIP") lab(2 "HIP pre") lab(3 "HIP post") pos(6)) xtitle(" ") xlabel(612(24)719) ytitle("Monthly Water Consumption (in cubic meter)", axis(1)) scheme(plottig) xsize(3.45) ysize(2.5) ///
legend(pos(6) row(1)) ylabel(,format(%5.0f)) ylabel(12(2)20) 
graph save "Graph" Figure1.gph, replace
graph export Figure1.pdf, replace
graph export Figure1.png, replace

**Figure 2
foreach m in cohort rent rcat flatage ptype mqt male chinese fsize elderly young{
	reghdfe ln_wat 1.post_comp#i.`m' 1.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)  compact poolsize(5)
	eststo het_`m'
}

***Figure 2a
coefplot het_cohort, /// 
keep(1.post_comp#*) ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) omitted ///
coeflabels(1.post_comp#2011.cohort="2011" 1.post_comp#2012.cohort="2012" 1.post_comp#2013.cohort="2013" 1.post_comp#2014.cohort="2014" 1.post_comp#2015.cohort="2015" 1.post_comp#2016.cohort="2016" 1.post_comp#2017.cohort="2017" 1.post_comp#2018.cohort="2018" 1.post_comp#2019.cohort="2019") legend(off) base
graph save "Graph" het_cohort.gph, replace

graph use het_cohort.gph
gr_edit .b1title.text = {`"(a) By year of HIP completion"'}
graph save het_cohort.gph, replace
graph export Figure2a.pdf, replace	
graph export Figure2a.png, replace

***Figure 2b
coefplot het_ptype,  keep(1.post_comp#*) ///
scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of  monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) omitted ///
coeflabels(1.post_comp#1.ptype="1-/2-room" 1.post_comp#2.ptype="3-room" 1.post_comp#3.ptype="4-room" 1.post_comp#4.ptype="5-room/Executive") legend(off) base
graph save "Graph" het_ptype.gph, replace

graph use het_ptype.gph
gr_edit .b1title.text = {`"(b) By flat type "'}
graph save het_ptype.gph, replace
graph export Figure2b.pdf, replace	
graph export Figure2b.png, replace

***Figure 2c
coefplot het_age, keep(1.post_comp#*) ///
ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) omitted ///
coeflabels(1.post_comp#1.flatage="Before 1979" 1.post_comp#2.flatage="1979-1983" 1.post_comp#3.flatage="1984-1986") legend(off) base
graph save "Graph" het_age.gph, replace

graph use het_age.gph
gr_edit .b1title.text = {`"(c) By flat age "'}
graph save het_age.gph, replace
graph export Figure2c.pdf, replace	
graph export Figure2c.png, replace

***Figure 2d
coefplot het_rent, keep(1.post_comp#*) ///
ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) omitted coeflabels(1.post_comp#0.rent="HDB own" 1.post_comp#1.rent="HDB rent") legend(off) base
graph save "Graph" het_rent.gph, replace

graph use het_rent.gph
gr_edit .b1title.text = {`"(d) By flat ownership"'}
graph save het_rent.gph, replace
graph export Figure2d.pdf, replace	
graph export Figure2d.png, replace

***Figure 2e
coefplot hetrcat, keep(1.post_comp#*) ///
 ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) omitted coeflabels(1.post_comp#1.rcat="Q1" 1.post_comp#2.rcat="Q2" 1.post_comp#3.rcat="Q3" 1.post_comp#4.rcat="Q4") legend(off) base
graph save "Graph" het_rcat.gph, replace

graph use het_rcat.gph
gr_edit .b1title.text = {`"(e) By % of rental flats"'}
graph save het_rcat.gph, replace
graph export Figure2e.pdf, replace	
graph export Figure2e.png, replace


***Figure 2f
coefplot het_mqt, keep(1.post_comp#*) ///
ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of  monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) omitted ///
coeflabels(1.post_comp#1.mqt="Q1:(0,9.05]" 1.post_comp#2.mqt="Q2:(9.05,14.7]"1.post_comp#3.mqt="Q3:(14.7,21.5]" 1.post_comp#4.mqt="Q4:(21.5,66.5]") legend(off) base
graph save "Graph" het_mqt.gph, replace

graph use het_mqt.gph
gr_edit .b1title.text = {`"(f) By water consumption "'}
graph save het_mqt.gph, replace
graph export Figure2f.pdf, replace	
graph export Figure2f.png, replace

***Figure 2g-2k
foreach v in male chinese fsize elderly young{
coefplot het_`v', keep(1.post_comp#*) ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.06(0.02)0.02,format(%5.2f)) yline(0) base legend(off) coeflabels(1.post_comp#1.`v'="Q1" 1.post_comp#2.`v'="Q2" 1.post_comp#3.`v'="Q3" 1.post_comp#4.`v'="Q4") omitted
graph save "Graph" het_`v'.gph, replace
}

graph use het_fsize.gph
gr_edit .b1title.text = {`"(g) By family size"'}
graph save het_fsize.gph, replace
graph export Figure2g.pdf, replace	
graph export Figure2g.png, replace

graph use het_male.gph
gr_edit .b1title.text = {`"(h) By % of male"'}
graph save het_male.gph, replace
graph export Figure2h.pdf, replace	
graph export Figure2h.png, replace

graph use het_chinese.gph
gr_edit .b1title.text = {`"(i) By % of Chinese"'}
graph save het_chinese.gph, replace
graph export Figure2i.pdf, replace	
graph export Figure2i.png, replace

graph use het_elderly.gph
gr_edit .b1title.text = {`"(j) By % of elderly"'}
graph save het_elderly.gph, replace
graph export Figure2j.pdf, replace	
graph export Figure2j.png, replace

graph use het_young.gph
gr_edit .b1title.text = {`"(k) By % of young family"'}
graph save het_young.gph, replace
graph export Figure2k.pdf, replace	
graph export Figure2k.png, replace

***Combine
foreach m in het_cohort het_rent het_rcat het_ptype het_age het_mqt het_fsize het_male het_chinese het_elderly het_young{
	graph use `m'
}

graph combine het_cohort het_ptype het_age het_rent het_rcat het_mqt het_fsize het_male het_chinese het_elderly het_young, row(3) xsize(7) ysize(3.8) graphregion(color(white)) ycommon
graph save "Graph" Figure2.gph, replace
graph export Figure2.pdf, replace
graph export Figure2.png, replace

**Figure 3
gen distance=time-time_HIPcomp
cap drop distance_year
gen distance_year=distance/12
replace distance_year=floor(distance_year) if distance_year<0
replace distance_year=ceil(distance_year) if distance_year>0
replace distance_year=0 if distance_year==.
replace distance_year=10 if distance_year>10
replace distance_year=distance_year+10

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time if ext!=1, absorb(i.premiseno i.time) cluster(pcode time) compact poolsize(5)
eststo baseline

reghdfe ln_wat 1.HIP#ib10.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time) compact poolsize(5)
eststo event
coefplot event, keep(1.HIP#*.distance_year) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.08(0.02)0.08,format(%5.2f)) yline(0) yline(-0.035, lc(gray) ls(solid)) yline(-0.031, lc(gray)) yline(-0.037, lc(gray)) base legend(off) coeflabels(1.HIP#1.distance_year="T-9" 1.HIP#2.distance_year="T-8" 1.HIP#3.distance_year="T-7" 1.HIP#4.distance_year="T-6" 1.HIP#5.distance_year="T-5" 1.HIP#6.distance_year="T-4" 1.HIP#7.distance_year="T-3" 1.HIP#8.distance_year="T-2" 1.HIP#9.distance_year="T-1" 1.HIP#10.distance_year="T0" 1.HIP#11.distance_year="T+1" 1.HIP#12.distance_year="T+2" 1.HIP#13.distance_year="T+3" 1.HIP#14.distance_year="T+4" 1.HIP#15.distance_year="T+5" 1.HIP#16.distance_year="T+6" 1.HIP#17.distance_year="T+7" 1.HIP#18.distance_year="T+8" 1.HIP#19.distance_year="T+9" 1.HIP#20.distance_year="T+10", angle(90)) omitted offset(0) xline(10) 
graph save "Graph" Figure2.gph, replace
graph export Figure3.pdf, replace	
graph export Figure3.png, replace	


**Figure 4
reghdfe ln_wat post_comp 1.post_comp#1.post 1.post_comp#1.pchg ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time) compact poolsize(5)
eststo twopolicy
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"

coefplot twopolicy, ///
keep(1.post_comp#1.post 1.post_comp#1.pchg) ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.02(0.01)0.02,format(%5.2f)) yline(0) omitted ///
coeflabels(1.post_comp#1.post="Post HIP * Post peer comparison" 1.post_comp#1.pchg="Post HIP * Post price increase") legend(off) base 
graph save "Graph" Figure4.gph, replace
graph export Figure4.pdf, replace
graph export Figure4.png, replace

**Figure 5
gen temp_high=(temp_mean_r10km>28.9)
gen rain_high=(rain_days_r10km>22.3)
gen psi_high=(psi_r10km>=100) 

foreach v in temp rain psi{
reghdfe ln_wat 1.post_comp i.group#1.`v'_high temp_high rain_high psi_high 1.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time) compact poolsize(5)
eststo `v'_plot
coefplot `v'_plot, ///
keep(*.group*) ciopts(recast(rcap)) scheme(plottig) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.02(0.01)0.02,format(%5.2f)) yline(0) omitted ///
coeflabels(1.group#1.`v'_high="Non-HIP" 2.group#1.`v'_high="HIP pre" 3.group#1.`v'_high="HIP post") legend(off) base 
graph save "Graph" climate_`v'_high.gph, replace
}

graph use climate_temp_high.gph
gr_edit .b1title.text = {`"(a) Mean temperature "'}
graph save climate_temp_high.gph, replace
graph export Figure5a.pdf, replace
graph export Figure5a.png, replace

graph use climate_rain_high.gph
gr_edit .b1title.text = {`"(b) Number of rainy days"'}
graph save climate_rain_high.gph, replace
graph export Figure5b.pdf, replace
graph export Figure5b.png, replace

graph use climate_psi_high.gph
gr_edit .b1title.text = {`"(c) Mean PSI"'}
graph save climate_psi_high.gph, replace
graph export Figure5c.pdf, replace
graph export Figure5c.png, replace

foreach m in climate_temp_high climate_rain_high climate_psi_high{
	graph use `m'
}
graph combine climate_temp_high climate_rain_high climate_psi_high, row(2) xsize(3.45) ysize(2.5) graphregion(color(white)) ycommon
graph save "Graph" Figure5.gph, replace
graph export Figure5.pdf, replace
graph export Figure5.png, replace


**Figure 6
gen post=(time>=679)
bysort premiseno post: egen  hhmean=mean(wat)
cap drop cn
bysort premiseno (time): gen cn=_n
replace cn=. if cn!=1
egen decile=xtile(hhmean), by(cn) nq(10)
replace decile=. if cn!=1
bysort premiseno (time): replace decile=decile[1]
gen drought=(time>681)
gen pchg=(time>689)

reghdfe ln_wat 1.post drought pchg ln_temp ln_rain ln_psi time, absorb(i.premiseno i.month) cluster(pcode time) compact poolsize(5)
eststo bill_base

***Figure 6a
reghdfe ln_wat 1.post#i.decile drought pchg ln_temp ln_rain ln_psi time, absorb(i.premiseno i.month) cluster(pcode time) compact poolsize(5)
eststo decile
coefplot decile, keep(1.post#*.decile ) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) yline(-0.003,linestyle(pattern(solid) color(gray))) yline(-0.012,linestyle(color(gray))) yline(-0.006,linestyle(color(gray))) omitted baselevels coeflabels(1.post#1.decile="1" 1.post#2.decile="2" 1.post#3.decile="3" 1.post#4.decile="4" 1.post#5.decile="5" 1.post#6.decile="6" 1.post#7.decile="7" 1.post#8.decile="8" 1.post#9.decile="9" 1.post#10.decile="10") 
graph save billupdate_decile.gph, replace

gr_edit .b1title.text = {`"(a) By decile of baseline water consumption"'}
graph save billupdate_decile.gph, replace
graph export Figure6a.pdf, replace
graph export Figure6a.png, replace

***Figure 6b
bysort pcode ptype time: egen nb=mean(wat)
bysort time: egen nt=mean(wat)
gen above_nt=(wat>nt)
gen above_nb=(wat>nb)
bysort premiseno (time): gen above_nt_lag=above_nt[_n-1]
bysort premiseno (time): gen above_nb_lag=above_nb[_n-1]

gen message=1 if above_nt_lag==0 & above_nb_lag==0
replace message=2 if above_nt_lag==1 & above_nb_lag==0
replace message=3 if above_nt_lag==0 & above_nb_lag==1
replace message=4 if above_nt_lag==1 & above_nb_lag==1

reghdfe ln_wat 1.post#i.message drought pchg ln_temp ln_rain ln_psi time, absorb(i.premiseno i.month) cluster(pcode time) compact poolsize(5)
eststo message 

coefplot message, keep(1.post#*.message ) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45)  ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(-0.003,linestyle(pattern(solid) color(gray))) yline(-0.012,linestyle(color(gray))) yline(-0.006,linestyle(color(gray))) omitted xtitle(" ") baselevels coeflabels(1.post#1.message = `""<neighorhood" "<national""' 1.post#2.message = `""<neighorhood" ">national""' 1.post#3.message = `"">neighorhood" "<national ""' 1.post#4.message = `"">neighorhood" ">national""') 
graph save billupdate_message.gph, replace

gr_edit .b1title.text = {`"(b) By message received"'}
graph save billupdate_message.gph, replace
graph export Figure6b.pdf, replace
graph export Figure6b.png, replace

***combine
graph combine billupdate_decile billupdate_message, row(2) xsize(3.45) ysize(5) graphregion(color(white)) ycommon

graph save "Graph" Figure6.gph, replace
graph export Figure6.pdf, replace
graph export Figure6.png, replace

graph combine billupdate_decile_baseline billupdate_message_baseline, row(2) xsize(3.45) ysize(5) graphregion(color(white)) ycommon

graph save "Graph" Figure6_baseline.gph, replace
graph export Figure6_baseline.pdf, replace
graph export Figure6_baseline.png, replace

**Figure 7

foreach v in decile ptype post_comp{
  reghdfe ln_wat 1.post#i.message#i.`v' ann pchg time ln_temp ln_rain ln_psi, absorb(i.premiseno i.month) cluster(pcode time) compact poolsize(5)
  eststo bm_`v'
}

***Figure 7a-d
coefplot bm_decile, keep(1.post#1.message#1.decile 1.post#1.message#2.decile 1.post#1.message#3.decile 1.post#1.message#4.decile  1.post#1.message#5.decile 1.post#1.message#6.decile 1.post#1.message#7.decile 1.post#1.message#8.decile 1.post#1.message#9.decile 1.post#1.message#10.decile) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) omitted baselevels coeflabels(1.post#*.message#1.decile="1" 1.post#*.message#2.decile="2" 1.post#*.message#3.decile="3" 1.post#*.message#4.decile="4" 1.post#*.message#5.decile="5" 1.post#*.message#6.decile="6" 1.post#*.message#7.decile="7" 1.post#*.message#8.decile="8" 1.post#*.message#9.decile="9" 1.post#*.message#10.decile="10")  

		
graph save bm1_decile.gph, replace
gr_edit .b1title.text = {`"(a) By decile: message 1"'}
graph save bm1_decile.gph, replace
graph export Figure7a.pdf, replace
graph export Figure7a.png, replace

coefplot bm_decile, keep(1.post#2.message#1.decile 1.post#2.message#2.decile 1.post#2.message#3.decile 1.post#2.message#4.decile 1.post#2.message#5.decile 1.post#2.message#6.decile 1.post#2.message#7.decile 1.post#2.message#8.decile 1.post#2.message#9.decile 1.post#2.message#10.decile) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) omitted baselevels coeflabels(1.post#*.message#1.decile="1" 1.post#*.message#2.decile="2" 1.post#*.message#3.decile="3" 1.post#*.message#4.decile="4" 1.post#*.message#5.decile="5" 1.post#*.message#6.decile="6" 1.post#*.message#7.decile="7" 1.post#*.message#8.decile="8" 1.post#*.message#9.decile="9" 1.post#*.message#10.decile="10")  
graph save bm2_decile.gph, replace
gr_edit .b1title.text = {`"(b) By decile: message 2"'}
graph save bm2_decile.gph, replace
graph export Figure7b.pdf, replace
graph export Figure7b.png, replace

coefplot bm_decile, keep(1.post#3.message#1.decile 1.post#3.message#2.decile 1.post#3.message#3.decile 1.post#3.message#4.decile 1.post#3.message#5.decile 1.post#3.message#6.decile 1.post#3.message#7.decile 1.post#3.message#8.decile 1.post#3.message#9.decile 1.post#3.message#10.decile)  scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) omitted baselevels coeflabels(1.post#*.message#1.decile="1" 1.post#*.message#2.decile="2" 1.post#*.message#3.decile="3" 1.post#*.message#4.decile="4" 1.post#*.message#5.decile="5" 1.post#*.message#6.decile="6" 1.post#*.message#7.decile="7" 1.post#*.message#8.decile="8" 1.post#*.message#9.decile="9" 1.post#*.message#10.decile="10")  
graph save bm3_decile.gph, replace
gr_edit .b1title.text = {`"(c) By decile: message 3"'}
graph save bm3_decile.gph, replace
graph export Figure7c.pdf, replace
graph export Figure7c.png, replace

coefplot bm_decile, keep( 1.post#4.message#1.decile  1.post#4.message#2.decile  1.post#4.message#3.decile  1.post#4.message#4.decile  1.post#4.message#5.decile 1.post#4.message#6.decile 1.post#4.message#7.decile 1.post#4.message#8.decile 1.post#4.message#9.decile  1.post#4.message#10.decile) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) omitted baselevels coeflabels(1.post#*.message#1.decile="1" 1.post#*.message#2.decile="2" 1.post#*.message#3.decile="3" 1.post#*.message#4.decile="4" 1.post#*.message#5.decile="5" 1.post#*.message#6.decile="6" 1.post#*.message#7.decile="7" 1.post#*.message#8.decile="8" 1.post#*.message#9.decile="9" 1.post#*.message#10.decile="10")
graph save bm4_decile.gph, replace
gr_edit .b1title.text = {`"(d) By decile: message 4"'}
graph save bm4_decile.gph, replace
graph export Figure7d.pdf, replace
graph export Figure7d.png, replace

***Figure 7e-h
foreach i of num 1/4{
coefplot bm_ptype, keep(1.post#`i'.message#*.ptype) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) omitted baselevels xlabel(1 "1-/2-room" 2 "3-room" 3 "4-room" 4 "5-room/Executive") 
graph save bm`i'_ptype.gph, replace
}

graph use bm1_ptype.gph
gr_edit .b1title.text = {`"(e) By flat type: message 1"'}
graph save bm1_ptype.gph, replace
graph export Figure7e.pdf, replace
graph export Figure7e.png, replace

graph use bm2_ptype.gph
gr_edit .b1title.text = {`"(f) By flat type: message 2"'}
graph save bm2_ptype.gph, replace
graph export Figure7f.pdf, replace
graph export Figure7f.png, replace

graph use bm3_ptype.gph
gr_edit .b1title.text = {`"(g) By flat type: message 3"'}
graph save bm3_ptype.gph, replace
graph export Figure7g.pdf, replace
graph export Figure7g.png, replace

graph use bm4_ptype.gph
gr_edit .b1title.text = {`"(h) By flat type: message 4"'}
graph save bm4_ptype.gph, replace
graph export Figure7h.pdf, replace
graph export Figure7h.png, replace

***Figure 7i-l
foreach i of num 1/4{
coefplot bm_post_comp, keep(1.post#`i'.message#*.post_comp) scheme(plottig) mc(black) ciopts(lcolor(black) recast(rcap)) offset(0) legend(off) vertical ytitle("Log of monthly water consumption") yline(0) ysize(2.5) xsize(3.45) ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) omitted baselevels xlabel(1 "non-HIP" 2 "HIP") 
graph save bm`i'_HIP.gph", replace
}


graph use bm1_HIP.gph
gr_edit .b1title.text = {`"(i) By HIP status: message 1"'}
graph save bm1_HIP.gph, replace
graph export Figure7i.pdf, replace
graph export Figure7i.png, replace

graph use bm2_HIP.gph
gr_edit .b1title.text = {`"(j) By HIP status: message 2"'}
graph save bm2_HIP.gph, replace
graph export Figure7j.pdf, replace
graph export Figure7j.png, replace

graph use bm3_HIP.gph
gr_edit .b1title.text = {`"(k) By HIP status: message 3"'}
graph save bm3_HIP.gph, replace
graph export Figure7k.pdf, replace
graph export Figure7k.png, replace

graph use bm4_HIP.gph
gr_edit .b1title.text = {`"(l) By HIP status: message 4"'}
graph save bm4_HIP.gph, replace
graph export Figure7l.pdf, replace
graph export Figure7l.png, replace

***combine
foreach i of num 1/4{
	foreach v in decile ptype HIP{
		graph use bm`i'_`v'.gph
	}
}
graph combine bm1_decile bm2_decile bm3_decile bm4_decile bm1_ptype Graph bm3_ptype bm4_ptype bm1_HIP bm2_HIP bm3_HIP bm4_HIP, row(3) xsize(7) ysize(3.8) graphregion(color(white)) ycommon
graph save "Graph" Figure7.gph, replace
graph export Figure7.pdf, replace
graph export Figure7.png, replace


******************
*Extended Figures
**Figure 2
use data, clear
drop if ext==1
keep if time_HIPcomp!=.
cap drop cn
bysort premiseno: gen cn=_n
keep if cn==1
tab region, gen(r)
cap drop year
gen year=year(dofm(time_HIPcomp))
graph bar (sum) r1 r2 r3 r4 r5  if year<=2019, over(year) stack legend(pos(6) row(1) lab(1 "Central") lab(2 "East") lab(3 "North") lab(4 "North-east") lab(5 "West")) ytitle("Percent") ysize(2.6) xsize(3.575) ytitle(Number of HDB flats) ylabel(0(20000)100000,format(%5.0f))
graph save "Graph" Extended_figure2.gph", replace
graph export Extended_figure2.tif, replace

**Figure 3
use data, clear
drop if ext==1
bysort pcode (time): gen pcn=_n
keep if pcn==1


foreach v in flatage ptype fsize {
cap drop median 
cap drop upq 
cap drop loq 
cap drop iqr 
cap drop upper 
cap drop lower 
cap drop mean
  egen median = median(`v'), by(HIP)
  egen upq = pctile(`v'), p(75) by(HIP)
  egen loq = pctile(`v'), p(25) by(HIP)
  egen iqr = iqr(`v'), by(HIP)
  egen upper = max(min(`v', upq + 1.5 * iqr)), by(HIP)
  egen lower = min(max(`v', loq - 1.5 * iqr)), by(HIP)
  egen mean = mean(`v'), by(HIP)
  
 twoway rbar med upq HIP, pstyle(p1) blc(gs15) bfc(gs8) barw(0.35) || ///
 rbar med loq HIP, pstyle(p1) blc(gs15) bfc(gs8) barw(0.35) || ///
 rspike upq upper HIP, pstyle(p1) || ///
 rspike loq lower HIP, pstyle(p1) || ///
 rcap upper upper HIP, pstyle(p1) msize(*2) || ///
 rcap lower lower HIP, pstyle(p1) msize(*2) || ///
 scatter `v' HIP if !inrange(`v', lower, upper), ms(Oh) || ///
 scatter mean HIP, ms(Oh) ///
 legend(off) xlab(0 "non-HIP" 1 "HIP") xtitle("") xscale(range(-1,2)) scheme(plottig)
 graph save `v'_HIP.gph, replace
}

foreach v in gender ethnicity elderly young{
cap drop median 
cap drop upq 
cap drop loq 
cap drop iqr 
cap drop upper 
cap drop lower 
cap drop mean
  egen median = median(`v'), by(HIP)
  egen upq = pctile(`v'), p(75) by(HIP)
  egen loq = pctile(`v'), p(25) by(HIP)
  egen iqr = iqr(`v'), by(HIP)
  egen upper = max(min(`v', upq + 1.5 * iqr)), by(HIP)
  egen lower = min(max(`v', loq - 1.5 * iqr)), by(HIP)
  egen mean = mean(`v'), by(HIP)
  
 twoway rbar med upq HIP, pstyle(p1) blc(gs15) bfc(gs8) barw(0.35) || ///
 rbar med loq HIP, pstyle(p1) blc(gs15) bfc(gs8) barw(0.35) || ///
 rspike upq upper HIP, pstyle(p1) || ///
 rspike loq lower HIP, pstyle(p1) || ///
 rcap upper upper HIP, pstyle(p1) msize(*2) || ///
 rcap lower lower HIP, pstyle(p1) msize(*2) || ///
 scatter `v' HIP if !inrange(`v', lower, upper), ms(Oh) || ///
 scatter mean HIP, ms(Oh) ///
 legend(off) xlab(0 "non-HIP" 1 "HIP") xtitle("") xscale(range(-1,2)) scheme(plottig) yscale(range(0,1))
 graph save `v'_HIP.gph, replace
}

foreach v in ptype flatage fsize gender ethnicity elderly young{
	graph use `v'_HIP
	gr_edit .style.editstyle declared_ysize(2.5) editcopy
    gr_edit .style.editstyle declared_xsize(3.45) editcopy
	graph save `v'_HIP,replace
}
graph use ptype_HIP
gr_edit .yaxis1.title.text = {`"Flat size"'}
gr_edit .b1title.text = {`"(a) Flat size"'}
graph save ptype_HIP, replace

graph use flatage_HIP
gr_edit .yaxis1.title.text = {`"Year of completion"'}
gr_edit .b1title.text = {`"(b) Year of completion"'}
graph save flatage_HIP, replace

graph use fsize_HIP
gr_edit .yaxis1.title.text = {`"Family size"'}
gr_edit .b1title.text = {`"(c) Family size"'}
graph save fsize_HIP, replace

graph use gender_HIP
gr_edit .yaxis1.title.text = {`"Proportion of male"'}
gr_edit .b1title.text = {`"(d) Proportion of male"'}
graph save gender_HIP, replace

graph use ethnicity_HIP
gr_edit .yaxis1.title.text = {`"Proportion of Chinese"'}
gr_edit .b1title.text = {`"(e) Proportion of Chinese"'}
graph save ethnicity_HIP, replace

graph use elderly_HIP
gr_edit .yaxis1.title.text = {`"Proportion of elderly"'}
gr_edit .b1title.text = {`"(f) Proportion of elderly"'}
graph save elderly_HIP, replace

graph use young_HIP
gr_edit .yaxis1.title.text = {`"Proportion of young family"'}
gr_edit .b1title.text = {`"(g) Proportion of young family"'}
graph save young_HIP, replace

foreach v in ptype flatage fsize gender ethnicity elderly young{
	graph use `v'_HIP
	graph export `v'_HIP.tif,replace
}
graph combine ptype_HIP flatage_HIP fsize_HIP gender_HIP ethnicity_HIP elderly_HIP young_HIP, row(2) xsize(7) ysize(2.6) graphregion(color(white))
graph save "Graph" Extended_figure3.gph, replace
graph export Extended_figure3.pdf, replace
graph export Extended_figure3.tif, replace


**Figure 4
use data.dta, clear
drop if ext==1
bysort pcode (time): gen pcn=_n
keep if pcn==1
gen HIP_year=1960+floor(time_HIPcomp/12)

foreach v in ptype flatage gender ethnicity elderly young fsize{
	gen se_`v'=`v'
}

collapse (mean) ptype flatage gender ethnicity elderly young fsize (semean) se_ptype se_flatage se_gender se_ethnicity se_elderly se_young se_fsize , by(HIP_year)
drop if year_complete==.
foreach v in ptype flatage gender ethnicity elderly young fsize{
	gen `v'_upp=`v'+1.96*se_`v'
    gen `v'_low=`v'-1.96*se_`v'
}
tw  (line flatage HIP_year) (line flatage_upp HIP_year, lc(black) lp(dot)) (line flatage_low HIP_year, lc(black) lp(dot)), ytitle("Mean year of flat completion") legend(off) scheme(plottig)
graph save flatage_HIPyear.gph, replace

tw (line ptype HIP_year) (line ptype_upp HIP_year, lc(black) lp(dot)) (line ptype_low HIP_year, lc(black) lp(dot)), ytitle("Mean number of rooms") ylab(1(1)5) legend(off) scheme(plottig)
graph save ptype_HIPyear.gph, replace

tw (line gender HIP_year) (line gender_upp HIP_year, lc(black) lp(dot)) (line gender_low HIP_year, lc(black) lp(dot)), ytitle("Mean proportion of male") ylab(0(0.2)1) legend(off) scheme(plottig)
graph save gender_HIPyear.gph, replace

tw (line ethnicity HIP_year) (line ethnicity_upp HIP_year, lc(black) lp(dot)) (line ethnicity_upp HIP_year, lc(black) lp(dot)),  ytitle("Mean proportion of Chinese") ylab(0(0.2)1) legend(off) scheme(plottig)
graph save ethnicity_HIPyear.gph, replace

tw (line elderly HIP_year) (line elderly_upp HIP_year, lc(black) lp(dot)) (line elderly_low HIP_year, lc(black) lp(dot)), ytitle("Mean proportion of elderly") ylab(0(0.2)1) legend(off) scheme(plottig)
graph save elderly_HIPyear.gph, replace

tw  (line young HIP_year) (line young_upp HIP_year, lc(black) lp(dot)) (line young_low HIP_year, lc(black) lp(dot)),  ytitle("Mean proportion of young") ylab(0(0.2)1) legend(off) scheme(plottig)
graph save young_HIPyear.gph, replace

tw (line fsize HIP_year) (line fsize_upp HIP_year, lc(black) lp(dot)) (line fsize_low HIP_year, lc(black) lp(dot)), ytitle("Mean family size") ylab(1(1)5) legend(off) scheme(plottig)
graph save fsize_HIPyear.gph,replace 


foreach v in ptype flatage fsize gender ethnicity elderly young{
	graph use `v'_HIPyear
	gr_edit .style.editstyle declared_ysize(2.5) editcopy
    gr_edit .style.editstyle declared_xsize(3.45) editcopy
	graph save `v'_HIPyear
}
graph use ptype_HIPyear
gr_edit .b1title.text = {`"(a) Mean flat size"'}
graph save ptype_HIPyear, replace

graph use flatage_HIPyear
gr_edit .b1title.text = {`"(b) Mean flat age"'}
graph save flatage_HIPyear, replace

graph use fsize_HIPyear
gr_edit .b1title.text = {`"(c) Mean family size"'}
graph save fsize_HIPyear, replace

graph use gender_HIPyear
gr_edit .b1title.text = {`"(d) Mean proportion of male"'}
graph save gender_HIPyear, replace

graph use ethnicity_HIPyear
gr_edit .b1title.text = {`"(e) Mean proportion of Chinese"'}
graph save ethnicity_HIPyear, replace

graph use elderly_HIPyear
gr_edit .b1title.text = {`"(f) Mean proportion of elderly"'}
graph save elderly_HIPyear, replace

graph use young_HIPyear
gr_edit .b1title.text = {`"(g) Mean proportion of young family"'}
graph save young_HIPyear, replace

foreach v in ptype flatage fsize gender ethnicity elderly young{
	graph use `v'_HIPyear
	graph export `v'_HIPyear.tif
}

graph combine ptype_HIPyear flatage_HIPyear fsize_HIPyear gender_HIPyear ethnicity_HIPyear elderly_HIPyear young_HIPyear, row(2) xsize(7) ysize(2.6) graphregion(color(white))
graph save "Graph" Extended_figure4.gph, replace
graph export Extended_figure4.pdf, replace
graph export Extended_figure4.tif, replace

**Figure 5
use resale.dta, clear
gen cn=1
collapse (sum) cn, by(dist)
keep if dist<24 & dist>-24
tw (lfitci cn dist if dist<=0, color("white%80"))  (lfitci cn dist if dist>0, color("white%80")) (lfit cn dist if dist<=0, lc(gray))  (lfit cn dist if dist>=0, lc(gray)) (scatter cn dist, mc(gray)), legend(off) ylab(0(200)800) xlab(-24(12)24) xline(0) xtitle("Distance to HIP completion (in months)") ytitle("Number of resale flats") ysize(2.5) xsize(3.45) scheme(plottig)
graph save resale_hiprd.gph, replace
graph export Extended_figure5.pdf, replace
graph export Extended_figure5.tif, replace

**Figure 6
use data.dta, clear
drop if ext==1
gen distance=time-time_HIPcomp
cap drop distance_year
gen distance_year=distance/12
replace distance_year=floor(distance_year) if distance_year<0
replace distance_year=ceil(distance_year) if distance_year>0
replace distance_year=0 if distance_year==. | distance_year<0
replace distance_year=10 if distance_year>10
replace distance_year=distance_year+10

foreach i of num 2011/2019{
reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time if cohort==`i', absorb(i.premiseno i.time) cluster(pcode time)  compact poolsize(5)
eststo HIP`i'
coefplot HIP`i',  keep(1.HIP#*.distance_year) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") ylabel(-0.08(0.02)0.08,format(%5.2f)) yline(0) base legend(off) coeflabels(1.HIP#1.distance_year="Before" 1.HIP#2.distance_year="T+1" 1.HIP#3.distance_year="T+2" 1.HIP#4.distance_year="T+3" 1.HIP#5.distance_year="T+4" 1.HIP#6.distance_year="T+5" 1.HIP#7.distance_year="T+6" 1.HIP#8.distance_year="T+7" 1.HIP#9.distance_year="T+8" 1.HIP#10.distance_year="T+9" 1.HIP#11.distance_year="T+10", angle(90)) omitted offset(0) xline(10) 
graph save event_`i'.gph, replace
graph export event_`i'.tif, replace
}

local vlist `c(alpha)'
foreach i of num 2011/2018{
         local j=`i'-2010
         local seq `: word `j' of `vlist''
          graph use event_`i'.gph
		  gr_edit .title.text = {}
		  gr_edit .style.editstyle declared_ysize(2.5) editcopy
          gr_edit .style.editstyle declared_xsize(3.45) editcopy
		  gr_edit .b1title.text = {`"(`seq') HIP completed in `i'"'}
		  
  graph save event_`i'.gph, replace
  graph export Extended_figure6`seq'.tif, replace
  }

foreach i of num 2011/2018{
	graph use event_`i'
}
graph combine event_2011 event_2012 event_2013 event_2014 event_2015 event_2016 event_2017 event_2018, row(2) xsize(7) ysize(2.6) graphregion(color(white))
graph save "Graph" Extended_figure6.gph, replace
graph export Extended_figure6.pdf, replace
graph export Extended_figure6.tif, replace

**Figure 7
***Distribution
hist temp_mean_r10km, xline(28.9) xtitle("") title("Distribution of mean monthly temperature") scheme(plottig) percent ylabel(0(2)8) start(25.3) width(0.1)
graph save "Graph" dist_temp.gph, replace
hist rain_days_r10km, xline(22.3) xtitle("") title("Distribution of number of rainy days") scheme(plottig) percent ylabel(0(2)8) width(0.5)
graph save "Graph" dist_rain.gph, replace
hist psi_r10km, xline(100) xtitle("") title("Distribution of PSI") scheme(plottig) percent ylabel(0(2)8) width(1.5)
graph save "Graph" dist_PSI.gph, replace

***Mean & SD
bysort time: egen wmtemp=mean(temp_mean_r10km)
bysort time: egen wmrain=mean(rain_days_r10km)
bysort time: egen sdtemp=sd(temp_mean_r10km)
bysort time: egen sdrain=sd(rain_days_r10km)
bysort time: egen mpsi=mean(psi_r10km)
bysort time: egen sdpsi=sd(psi_r10km)

tw (line wmtemp time if cn==1), scheme(plottig) ylabel(25(1)30) xlabel(612(24)708)  legend(off) title("Mean temperature") ytitle("Temperature in degree celsius") xtitle("") saving(trend_temp.gph, replace)
tw (line sdtemp time if cn==1), scheme(plottig) ylabel(0(0.2)0.8)  xlabel(612(24)708) title("Standard deviation of mean temperature") ytitle("Temperature in degree celsius") xtitle("")  saving(sd_temp.gph, replace)
tw (line wmrain time if cn==1), scheme(plottig) ylabel(0(5)30)  xlabel(612(24)708) legend(off) ytitle("Number of rain days") title("Mean number of rain days") xtitle("") saving(trend_rain.gph, replace)
tw (line sdrain time if cn==1), scheme(plottig) ylabel(0(1)4)  xlabel(612(24)708) title("Standard deviation of number of rain days") ytitle("Number of rain days") xtitle("")  saving(sd_rain.gph, replace)
tw (line mpsi time if cn==1), scheme(plottig) ylabel(0(20)120) xlabel(612(24)708)  legend(off) title("Mean PSI") ytitle("PSI") xtitle("") saving(trend_psi.gph, replace)
tw (line sdpsi time if cn==1), scheme(plottig) ylabel(0(1)5)  xlabel(612(24)708) title("Standard deviation of PSI") ytitle("PSI") xtitle("")  saving(sd_psi.gph, replace)

foreach i in dist trend sd{
	foreach j in temp rain psi{
		graph use `i'_`j'
		gr_edit .style.editstyle declared_ysize(2.5) editcopy
        gr_edit .style.editstyle declared_xsize(3.45) editcopy
		graph save `i'_`j', replace
	}
}

***combine
graph combine dist_temp trend_temp sd_temp, row(1) xsize(7) ysize(1.6) graphregion(color(white)) title("(a) Distribution, mean and standard deviation: temperature", pos(6) size(medium)) name(temp,replace)
graph combine dist_rain trend_rain sd_rain, row(1) xsize(7) ysize(1.6) graphregion(color(white)) title("(b) Distribution, mean and standard deviation: number of rainy days", pos(6) size(medium)) name(rain,replace)
graph combine dist_psi trend_psi sd_psi, row(1) xsize(7) ysize(1.6) graphregion(color(white)) title("(c) Distribution, mean and standard deviation: PSI", pos(6) size(medium)) name(psi,replace)
graph combine temp rain psi, row(3) xsize(7) ysize(4.8) graphregion(color(white)) scheme(plottig)
graph save "Graph" Extended_figure7.gph, replace
graph export Extended_figure7.pdf, replace
graph export Extended_figure7.tif, replace

**Figure 9
gen d0=0
gen d1=(time==679)
gen d2=(time==680)
gen d3=(time==681)
gen d4=(time==682)
gen d5=(time==683)
gen d6=(time==684)
gen d7=(time==685)
gen d8=(time==686)
gen d9=(time==687)
gen d10=(time==688)
gen d11=(time==689)
gen d12=(time==690)
gen d13=(time==691)
gen after=(time>691)

reghdfe ln_wat d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 after ln_temp ln_rain ln_psi time, absorb(i.premiseno i.month) cluster(pcode time) compact poolsize(1)
eststo bill_event

coefplot bill_event, keep(d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 pchg) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") xsize(3.45) ysize(2.5) ylabel(-0.08(0.02)0.08,format(%5.2f)) yline(0) base legend(off) omitted offset(0) xline(1.5) xline(5.5) xline(8.5) coeflabels(d0="Before" d1="m1" d2="m2" d3="m3" d4="m4" d5="m5" d6="m6" d7="m7" d8="m8" d9="m9"d10="m10" pchg="After")

graph save "Graph" Extended_figure9.gph, replace
graph export Extended_figure9.pdf, replace	
graph export Extended_figure9.tif, replace	

**Figure 10
***subfigure(a)-(b)
use data, clear
drop if ext==1
gen post=(time<678)
gen drought=(time>681)
gen pchg=(time>689)

keep if post==1

cap drop mwat
bysort premiseno: egen mwat=mean(wat)
gen resid=log(wat+1)-log(mwat+1)
reg resid ln_temp ln_rain ln_psi i.time
predict resid2, residual

bysort pcode ptype time: egen nb=mean(wat)
bysort premiseno (time): gen nb_lag=nb[_n-1]
bysort time: egen nt=mean(wat)
bysort premiseno (time): gen nt_lag=nt[_n-1]
drop if nt_lag==.

gen above_nt=(wat>nt_lag)
gen dist_nb=wat-nb_lag
gen above_nb=(wat>nb_lag)
gen dist_nt=wat-nt_lag

keep wat resid resid2 above_nt above_nb dist_nt dist_nb

gen bin_nb=dist_nb-mod(dist_nb,0.1)+0.1
gen bin_nt=dist_nt-mod(dist_nt,0.1)+0.1

bysort bin_nb: egen mwat_nb=mean(resid2)
bysort bin_nb: gen cn_nb=_n
rdrobust mwat_nb bin_nb if cn_nb==1
bysort bin_nt: egen mwat_nt=mean(resid2)
bysort bin_nt: gen cn_nt=_n
rdrobust mwat_nt bin_nt if cn_nt==1

collapse (mean) wat resid resid2, by(bin_nb above_nt)
qui cmogram resid2 bin if above_nt==0, scatter line(0) lowess histopts(bin(100)) cut(0) 
graph save rd_nb_belownt.gph
qui cmogram resid2 bin if above_nt==1, scatter line(0) lowess histopts(bin(100)) cut(0) 
graph save rd_nb_abovent.gph

***subfigure(c)-(d)
use data, clear
drop if ext==1
gen post=(time<678)
keep if post==1

cap drop mwat
bysort premiseno: egen mwat=mean(wat)
gen resid=wat-mwat
reg resid ln_temp ln_rain ln_psi i.time
predict resid2, residual

bysort pcode ptype time: egen nb=mean(wat)
bysort premiseno (time): gen nb_lag=nb[_n-1]
bysort time: egen nt=mean(wat)
bysort premiseno (time): gen nt_lag=nt[_n-1]
drop if nt_lag==.

gen above_nt=(wat>nt_lag)
gen dist_nb=wat-nb_lag
gen above_nb=(wat>nb_lag)
gen dist_nt=wat-nt_lag

keep wat resid resid2 above_nt above_nb dist_nt dist_nb

cap drop bin
gen bin=dist_nt-mod(dist_nt,0.1)+0.1
collapse (mean) wat resid resid2, by(bin above_nb)
qui cmogram resid2 dist if above_nb==0 & dist<5 & dist>-5, scatter line(0) lowess histopts(bin(100)) cut(0) 
graph save rd_nt_belownb.gph
qui cmogram resid2 dist if above_nb==1 & dist<5 & dist>-5, scatter line(0) lowess histopts(bin(50)) cut(0) 
graph save rd_nt_abovenb.gph

foreach v in rd_nb_belownt rd_nb_abovent rd_nt_belownb rd_nt_abovenb{
	graph use `v'
	gr_edit .style.editstyle declared_ysize(2.5) editcopy
    gr_edit .style.editstyle declared_xsize(3.45) editcopy
	graph save `v', replace
}

***combine
graph use rd_nb_belownt
gr_edit .title.text = {}
gr_edit .b1title.text = {`"(a) Around neighborhood mean: below national mean"'}
graph save rd_nb_belownt, replace

graph use  rd_nb_abovent
gr_edit .title.text = {}
gr_edit .b1title.text = {`"(b) Around neighborhood mean: above national mean"'}
graph save rd_nb_abovent, replace

graph use  rd_nt_belownb
gr_edit .title.text = {}
gr_edit .b1title.text = {`"(c) Around national mean: below neighborhood mean"'}
graph save rd_nt_belownb, replace

graph use  rd_nt_abovenb
gr_edit .title.text = {}
gr_edit .b1title.text = {`"(d) Around national mean: above neighborhood mean"'}
graph save rd_nt_abovenb, replace

graph combine rd_nb_belownt rd_nb_abovent rd_nt_belownb rd_nt_abovenb, row(2) xsize(3.50) ysize(2.5) graphregion(color(white)) scheme(plottig)
graph save "Graph" Extended_figure10.gph, replace
graph export Extended_figure10.pdf, replace
graph export Extended_figure10.tif, replace

*Supplementary Informaiton 
***Figure 1
use data.dta, clear
drop if ext==1
keep if year_complete>1975 & year_complete<1997
keep if (year_complete<1987 & post_comp==1) | (year_complete>1986&post_comp==0)
bysort time: egen tm_wat=mean(wat)
gen resid=wat-tm_wat
reg resid ln_temp ln_rain ln_psi i.time
predict resid2, residual
collapse (mean) resid2, by(year_complete post_comp)
gen dist=year_complete-1986
qui cmogram resid dist if dist<=10 & dist>=-10, scatter line(.5) lowess histopts(bin(10)) cut(0) scheme(plottig)
gr_edit .xtitle.text = {}
gr_edit .xtitle.text = {`"Distance to 1986"'}
gr_edit .ytitle.text = {}
gr_edit .ytitle.text = {`"Residual water consumption"'}
graph save SA_Figure1.gph, replace

***Figure 2
use data.clear
drop if ext==1
gen distance=time-time_HIPcomp
cap drop distance_year
gen distance_year=distance/12
replace distance_year=floor(distance_year) if distance_year<0
replace distance_year=ceil(distance_year) if distance_year>0
replace distance_year=0 if distance_year==.
replace distance_year=10 if distance_year>10
replace distance_year=distance_year+10

reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time if year_complete<2009 | year_complete!=., absorb(i.premiseno i.time) cluster(pcode time)
eststo event_2009


reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time if year_complete<=1997, absorb(i.premiseno i.time) cluster(pcode time)
eststo event_1997

reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time if year_complete<1987, absorb(i.premiseno i.time) cluster(pcode time)
eststo event_1986


reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time if HIP==1, absorb(i.premiseno i.time) cluster(pcode time) compact 
eststo event_HIPonly

reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time if year_complete>1970 & year_complete<1987, absorb(i.premiseno i.time) cluster(premiseno)
eststo event_7186

keep if year_complete==1986 | year_complete==1987
replace post_comp=0 if year_complete==1987
reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time, absorb(i.premiseno i.time) cluster(premiseno)
eststo event_8687


foreach v in 2009 1997 1986 HIPonly 7186 8687{
coefplot event_`v',  keep(1.HIP#*.distance_year) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) base legend(off) coeflabels(1.HIP#1.distance_year="T-9" 1.HIP#2.distance_year="T-8" 1.HIP#3.distance_year="T-7" 1.HIP#4.distance_year="T-6" 1.HIP#5.distance_year="T-5" 1.HIP#6.distance_year="T-4" 1.HIP#7.distance_year="T-3" 1.HIP#8.distance_year="T-2" 1.HIP#9.distance_year="T-1" 1.HIP#10.distance_year="T0" 1.HIP#11.distance_year="T+1" 1.HIP#12.distance_year="T+2" 1.HIP#13.distance_year="T+3" 1.HIP#14.distance_year="T+4" 1.HIP#15.distance_year="T+5" 1.HIP#16.distance_year="T+6" 1.HIP#17.distance_year="T+7" 1.HIP#18.distance_year="T+8" 1.HIP#19.distance_year="T+9" 1.HIP#20.distance_year="T+10", angle(90)) omitted offset(0) xline(10) 
graph save event_`v'.gph, replace
}

***Figure 3
foreach i of num 1/4{
reghdfe ln_wat 1.post_comp#i.mqt 1.HIP#c.time if ptype==`i', absorb(i.premiseno i.time) cluster(pcode time)
eststo mqt_ptype`i'
}

coefplot mqt_ptype1, bylabel(1-/2-room) || mqt_ptype2, bylabel(3-room) || mqt_ptype3, bylabel(4-room) || mqt_ptype4, bylabel(5-room/Executive) ||, ///
keep(1.post_comp#*.mqt) ciopts(recast(rcap)) coeflabels(1.post_comp#1.mqt="Q1" 1.post_comp#2.mqt="Q2" 1.post_comp#3.mqt="Q3" 1.post_comp#4.mqt="Q4") scheme(plottig) vertical ytitle("Log of  monthly water consumption") ysize(2.6) xsize(3.575) ylabel(,format(%5.2f)) yline(0) ylabel(-0.08(0.02)0.06) base omitted byopts(row(1)) 
graph save "Graph" mqt_ptype.gph, replace

foreach i of num 1/4{
reghdfe ln_wat 1.post_comp#i.mqt 1.HIP#c.year if flatage==`i', absorb(i.premiseno i.time) cluster(pcode time)
eststo mqt_age`i'
}

coefplot mqt_age1, bylabel("Before 1980") || mqt_age2, bylabel("1980-1983" ) || mqt_age3, bylabel("1984-1986") || mqt_age4, bylabel("1987-1997") ||, ///
keep(1.post_comp#*.mqt) ciopts(recast(rcap)) coeflabels(1.post_comp#1.mqt="Q1" 1.post_comp#2.mqt="Q2" 1.post_comp#3.mqt="Q3" 1.post_comp#4.mqt="Q4") scheme(plottig) vertical ytitle("Log of  monthly water consumption") ysize(2.6) xsize(3.575) ylabel(,format(%5.2f)) yline(0) ylabel(-0.08(0.02)0.06) base omitted byopts(row(1)) 
graph save "Graph" mqt_age.gph, replace

***Figure 4
recode nrent (0 = 1) (1 = 0), gen(nrent)
replace nrent=rcat if nrent=1
label def nrent 0 "HDB Rental" 1 "Quartile 1" 2 "Quartile 2" 3 "Quartile 3"  4 "Quartile 4" 
label val nrent nrent

foreach v in nrent flatage mqt ptype{
graph bar (count) time, over(HIP) over(`v') ytitle(Frequency) ysize(2.6) xsize(3.575) ylabel(,format(%5.0f)) scheme(plottig) 
graph save "Graph" hetd_`v'.gph, replace
}


***Figure 5
tab mqt, gen(q)
graph bar q1 q2 q3 q4, over(ptype, relabel(1 "1-/2-room" 2 "3-room" 3 "4-room" 4 "5-room/Executive")) percent stack legend(pos(6) row(1) lab(1 "Quartile 1") lab(2 "Quartile 2") lab(3 "Quartile 3") lab(4 "Quartile 4")) ytitle("Percent") ysize(2.6) xsize(3.575) ylabel(,format(%5.0f))
graph save "Graph" consumption_ptype.gph, replace

graph bar q1 q2 q3 q4, over(flatage) percent stack legend(pos(6) row(1) lab(1 "Quartile 1") lab(2 "Quartile 2") lab(3 "Quartile 3") lab(4 "Quartile 4")) ytitle("Percent") ysize(2.6) xsize(3.575) ylabel(,format(%5.0f))
graph save "Graph" consumption_age.gph, replace

***Figure 6
foreach v in male chinese fsize elderly young{
	graph bar (count) time, over(HIP) over(`v') ytitle(Frequency) ysize(2.6) xsize(3.575) ylabel(,format(%5.0f)) scheme(plottig)
	graph save "Graph" hetd_`v'.gph, replace
}

***Figure 7
use data.clear
drop if ext==1
gen distance=time-time_HIPcomp
cap drop distance_year
gen distance_year=distance/12
replace distance_year=floor(distance_year) if distance_year<0
replace distance_year=ceil(distance_year) if distance_year>0
replace distance_year=0 if distance_year==. | distance_year<0
replace distance_year=10 if distance_year>10
replace distance_year=distance_year+10

foreach v in rcat ptype flatage mqt{
	foreach i of num 1/4{
cap	reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time i.HIP#c.time if `v'=`i', absorb(i.premiseno i.time) cluster(premiseno)
cap coefplot event_`v',  keep(1.HIP#*.distance_year) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) base legend(off) coeflabels(1.HIP#1.distance_year="Before" 1.HIP#2.distance_year="T+1" 1.HIP#3.distance_year="T+2" 1.HIP#4.distance_year="T+3" 1.HIP#5.distance_year="T+4" 1.HIP#6.distance_year="T+5" 1.HIP#7.distance_year="T+6" 1.HIP#8.distance_year="T+7" 1.HIP#9.distance_year="T+8" 1.HIP#10.distance_year="T+9" 1.HIP#11.distance_year="T+10", angle(90)) omitted offset(0) xline(10) 
cap graph save event_`v'`i'.gph, replace
	}
}

***Figure 8
foreach v in male chinese fsize elderly young{
	foreach i of num 1/4{
reghdfe ln_wat 1.HIP#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time i.HIP#c.time if `v'=`i', absorb(i.premiseno i.time) cluster(premiseno)
coefplot event_`v',  keep(1.HIP#*.distance_year) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) base legend(off) coeflabels(1.HIP#1.distance_year="Before" 1.HIP#2.distance_year="T+1" 1.HIP#3.distance_year="T+2" 1.HIP#4.distance_year="T+3" 1.HIP#5.distance_year="T+4" 1.HIP#6.distance_year="T+5" 1.HIP#7.distance_year="T+6" 1.HIP#8.distance_year="T+7" 1.HIP#9.distance_year="T+8" 1.HIP#10.distance_year="T+9" 1.HIP#11.distance_year="T+10", angle(90)) omitted offset(0) xline(10) 
graph save event_`v'`i'.gph, replace
	}
}

***Figure 9
gen high_temp=(temp_mean_r10km>28.9)
gen high_rain=(rain_days_r10km>22.3)
gen high_psi=(psi_r10km>=100) 

foreach v in high_temp high_rain high_psi{
reghdfe ln_wat 1.HIP#1.`v'#ib1.distance_year ln_temp ln_rain ln_psi 1.HIP#c.time i.HIP#c.time, absorb(i.premiseno i.time) cluster(premiseno)
coefplot event_`v',  keep(1.HIP#*.distance_year) scheme(plottig) ciopts(recast(rcap)) vertical ytitle("Log of monthly water consumption") ylabel(-0.10(0.05)0.10,format(%5.2f)) yline(0) base legend(off) coeflabels(1.HIP#1.`v'#1.distance_year="Before" 1.HIP#1.`v'#2.distance_year="T+1" 1.HIP#1.`v'#3.distance_year="T+2" 1.HIP#1.`v'#4.distance_year="T+3" 1.HIP#1.`v'#5.distance_year="T+4" 1.HIP#1.`v'#6.distance_year="T+5" 1.HIP#1.`v'#7.distance_year="T+6" 1.HIP#1.`v'#8.distance_year="T+7" 1.HIP#1.`v'#9.distance_year="T+8" 1.HIP#1.`v'#10.distance_year="T+9" 1.HIP#1.`v'#11.distance_year="T+10", angle(90)) omitted offset(0) xline(10) 
graph save event_`v'.gph, replace
}

***Figure 10
bysort pcode ptype time: egen nb=mean(wat)
bysort time: egen nt=mean(wat)
gen above_nt=(wat>nt)
gen above_nb=(wat>nb)
bysort premiseno (time): gen above_nt_lag=above_nt[_n-1]
bysort premiseno (time): gen above_nb_lag=above_nb[_n-1]

gen message=1 if above_nt_lag==0 & above_nb_lag==0
replace message=2 if above_nt_lag==1 & above_nb_lag==0
replace message=3 if above_nt_lag==0 & above_nb_lag==1
replace message=4 if above_nt_lag==1 & above_nb_lag==1

foreach i of num 1/4{
	graph bar (count) time if message==`i', over(decile) ytitle(Frequency) ysize(2.6) xsize(3.575) ylabel(0(2000000)10000000,format(%5.0f)) scheme(plottig)
	graph save hetd_decile_m`i'.gph, replace
	graph bar (count) time if message==`i', over(ptype) ytitle(Frequency) ysize(2.6) xsize(3.575) ylabel(0(4000000)20000000,format(%5.0f)) scheme(plottig)
	graph save hetd_ptype_m`i'.gph, replace
	graph bar (count) time if message==`i', over(post_comp) ytitle(Frequency) ysize(2.6) xsize(3.575) ylabel(0(2000000)10000000,format(%5.0f)) scheme(plottig)
	graph save hetd_HIP_m`i'.gph, replace
}


***Table 1
use data.dta, clear
keep sc==1
reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)
eststo baseline
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save baseline, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time if HIP==0 | (HIP==1 & time<time_HIPann) | (HIP==1 & time>time_HIPcomp), absorb(i.premiseno i.time) cluster(pcode time)
eststo comp_drop18m
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save comp_drop18m, replace

gen comp24=post_comp 
replace comp24=0 if post_comp==1 & time<time_HIPcomp+6
reghdfe ln_wat comp24 ln_temp ln_rain ln_psi trend_pre i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)
eststo comp_24m
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save comp_24m, replace

gen comp30=post_comp 
replace comp30=0 if post_comp==1 & time<time_HIPcomp+12
reghdfe ln_wat comp30 ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)
eststo comp_30m
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save comp_30m, replace

reghdfe ln_wat post_bill ln_temp ln_rain ln_psi i.HIP#c.time if ext!=1, absorb(i.premiseno i.time) cluster(pcode time)
eststo comp_bill
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save comp_bill, replace

esttab baseline comp_drop18m comp_24m comp_30m comp_bill using tableA1.tex, replace ///
rename(comp24 post_comp comp30 post_comp post_bill post_comp) keep(post_comp) se star(* 0.10 ** 0.05 *** 0.01) r2(3) ///
eqlabels(none) cells("b(fmt(3)star)" "se(fmt(3)par)")  ///
nogaps booktabs f varlabel(post_comp "HIP*Completed") refcat(post_comp "\midrule", nolabel) ///
collabels(none) mtitles("18 months(baseline)" "18 months(w/o in-between sample)" "24 months" "30 months" "Billing") nolines stats(weather pollution trend premise ym N r2, fmt(0 0 0 0 0 %12.0fc 3) label("Weather control" "Pollution control" "Group time trend" "Account FE" "Year-month FE" "N" "R$^2$"))

***Table 2
use data.dta, clear
drop if ext==1
tab ptype, gen(d_ptype)
tab flatage, gen(d_age)
gen prewat=wat if post_comp==0

keep if year_complete<2009
stddiff prewat d_age1 d_age2 d_age3 d_age4 d_age5 d_ptype1 d_ptype2 d_ptype3 d_ptype4 fsize gender ethnicity elderly young temp_mean_r10km rain_days_r10km psi_r10km, by(HIP)
matrix c1=r(stddiff)
summ HIP
matrix c12=r(N)
keep if year_complete<=1997
stddiff prewat d_age1 d_age2 d_age3 d_age4 d_age5 d_ptype1 d_ptype2 d_ptype3 d_ptype4 fsize gender ethnicity elderly young temp_mean_r10km rain_days_r10km psi_r10km, by(HIP)
matrix c2=r(stddiff)
summ HIP
matrix c22=r(N)
keep if year_complete<=1986
stddiff prewat d_age1 d_age2 d_age3 d_age4 d_age5 d_ptype1 d_ptype2 d_ptype3 d_ptype4 fsize gender ethnicity elderly young temp_mean_r10km rain_days_r10km psi_r10km, by(HIP)
matrix c3=r(stddiff)
summ HIP
matrix c32=r(N)
keep if year_complete>1970
stddiff prewat d_age1 d_age2 d_age3 d_age4 d_age5 d_ptype1 d_ptype2 d_ptype3 d_ptype4 fsize gender ethnicity elderly young temp_mean_r10km rain_days_r10km psi_r10km, by(HIP)
matrix c4=r(stddiff)
summ HIP
matrix c42=r(N)
keep if year_complete==1986 | (year_complete==1987 & HIP==0)
stddiff prewat d_age1 d_age2 d_age3 d_age4 d_age5 d_ptype1 d_ptype2 d_ptype3 d_ptype4  fsize gender ethnicity elderly young temp_mean_r10km rain_days_r10km psi_r10km, by(HIP)
matrix c5=r(stddiff)
summ HIP
matrix c52=r(N)
matrix TableA2=(c1, c2, c3, c4, c5 \ c12, c22, c32, c42, c52)

matrix rownames TableA2="Mean before HIP (m3)" "Before 1980" "1980-1983" "1984-1986" "1987-1997" "After 1997" "1-/2-room" "3-room" "4-room" "5-room and Executive" //
                        "Mean family size" "Mean prop. of males" "Mean prop. of elderly" "Mean prop. of young adults" "Mean temperature (C◦)" "Mean no. of rainy days" "Mean PSI" //
						"Observations"
matrix colnames TableA2="<=2008" "<=1997" "<=1986" "1971-86" "1986-87"
mat2txt, matrix(TableA2) saving(TableA2)

***Table 3
use data.clear
reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)
eststo extreme
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates use extreme, replace

drop if ext==1
reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time if year_complete<2009 | year_complete!=., absorb(i.premiseno i.time) cluster(pcode time)
eststo sample_09
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save sample_09, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time if year_complete<=1997, absorb(i.premiseno i.time) cluster(pcode time)
eststo sample_97
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save sample_97, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time if year_complete<1987, absorb(i.premiseno i.time) cluster(pcode time)
eststo sample_86
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save sample_86, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi if HIP==1, absorb(i.premiseno i.time) cluster(pcode time) compact 
eststo sample_HIP
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "No"
estimates save sample_HIP, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.year if year_complete>1970 & year_complete<1987, absorb(i.premiseno i.time) cluster(premiseno)
eststo sample_7186
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save sample_7186, replace

keep if year_complete==1986 | year_complete==1987
replace post_comp=0 if year_complete==1987
reghdfe ln_wat post_comp ln_temp ln_rain ln_psi, absorb(i.premiseno i.time) cluster(premiseno)
eststo cut_8687
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save cut_8687, replace

eststo clear
foreach v in baseline sample_09 sample_97 sample_86 sample_7186 sample_HIP cut_8687 extreme{
	estimates use `v'
    eststo `v'
}
esttab baseline sample_09 sample_97 sample_86 sample_7186 sample_HIP cut_8687 extreme using TableA3.tex, replace ///
keep(post_comp) se star(* 0.10 ** 0.05 *** 0.01) r2(3) ///
eqlabels(none) cells("b(fmt(3)star)" "se(fmt(3)par)") ///
nogaps booktabs f varlabel(post_comp "HIP*Completed") refcat(post_comp "\midrule", nolabel) ///
collabels(none) mtitles("Baseline" "\$\le\$2008" "\$\le\$1997" "\$\le\$1986" "1971-86" "HIP only" "1986-87" "w/ extremes" ) nolines stats(weather pollution trend premise ym N r2, fmt(0 0 0 0 0 %12.0fc 3) label("Weather control" "Pollution control" "Group time trend" "Account FE" "Year-month FE" "N" "R$^2$"))

***Table 4
use data.clear
drop if ext=1
reghdfe ln_wat post_comp i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)
eststo alt_nocontrol
estadd local weather "No"
estadd local pollution "No"
estadd local premise "Yes"
estadd local ym "Yes"
estadd local trend "Yes"
estadd local pcode "No"
estadd local year "No"
estadd local month "No"
estadd local psecy "No"
estimates save alt_nocontrol,replace

reghdfe ln_wat post_comp  ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.pcode i.time) cluster(pcode time)
eststo alt_pcode
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local premise "No"
estadd local pcode "Yes"
estadd local ym "Yes"
estadd local trend "Yes"
estadd local year "No"
estadd local month "No"
estadd local psecy "No"
estimates save alt_pcode,replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.year i.month) cluster(pcode time)
eststo alt_ym
estadd local weather "Yes"
estadd local premise "Yes"
estadd local pollution "Yes"
estadd local  year "Yes"
estadd local month "Yes"
estadd local trend "Yes"
estadd local pcode "No"
estadd local ym "No"
estadd local psecy "No"
estimates save alt_ym,replace

cap drop psec
gen psec=floor(pcode/10000)
reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time i.psec#i.year) cluster(pcode time)
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local premise "Yes"
estadd local pcode "No"
estadd local ym "Yes"
estadd local trend "Yes"
estadd local year "No"
estadd local month "No"
estadd local psecy "Yes"
estimates save alt_region,replace

gen asinh_wat=asinh(wat)
reghdfe asinh post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time)
eststo asinh
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local premise "Yes"
estadd local pcode "No"
estadd local ym "Yes"
estadd local trend "Yes"
estadd local year "No"
estadd local month "No"
estadd local psecy "No"
estimates save alt_asinh, replace

foreach v in alt_pcode alt_ym alt_nocontrol alt_region baseline alt_asinh{
	estimates use `v'
    eststo `v'
}

esttab alt_pcode alt_ym alt_nocontrol alt_region baseline alt_asinh using TableA4.tex, replace ///
keep(post_comp) se star(* 0.10 ** 0.05 *** 0.01) r2(3) ///
eqlabels(none) cells("b(fmt(3)star)" "se(fmt(3)par)") ///
nogaps booktabs f varlabel(post_comp "HIP*Completed") refcat(post_comp "\midrule", nolabel) ///
collabels(none) nomtitles nolines stats(weather pollution trend premise pcode ym year month psecy N r2, fmt(0 0 0 0 0 0 0 0 0 %12.0fc 3) label("Weather control" "Pollution control" "Group time trend" "Account FE" "Block FE" "Year-month FE" "Year FE" "Month FE" "Region-year FE" "N" "R$^2$"))

***Table 5
reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(premiseno time)
eststo cluster_premise
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save cluster_premise, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode)
eststo cluster_oneway
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save cluster_oneway, replace

reghdfe ln_wat post_comp ln_temp ln_rain ln_psi i.HIP#c.time, absorb(i.premiseno i.time) cluster(premiseno)
eststo cluster_onewaypremise
estadd local premise "Yes"
estadd local ym "Yes"
estadd local weather "Yes"
estadd local pollution "Yes"
estadd local trend "Yes"
estimates save cluster_onewaypremise, replace

foreach v in baseline  cluster_premise cluster_oneway cluster_onewaypremise{
	estimates use `v'
    eststo `v'
}
esttab baseline cluster_premise cluster_oneway cluster_onewaypremise using TableA5.tex, replace ///
keep(post_comp) se star(* 0.10 ** 0.05 *** 0.01) r2(3) ///
eqlabels(none) cells("b(fmt(3)star)" "se(fmt(3)par)") ///
nogaps booktabs f varlabel(post_comp "HIP*Completed") refcat(post_comp "\midrule", nolabel) ///
collabels(none) mtitles("Account, Year-month" "Block, Year-month" "Account" "Block") nolines stats(weather pollution trend premise ym N r2, fmt(0 0 0 0 0 %12.0fc 3) label("Weather control" "Pollution control" "Group time trend" "Account FE" "Year-month FE" "N" "R$^2$"))

***Table 9
use resale.dta
gen ln_price=log(resale_price)
foreach i of num 1/4{
	reghdfe ln_price 1.post_comp#`i'.ptype sqm i.floor if ptype==`i', absorb(i.bid i.time) cluster(bid time)
	estadd local flat "Yes"
    estadd local ym "Yes"
	estadd local nbfe "Yes"
	eststo ptype`i'
} 
esttab ptype1 ptype2 ptype3 ptype4 using TableB3.tex, keep(1.post_comp#*.ptype) se star(* 0.10 ** 0.05 *** 0.01) r2(3) ///
eqlabels(none) cells("b(fmt(4)star)" "se(fmt(3)par)") ///
nogaps booktabs f varlabel(1.post_comp#1.ptype "Post*HIP*HDB 1-/2-room" 1.post_comp#2.ptype "Post*HIP*HDB 3-room" 1.post_comp#3.ptype "Post*HIP*HDB 4-room" 1.post_comp#4.ptype "Post*HIP*HDB 4-room/Executive" ) refcat(1.post_comp#1.ptype "\midrule", nolabel) ///
collabels(none) nomtitles nolines stats(flat nbfe ym N r2, fmt(0 0 0 0 3) label("Flat characteristics" "Neighbourhood FE" "Year-month FE" "N" "R$^2$"))


***Table 14
use data.clear
drop if ext==1
gen high_temp=(temp_mean_r10km>28.9)
gen high_rain=(rain_days_r10km>22.3)
gen high_psi=(psi_r10km>=100) 

egen sd_temp=std(temp_mean_r10km)
egen sd_rain=std(rain_days_r10km)
egen sd_psi=std(psi_r10km)

foreach c in high sd{
	foreach v in temp rain psi{
	reghdfe ln_wat 1.post_comp `c'_temp `c'_rain `c'_psi 1.HIP#c.`c'_`v' 1.post_comp#c.`c'_`v' 1.HIP#c.time, absorb(i.premiseno i.time) cluster(pcode time) compact
	eststo `c'_`v'
	estadd local premise "Yes"
    estadd local ym "Yes"
    estadd local trend "Yes"
	estimates save `c'_`v'
}
}

foreach v in baseline high_temp high_rain high_psi sd_temp sd_rain sd_psi{
	estimates use `v'
    eststo `v'
}

esttab baseline sd_temp sd_rain sd_psi  high_temp high_rain high_psi using TableC4.tex, replace ///
rename(ln_temp temp ln_rain rain ln_psi psi high_temp temp high_rain rain high_psi psi sd_temp temp sd_rain rain sd_psi psi) ///
keep(1.post_comp temp rain psi 1.HIP#c.temp 1.HIP#c.rain 1.HIP#c.psi 1.post_comp#c.temp 1.post_comp#c.rain 1.post_comp#c.psi) se star(* 0.10 ** 0.05 *** 0.01) r2(3) ///
eqlabels(none) cells("b(fmt(3)star)" "se(fmt(3)par)") ///
nogaps booktabs f varlabel(1.post_comp "HIP*Completed" temp "Temperature(T)" rain "Rain(R)" psi "PSI" 1.HIP#c.temp "HIP*T" 1.post_comp#c.temp "HIP*Completed*T" 1.HIP#c.rain "HIP*R" 1.post_comp#c.rain "HIP*Completed*R" 1.HIP#c.psi "HIP*PSI" 1.post_comp#c.psi "HIP*Completed*PSI") refcat(1.post_comp "\midrule", nolabel) ///
collabels(none) nomtitles nolines stats(trend premise ym N r2, fmt(0 0 0 0 3) label("Group time trend" "Premise FE" "Year-month FE" "N" "R$^2$"))
