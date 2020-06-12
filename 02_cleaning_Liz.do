version 15.0
pause on 
set more off

global user="liz"

if "$user"=="liz"{
	global main "/Users/elizabethcao/Dropbox (MIT)/Conde Nast"
	}
	
insheet using "$main/raw_cn.csv", clear

drop v1
replace race=lower(race)

gen white=(strpos(race, "white")>0)
replace white=1 if strpos(race, "whte")>0
replace white=1 if strpos(race, "cau")>0
gen black=(strpos(race, "black")>0)
replace black=1 if strpos(race, "afr")>0
gen latinx=(strpos(race, "latin")>0)
replace latinx=1 if strpos(race,"hisp")>0
replace latinx=1 if strpos(race, "east ind")>0
gen asian=(strpos(race,"asian")>0)
replace asian=1 if strpos(race, "chinese")>0
replace asian=1 if strpos(race, "indian")>0
gen pac_isl=(strpos(race, "pac")>0)
gen mena=(strpos(race, "arab")>0)
gen ind=(strpos(race, "indig")>0)

gen woman=(strpos(gender, "Woman")>0)
gen man=(strpos(gender, "Man")>0)
gen nonbinary=(strpos(gender, "Non-")>0)

replace title=lower(title)
gen editor=(strpos(title, "editor")>0)

gen senior=(strpos(title, "senior")>0)
replace senior=(strpos(title, "director")>0)
replace senior=1 if (strpos(title, "manager")>0)
// preserve
// keep if editor==1
// reg salary black
