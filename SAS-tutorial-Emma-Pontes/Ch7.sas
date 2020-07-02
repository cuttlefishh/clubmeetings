*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 7 Macro in SAS                                        **;
*******************************************************************;

/*Example 1 Create a general title using %LET*/;
%let title = "Jue Wang EPS 704 Chapter 7";

data time;
	time=hour(time());
	minute=minute(time());
	second=second(time());
	month=month(today());
	day=day(today());
	year=year(today());
run;

/*Print the current time with two titles*/;
title1 &title;
title2 "The date and time is:";

proc print data=time;
run;

/*Print the current date with two titles*/;
title1 &title;
title2 "The date is:";

proc print data=time;
	var month day year;
run;

/*Print the current time with two titles*/;
title1 &title;
title2 "The time is:";

proc print data=time;
	var time minute second;
run;

/*Example 2 Define the sample size with %LET*/;
%let n=10000;

data normal;
	do i=1 to &n;
		norm=normal(0);
		output;
	end;

proc print data=normal;
run;

/*We create different datasets by using macro variable in creating dataset name*/;

data normal&n;
	do i=1 to &n;
		norm=normal(0);
		output;
	end;

	/*Produce histograms to compare the distributions of generated datasets*/;
	title2 "Distribution for dataset with a sample size=&n";

proc sgplot data=normal&n;
	histogram norm;
	density norm;
run;

/*Example 3 Write to LOG window using %PUT*/;
%put n=&n;
%put Standard normal distribution with different sample sizes;

/*Example 4 Include another SAS program using %INCLUDE*/;
%include "/folders/myfolders/SASprograms/small_prog.sas";

/*Example 5 Write a simple Macro*/;

%macro printit(dataset);
	title "First 10 observations of &dataset";

	proc print data=&dataset (obs=10);
	run;

%mend printit;

%printit(sasdata.blood);
%printit(sashelp.stocks);

/*Example 6 - simulate data with a DATA step*/;

data normal (keep=x);
	call streaminit(1234);

	do i=1 to 100;
		x=rand("Normal");
		output;
	end;
run;

/*Create a histogram for generated numbers -- x*/;
proc sgplot data=normal;
   histogram x;
run;

/*Example 7 - simulate data with PROC IML -- RANDGEN*/;

%let N = 100;

proc iml;
call randseed(1234);         
      /*Specify a seed number that initializes the random number stream; same use as STREAMINIT in a DATA step.*/;
x = j(&N, 1);                
      /*The J function defines a matrix J(r, c) with N number of rows and 1 column --> vector; assign it to x.*/;
call randgen (x, "Normal");  
     /*RANDGEN: produces random numbers from a specified distribution to fill in the matrix x.*/;
print x;                     
     /*Print the matrix x to the RESULTS window.*/;
run;

/*Save the generated data in a SAS dataset*/;

proc iml;
call randseed(1234);
x = j(&N, 1);
call randgen (x, "Normal", 0, 1);
create normal;   /*Define a dataset named normal.*/;
append var{x};   /*Add x as a variable to the dataset normal.*/;
close normal;    /*Tell SAS that we are done with writing this dataset.*/;
run;

proc print data=normal;
run;


/*Example 8 - generate random numbers with uniform distribution in PROC IML*/;

proc iml;
y = repeat(0,20,1);
     /*The REPEAT function creates a matrix of repeated values -> A 20 by 1 ZERO matrix (all entries are 0)*/;
u=uniform(repeat(0,20,1)); 
     /*uniform(0) produces a random number between 0 and 1 --> it generates 20 random numbers*/;  
do i = 1 to 20;
	if u[i]>0.5 then y[i]=1;  /*If u[i] > 0.5, assign 1 to y[i]; otherwise, leave it as 0.*/;
end;
print u y;
run;








