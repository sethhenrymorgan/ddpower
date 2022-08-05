***Power in diff-in-diff for repeated cross-section
cd "~\Box\MEL\MEL Projects\NTRI_Tanzania\Code"

capture program drop ddpowersimu
set seed 12345
ddpowersimu, n(18) levels(3) nperclust(59) b1(0.4) sd(1.64) icc(0.22) treat_ratio(0.25)
return list
tab x2

*power

simulate reject = r(reject) pvalue=r(pvalue), reps(100) seed(1234): ddpowersimu, n(20) nperclust(59) b1(0.4) sd(1.64) icc(0.22) treat_ratio(0.5) levels(3) 
sum reject


*with null
clear
simulate reject = r(reject) pvalue=r(pvalue), reps(1000) seed(1234): ddpowersimu, nperclust(59) b1(0) sd(0.5) icc(0.5) clust_num(10) treat_ratio(0.5)
sum reject

*try with power twomeans
power twomeans 0 0.4, k1(16) k2(8) m1(59) m2(59) sd(1.64) rho(0.22)

*now put it all together with the power command
program drop _all

* Asset Index (all binary)
* double diff
power ddpowersimu, levels(2) reps(1000) n(12(1)20) nperclust(59) b1(0.4) icc(0.22) sd(1.64) treat_ratio(0.25) table graph(xdimension(N) scheme(s1color) title("Power by Cluster Number") subtitle("Double Difference Simulation")) 
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power2d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power2d.png", replace

power ddpowersimu, reps(1000) levels(2) n(12) nperclust(59) b1(0.4(0.1)0.8) icc(0.22) sd(1.64) treat_ratio(0.25) table graph(xdimension(b1) scheme(s1color) title("Power by Effect Size") subtitle("Double Difference Simulation"))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_powerb12d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_powerb12d.png", replace

graph combine "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power2d.gph" "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_powerb12d.gph", xsize(8) ycommon scheme(s1color)
graph save "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power_comb2d.gph", replace
graph export "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power_comb2d.png", replace

* triple diff
power ddpowersimu, levels(3) reps(1000) n(12(1)20) nperclust(59) b1(0.4) icc(0.22) sd(1.64) treat_ratio(0.25) table graph(xdimension(N) scheme(s1color) title("Power by Cluster Number") subtitle("Triple Difference Simulation")) 
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power3d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power3d.png", replace

power ddpowersimu, reps(1000) levels(3) n(12) nperclust(59) b1(0.4(0.1)0.8) icc(0.22) sd(1.64) treat_ratio(0.25) table graph(xdimension(b1) scheme(s1color) title("Power by Effect Size") subtitle("Triple Difference Simulation"))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_powerb13d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_powerb13d.png", replace

graph combine "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power3d.gph" "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_powerb13d.gph", xsize(8) ycommon scheme(s1color)
graph save "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power_comb3d.gph", replace
graph export "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\asset_power_comb3d.png", replace


* Food Security Score
power ddpowersimu, levels(2) reps(1000) n(12(1)18) nperclust(59) b1(0.5) icc(0.04) sd(2.07) treat_ratio(0.25) table graph(xdimension(N)  title("Power by Cluster Number") subtitle("Double Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power2d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power2d.png", replace

power ddpowersimu, levels(2) reps(1000) n(12) nperclust(59) b1(0.5(0.1)1) icc(0.04) sd(2.07) treat_ratio(0.25) table graph(xdimension(b1) title("Power by Effect Size") subtitle("Double Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_powerb12d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_powerb12d.png", replace

graph combine "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power2d.gph" "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_powerb12d.gph", xsize(8) ycommon scheme(s1color)
graph save "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power_comb2d.gph", replace
graph export "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power_comb2d.png", replace

* triple diff
power ddpowersimu, levels(3) reps(1000) n(12(1)18) nperclust(59) b1(0.5) icc(0.04) sd(2.07) treat_ratio(0.25) table graph(xdimension(N)  title("Power by Cluster Number") subtitle("Triple Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power3d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power3d.png", replace

power ddpowersimu, levels(3) reps(1000) n(12) nperclust(59) b1(0.5(0.1)1) icc(0.04) sd(2.07) treat_ratio(0.25) table graph(xdimension(b1) title("Power by Effect Size") subtitle("Triple Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_powerb13d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_powerb13d.png", replace

graph combine "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power3d.gph" "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_powerb13d.gph", xsize(8) ycommon scheme(s1color)
graph save "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power_comb3d.gph", replace
graph export "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\foodsec_power_comb3d.png", replace

* Conflict
power ddpowersimu, levels(2) reps(1000) n(12(1)18) nperclust(59) b1(0.125) icc(0.07) sd(0.5) treat_ratio(0.25) table graph(xdimension(N) title("Power by Cluster Number") subtitle("Double Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power2d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power2d.png", replace

power ddpowersimu, levels(2) reps(1000) n(12) nperclust(59) b1(0.125(0.025)0.25) icc(0.07) sd(0.5) treat_ratio(0.75) table graph(xdimension(b1) title("Power by Effect Size") subtitle("Double Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_powerb12d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_powerb12d.png", replace

graph combine "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power2d.gph" "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_powerb12d.gph", xsize(8) ycommon scheme(s1color)
graph save "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power_comb2d.gph", replace
graph export "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power_comb2d.png", replace

* triple diff
power ddpowersimu, levels(3) reps(1000) n(12(1)18) nperclust(59) b1(0.125) icc(0.07) sd(0.5) treat_ratio(0.25) table graph(xdimension(N) title("Power by Cluster Number") subtitle("Triple Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power3d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power3d.png", replace

power ddpowersimu, levels(3) reps(1000) n(12) nperclust(59) b1(0.125(0.025)0.25) icc(0.07) sd(0.5) treat_ratio(0.75) table graph(xdimension(b1) title("Power by Effect Size") subtitle("Triple Difference Simulation") scheme(s1color))
graph save  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_powerb13d.gph", replace
graph export  "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_powerb13d.png", replace

graph combine "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power3d.gph" "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_powerb13d.gph", xsize(8) ycommon scheme(s1color)
graph save "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power_comb3d.gph", replace
graph export "~\Box\MEL\MEL Projects\NTRI_Tanzania\Output\conflict_power_comb3d.png", replace