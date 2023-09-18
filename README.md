# crosswalks-bihar

Linking of records across datasets is difficult because geographic identifiers are not standardized. In this repo, I provide data files that track common spelling variations for various geographies in Bihar.  

To merge district codes:  

```
* prep to merge district codes
rename districtNameInYourData dname 
replace dname = strlower(stritrim(strtrim(dname)))

* link dnames to dcodes
merge m:1 dname using "output/id_dcode_2011_br.dta", gen(m_dcode) keepusing(dcode_2011)

* sanity check 
assert m_dcode != 1
drop if m_dcode != 3
```

To merge block codes, first standardize district codes and then merge on standardized district code and block name:  

```
* prep to merge block codes
rename blockNameInYourData bname
replace bname = strlower(stritrim(strtrim(bname)))

* link dcode-bnames to dcode-bcode
merge m:1 dcode_2011 bname using "output/id_bcode_2011_br.dta", gen(m_bcode) keepusing(bcode_2011)

* sanity check 
assert m_bcode != 1
drop if m_bcode != 3
```

If you find these files helpful and use them in your work, please cite them as:
Dar, A. (2023). India Bridge: Crosswalks for Bihar (Version 1.0.0) [Computer software]. https://github.com/aadityadar/crosswalks-bihar