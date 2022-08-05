**Power by Simulation for Diff-in-Diff in Repeated Cross-Section
*Written by Seth Morgan 07/25/2022
*Last updated: 07/25/2022

*see Stata FAQ: https://www.stata.com/support/faqs/statistics/power-by-simulation/
*and Stata List on generating clustered data: https://www.statalist.org/forums/forum/general-stata-discussion/general/1460617-how-to-simulate-clustered-data-with-a-specific-intra-class-correlation

capture program drop ddpowersimu

program ddpowersimu, rclass
version 17.0

	// Input parameters
	syntax, nperclust(integer)   /// sample size
	treat_ratio(real)  /// ratio of treated to untreated
	n(integer)   /// number of clusters
	icc(real)  /// set intra-cluster correlation
	b1(real)  /// b1 under the alternative hypothesis - diff-in-diff
	sd(real)  /// standard deviation of outcome
	levels(integer) /// 2 for double diff, 3 for triple
	[ alpha(real 0.05)  /// set alpha level
	] 
	
 	// Gen random data
	clear
	set obs `n'
	gen int clust = _n // clusters
	
	gen byte x1 = (_n <= `treat_ratio'*_N) // treatment

	expand `nperclust'
	scalar ntotal = `nperclust'*`n'
	sort clust
	
	// time
	expand 2
	gen t = 0  
	by clust, sort: gen memb_num = _n
	sort clust memb_num
	by clust: replace t = 1 if memb_num > (ntotal/`n')
		
	// y variable
	scalar sd_u = sqrt(`icc')
	scalar sd_e = sqrt(`sd'^2 - `icc')
	by clust (memb_num), sort: gen u = rnormal(0, sd_u) if _n == 1
	by clust (memb_num): replace u = u[1]
	gen e = rnormal(0, sd_e)
	
	if `levels' == 3 {
		gen ran = runiform()
		gen x2 = (ran >= 0.5)
		gen mu = `b1'*x1*x2*t 
		gen y = mu + e + u
	
		// Fit diff in diff regression
		reg y x1##x2##t, vce(cluster clust)
	
		// Return results
		mat a=r(table)
		local p1=el(a,rownumb(a,"pvalue"),colnumb(a,"1.x1#1.x2#1.t"))
	}
	else {
		gen mu = `b1'*x1*t 
		gen y = mu + e + u
	
		// Fit diff in diff regression
		reg y x1##t, vce(cluster clust)
	
		// Return results
		mat a=r(table)
		local p1=el(a,rownumb(a,"pvalue"),colnumb(a,"1.x1#1.t"))
	}
	
	return scalar pvalue = `p1'
	return scalar reject = (`p1'<`alpha') 
end