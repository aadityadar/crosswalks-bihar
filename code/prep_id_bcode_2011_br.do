*** prepare district name spelling variations for bihar

* prelim 
clear all

* read data
import excel using "input/id_bcode_2011_br.xlsx", clear firstrow

* rename 
rename *, lower 

* tostring 
tostring *code, replace 
 
* mop up 
missings dropobs, force 
replace dcode = subinstr(dcode, "'", "", 1)
replace bcode = subinstr(bcode, "'", "", 1)
ds, has(type string)
foreach var in `r(varlist)' {
	replace `var' = strlower(stritrim(strtrim(`var')))
}

* sanity check 
isid bcode
assert length(bcode) == 4

* distinct geos
gdistinct bcode
assert `r(ndistinct)' == 534

* reshape to long 
reshape long b, i(bcode) j(j)

* mop up 
drop j
rename b bname 
rename dcode dcode_2011
rename bcode bcode_2011

* drop dups
drop if bname == ""
duplicates list dcode_2011 bname, sepby(dcode_2011)
duplicates drop dcode_2011 bname, force 

* finalize
order dcode_2011 bcode_2011 bname
sort dcode_2011 bcode_2011 bname
isid dcode_2011 bname

* save
compress
save "output/id_bcode_2011_br.dta", replace 
