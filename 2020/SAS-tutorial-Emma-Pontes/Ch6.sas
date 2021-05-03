*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 5 Analysis of Variance (ANOVA) in SAS                 **;
*******************************************************************;

*The following title will appear as the first line of every page in the output*;
title "Jue Wang EPS 704 Chapter 6";

*One-way ANOVA with PROC GLM*;
proc glm data=sashelp.cars;
  class type;
  model MPG_Highway = type;
  means type / tukey;
run;

*Create a subset of data cars*;
data cars_sub;
  set sashelp.cars;
   where drivetrain in ('Front' 'Rear');
run;

*Independent samples t-test with PROC TTEST*;
proc ttest data=cars_sub;
   class drivetrain;
   var MPG_Highway;
run;

*Paired samples t-test with PROC TTEST*;
data sasdata.pizza;
  input subject A B;
  datalines;
  1  12.9 16.0
  2   5.7  7.5
  3  16.0 16.0
  4  14.3 15.7
  5   2.4 13.2
  6   1.6  5.4
  7  14.6 15.5
  8  10.2 11.3
  9   4.3 15.4
  10  6.6 10.6
  ;
run;

proc ttest data=sasdata.pizza;
  paired A*B;
run;


*Regression analysis with PROC GLM*;
proc glm data=sashelp.class;
   model Weight = Height;
run;

*Mixed-types of predictors using PROC GLM (Equal slopes)*;
proc glm data=sashelp.class;
  class Sex;
  model Weight = Height Sex;
run;

*Mixed-types of predictors using PROC GLM (Varying slopes)*;
proc glm data=sashelp.class;
  class Sex;
  model Weight = Height Sex Height*Sex;
run;



