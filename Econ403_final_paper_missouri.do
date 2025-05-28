/*Final Paper Missouri 
Econ403 
Tyler Gazda 
*/

 use "C:\Users\Tyler\Desktop\TYLER\School Work\RIT\2024 - Fall\ECON403 - Econmectics\Writing Assignment\Final Paper\Raw Data\usa_00002.dta"



cd "C:\Users\Tyler\Desktop\TYLER\School Work\RIT\2024 - Fall\ECON403 - Econmectics\Writing Assignment\Final Paper"


capture log close

log using "Econ403_final_paper_missouri2.txt", replace text


set more off

*keeps only Missouri  statefip == 41
keep if statefip == 29

*keeps only people aged 18 to 20 and 27 to 29
keep if (age >= 27 & age <= 29) | (age >= 18 & age <= 20)

*keeps only people who have atleast 1 year in college 
generate educ_high = educ >= 7 
*creates a dummy variable for after the act has pasted and its interaction term 
generate after = (age < 21)
label variable after "After"
label value after afterlib 
label define afterlib 0 "Before the Act" 1 "After the Act"

generate after_age = after*age

*creates a dummy variables for the race control 
generate white = race == 1
label variable white "white"
label value white whitelib 
label define whitelib 0 "Not White" 1 "White"

generate black = race == 2
label variable black "black"
label value black blacklib 
label define blacklib 0 "Not Black" 1 "Black"

generate native = race == 3
label variable native "Native"
label value native nativelib 
label define nativelib 0 "Not Native" 1 "Native"

generate asian = (race >= 4 & race <= 6)
label variable asian "Asian"
label value asian asianlib 
label define asianlib 0 "Not Asian" 1 "Asian"

generate other = (race >= 7 & race <= 9)
label variable other "Other"
label value other otherlib 
label define otherlib 0 "Not Other" 1 "Other"

*creates a dummy variables for the sex control 
generate male = sex == 1
label variable male "Male"
label value male malelib 
label define malelib 0 "Not Male" 1 "Male"

generate female = sex == 2
label variable female "Female"
label value female femalelib 
label define femalelib 0 "Not Female" 1 "Female"

*creates a dummy variables for the schooltype control 
generate public = schltype == 2
label variable public "Public"
label value public publiclib 
label define publiclib 0 "Not Public" 1 "Public"

generate private = schltype == 3
label variable private "Private"
label value private privatelib 
label define privatelib 0 "Not Private" 1 "Private"

*creates a dummy variables for the total income control 
generate over = hhincome >= 50000
label variable over "Over"
label value over overlib 
label define overlib 0 "Not Over 50,000 total family inc" 1 "Over 50,000 total family inc"

generate under = hhincome < 50000
label variable under "Under"
label value under underlib 
label define underlib 0 "Not Under 50,000 total family inc" 1 "Under 50,000 total family inc"

*regression with no controls 
reg educ_high after_age age after

*regression with race controls 
reg educ_high after_age age after white black asian native other 

*regression with sex controls 
reg educ_high after_age age after male female 

*regression with schooltype controls
reg educ_high after_age age after public private 

*regression with income controls
reg educ_high after_age age after under over 

*regession with all controls 
reg educ_high after_age age after white black asian native other male female public private under over 


log cl
