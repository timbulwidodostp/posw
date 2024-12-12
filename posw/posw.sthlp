{smcl}
{* *! version 1.0.0  23may2021}{...}
{viewerjumpto "Title" "posw##title"}{...}
{viewerjumpto "Syntax" "posw##syntax"}{...}
{viewerjumpto "Description" "posw##description"}{...}
{viewerjumpto "Options" "posw##options"}{...}
{viewerjumpto "Examples" "posw##examples"}{...}
{viewerjumpto "Stored results" "posw##results"}{...}
{viewerjumpto "Reference" "posw##reference"}{...}
{viewerjumpto "Authors" "posw##authors"}{...}
{viewerjumpto "Also see" "posw##alsosee"}{...}
{cmd:help posw}{right: ({browse "https://doi.org/10.1177/1536867X231175272":SJ23-2: st0713})}
{hline}

{marker title}{...}
{title:Title}

{p2colset 5 13 15 2}{...}
{p2col :{cmd:posw} {hline 2}}Partialing-out estimator based on stepwise
Bayesian information criterion (BIC) or stepwise testing{p_end}


{marker syntax}{...}
{title:Syntax}

{p 8 12 2}
{cmd:posw}
{depvar}
{it:varsofinterest}
{ifin}{cmd:,}
{opt controls(varlist)}
{cmd:model(linear}|{cmd:logit}|{cmd:poisson)}
[{it:options}]

{pstd}
{it:varsofinterest} are variables for which coefficients and their
standard errors are estimated.

{synoptset 30 tabbed}{...}
{synopthdr}
{synoptline}
{p2coldent :* {opt controls(varlist)}}specify the set of control variables{p_end}
{p2coldent :* {cmd:model(linear}|{cmd:logit}|{cmd:poisson)}}specify the model{p_end}
{synopt : {cmd:method(bic}|{cmd:test)}}specify the stepwise method{p_end}
{synopt : {cmd:alpha(}{it:#}{cmd:)}}specify the significance level if
stepwise testing is used{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
* {opt controls()} and {opt model()} are required.{p_end}


{marker description}{...}
{title:Description}

{pstd}
{cmd:posw} fits a high-dimensional linear, logit or Poisson regression model
and reports standard errors, test statistics, and confidence intervals for
specified covariates of interest.  The stepwise-based partialing-out method,
developed in Drukker and Liu (2022), is used to estimate effects for these
variables and to select from potential control variables to be included in the
model.


{marker options}
{title:Options}

{phang}
{cmd:controls(}{it:varlist}{cmd:)} specifies the set of control variables,
which control for omitted variables.  Control variables are also known as
confounding variables.  {cmd:posw} uses the forward stepwise to select the
control variables for each of {it:depvar} and {it:varsofinterest}.
{cmd:controls()} is required.

{phang}
{cmd:model(linear}|{cmd:logit}|{cmd:poisson)} specifies the model for the
outcome variable {it:depvar}.  It can be one of {cmd:linear}, {cmd:logit}, or
{cmd:poisson}.  {cmd:model()} is required.

{phang}
{cmd:method(bic}|{cmd:test)} specifies the method used in stepwise covariate
selection.  It can be one of {cmd:bic} or {cmd:test}.  Specifying {cmd:bic}
implies using the BIC-based stepwise.  Specifying {cmd:test} implies using the
testing-based stepwise.  The default is {cmd:method(bic)}.

{phang}
{opt alpha(#)} specifies the level of significance for the testing-based
stepwise.  The default is {cmd:alpha(0.05)}.


{marker examples}{...}
{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. webuse breathe}

{pstd}
Partialing-out linear regression for outcome reaction time and inference on
classroom and home nitrogen oxide using stepwise BIC to select controls{p_end}
{phang2}{cmd:. posw react no2_class no2_home,}
{cmd:controls(i.(meducation overweight msmoke sex) noise sev* age)}
{cmd:model(linear)}

{pstd}
As above, but use stepwise testing to select controls{p_end}
{phang2}{cmd:. posw react no2_class no2_home,}
{cmd:controls(i.(meducation overweight msmoke sex) noise sev* age)}
{cmd:model(linear)} {cmd:method(test)}


{marker results}{...}
{title:Stored results}

{pstd}
{cmd:posw} stores the following in {cmd:e()}:

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Scalars}{p_end}
{synopt: {cmd:e(N)}}number of observations {p_end}
{synopt: {cmd:e(k_controls)}}number of controls {p_end}
{synopt: {cmd:e(k_controls_sel)}}number of selected controls {p_end}
{synopt: {cmd:e(k_varsofinterest)}}number of variables of interest {p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Macros}{p_end}
{synopt: {cmd:e(cmd)}}{cmd:posw}{p_end}
{synopt: {cmd:e(depvar)}}dependent variable {p_end}
{synopt: {cmd:e(title)}}title in estimation output {p_end}
{synopt: {cmd:e(vce)}}{cmd:robust}{p_end}
{synopt: {cmd:e(vcetype)}}{cmd:Robust}{p_end}
{synopt: {cmd:e(properties)}}{cmd:b V} {p_end}
{synopt: {cmd:e(varsofinterest)}}variables of interest {p_end}
{synopt: {cmd:e(controls_sel)}}selected control variables {p_end}
{synopt: {cmd:e(controls)}}control variables {p_end}
{synopt: {cmd:e(model)}}type of model {p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Matrices}{p_end}
{synopt: {cmd:e(b)}}coefficient vector {p_end}
{synopt: {cmd:e(V)}}variance–covariance matrix of the estimators{p_end}

{synoptset 20 tabbed}{...}
{p2col 5 20 24 2: Functions}{p_end}
{synopt:{cmd:e(sample)}}marks estimation sample{p_end}
{p2colreset}{...}


{marker reference}{...}
{title:Reference}

{phang}
Drukker, D. M., and D. Liu. 2022. Finite-sample results for lasso and stepwise
Neyman-orthogonal Poisson estimators. {it:Econometric Reviews} 41: 1047–1076. 
{browse "https://doi.org/10.1080/07474938.2022.2091363"}.


{marker authors}{...}
{title:Authors}

{pstd}
David M. Drukker{break}
Sam Houston State University{break}
Huntsville, TX{break}
dxd070@shsu.edu

{pstd}
Di Liu{break}
StataCorp{break}
College Station, TX{break}
dliu@stata.com


{marker alsosee}{...}
{title:Also see}

{p 4 14 2}
Article:  {it:Stata Journal}, volume 23, number 2: {browse "https://doi.org/10.1177/1536867X231175272":st0713}{p_end}
