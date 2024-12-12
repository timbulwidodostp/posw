/*-----------------------------------------------------------------------------
	naive regression		
-----------------------------------------------------------------------------*/
program naivereg
	if (replay()) {
		Display
	}
	else {
		Estimate `0'
	}

end

program Estimate, eclass
	syntax varlist(numeric fv), model(string) controls(string)

	fvexpand `varlist'
	local tmp `r(varlist)'
	gettoken depvar dvars : tmp

					// lasso y on everything
	quietly lasso `model' `depvar' `dvars' `controls', sel(plugin)
	local allvars_sel `e(allvars_sel)'
	local allvars_sel : list allvars_sel - dvars
	

					// naive regression
	if ("`model'" == "linear") {
		qui regress `depvar' `dvars' `allvars_sel', vce(robust)
	}
	else {
		qui `model' `depvar' `dvars' `allvars_sel', vce(robust)
	}

					// extract result	
	local k : list sizeof dvars
	tempname b V
	mat `b' = e(b)
	mat `V' = e(V)
	mat `b' = `b'[1, 1..`k']
	mat `V' = `V'[1..`k', 1..`k']
	mat coln `b' = `dvars'
	mat rown `V' = `dvars'
	mat coln `V' = `dvars'

	eret post `b' `V'
	eret local title "naive `model' regression"
	eret local controls_sel `allvars_sel'
	eret local cmd "naivereg"

	Display
end
						//------------------------//
						//  Display
						//------------------------//
program Display
	_coef_table_header	
	_coef_table
end
