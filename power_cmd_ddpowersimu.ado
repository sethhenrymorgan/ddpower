capture program drop power_cmd_ddpowersimu
program power_cmd_ddpowersimu, rclass
version 17.0

	// Input parameters
	syntax, nperclust(integer)   /// sample size
	treat_ratio(real)  /// ratio of treated to untreated
	n(integer)   /// number of clusters
	icc(real)  /// set intra-cluster correlation
	b1(real)  /// b1 under the alternative hypothesis - diff-in-diff
	sd(real)  /// standard deviation of outcome
	levels(integer) /// 2 for double-diff, 3 for triple-diff
	[ alpha(real 0.05) /// set alpha level
	reps(integer 1000) /// number of repetitions
	]   
	
	// call ddpowersimu with simulate
	quietly simulate reject = r(reject) pvalue=r(pvalue), reps(`reps') seed(12345): ddpowersimu, nperclust(`nperclust') b1(`b1') sd(`sd') icc(`icc') n(`n') treat_ratio(`treat_ratio') levels(`levels')
	quietly sum reject
	
	// return results
	return scalar power = r(mean)
	return scalar N = `n'
	return scalar alpha = `alpha'
	return scalar b1 = `b1'
end
	