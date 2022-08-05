capture program drop power_cmd_ddpowersimu_init
program power_cmd_ddpowersimu_init, sclass
	sreturn clear
	sreturn local pss_numopts "b1"
	sreturn local pss_colnames "b1"
end