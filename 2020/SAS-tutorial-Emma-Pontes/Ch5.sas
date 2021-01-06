*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 5 Regression Analysis in SAS                          **;
*******************************************************************;


*The following title will appear as the first line of every page in the output*;
title "Jue Wang EPS 704 Chapter 5";

*Exercise 2 -- question: read csv using INFILE*;

data college;
	infile "/folders/myfolders/Datasets/college.csv" dlm="," firstobs=2 dsd;
	input schoolid Gender$ schoolsize$ scholarship$ GPA classrank;
run;

proc print data=college;
run;

*Pearson correlation analysis*;

proc corr data=sashelp.class cov;
	var height weight;
run;

*Simple linear regression with PROC REG*;

proc reg data=sashelp.class;
	model Weight=Height / clb cli p r;
	output out=out_set1 p=predicted r=residual;
	run;
	
*Multiple linear regression with PROC REG*;

proc reg data=sashelp.class;
	model Weight=Height Age / clb cli p r;
	output out=out_set1 p=predicted r=residual;
	run;
	
*Variable selection -- Forward selection*;

proc reg data=sashelp.vote1980;
	model LogVoteRate=Pop Edu Houses Income / selection=forward slentry=.05;
	run;
	
*Variable selection -- Backward selection*;

proc reg data=sashelp.vote1980;
	model LogVoteRate=Pop Edu Houses Income / selection=backward slstay=.10;
	run;
	
*Variable selection -- Stepwise selection*;

proc reg data=sashelp.vote1980;
	model LogVoteRate=Pop Edu Houses Income / selection=stepwise slentry=.05 
		slstay=.10;
	run;