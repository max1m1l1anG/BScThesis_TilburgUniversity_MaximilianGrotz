use "C:\data\Arbeitsagentur\siab_r_7519_v1.dta", replace

keep if gebjahr <= 2012 - 44 & gebjahr >= 1990 - 60

drop quelle_gr begepi endepi ausbildung_imp beruf_gr beruf2010_gr gleitz befrist tage_jung ao_region pendler

gen date_2nd_july = mdy(7, 2, gebjahr)
format date_2nd_july %td

gen age_beg = round((begorig - date_2nd_july)/ (365.25))
gen age_end = round((end - date_2nd_july)/ (365.25))
drop date_2nd_july

keep if age_beg >= 40 & age_end <= 70

duplicates tag persnr bnn begorig endorig frau gebjahr deutsch ausbildung_gr schule tentgelt_gr niveau teilzeit stib erwstat_gr leih grund_gr tage_alt alo_dau w08_gen_gr age_beg age_end, generate(dups)
drop if dups == 1

save "C:\data\Arbeitsagentur\siab_r_7519_v1.dta", replace

foreach i of num 1930/1968 {
	use "C:\data\Arbeitsagentur\siab_r_7519_v1.dta", clear
	keep if gebjahr == `i'
	save "SIAB\file`i'", replace
}


use  "file1930", clear

foreach i of num 1931/1968 {
	append using  "file`i'",
}


save "df_panel2", replace