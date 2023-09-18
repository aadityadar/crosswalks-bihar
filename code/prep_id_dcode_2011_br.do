*** prepare district name spelling variations for bihar

* prelim 
clear all

* read data
import excel using "input/id_dcode_2011_br.xlsx", clear firstrow

* rename 
rename *, lower 

* tostring 
tostring *code, replace 

* mop up 
ds, has(type string)
foreach var in `r(varlist)' {
	replace `var' = strlower(stritrim(strtrim(`var')))
}

* sanity check 
isid dcode
assert length(dcode) == 3

* distinct districts
gdistinct dcode
assert `r(ndistinct)' == 38

* reshape to long 
reshape long d, i(dcode) j(j)

* mop up 
drop j
rename d dname 
rename dcode dcode_2011
drop if dname == ""
duplicates list dname 
duplicates drop dname, force 

* finalize
order dcode_2011 dname
sort dcode_2011 dname 
isid dname

* save
compress
save "output/id_dcode_2011_br.dta", replace 
