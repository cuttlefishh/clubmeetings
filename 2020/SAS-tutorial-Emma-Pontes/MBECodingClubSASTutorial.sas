*******************************************************************;
** Author: Emma Pontes                                           **;
** MBE Coding Club: SAS Intro                                    **;
*******************************************************************;

****** Chapter 1: Getting Data Into SAS ******;

*The following title will appear as the first line of every page in the output*;
title "Emma Pontes SAS Tutorial";

*Read in the dataset from a txt file and convert it to a SAS dataset (Library SASDATA)*;
data sasdata.veggies;
	infile "/folders/myfolders/Datasets/veggies.txt";
	input name $ code $ days number price;
	costperseed = price/number;
run;

proc print data=sasdata.veggies;
run;

*Input data directly using DATALINES and store it in the Library SASDATA*;
data sasdata.veggies2;
	input name$ code$ days number price;
	costperseed = price/number;
	datalines;
	Cucumber 50104-A 55 30   195
    Cucumber 51789-A 56 30   225
    Carrot   50179-A 68 1500 395
    Carrot   50872-A 65 1500 225
    Corn     57224-A 75 200  295
    Corn     62471-A 80 200  395
    Corn     57828-A 66 200  295
    Eggplant 52233-A 70 30   225
    ;
run;

proc print data=sasdata.veggies2;
run;

*Options in PROC PRINT*;
proc print data=sasdata.veggies3 noobs;
     where costperseed > 1;
     format costperseed dollar.2;
     var name code costperseed;
run;

*Uses of PROC SORT-- sort by one variable*;
proc sort data=sasdata.veggies3;
  by descending costperseed;
run;

proc print data=sasdata.veggies3;
run;

****** Chapter 2: Data Summary in SAS ******;

*Import data using INFILE*;
data sasdata.blood;
  infile "/folders/myfolders/Datasets/blood.txt";
  input Subject Gender$ BloodType$ AgeGroup$ WBC RBC Chol;
  label BloodType = "Blood type"
        AgeGroup = "Age group"
        WBC = "White blood cells"
        RBC = "Red blood cells"
        Chol = "Cholesterol";
run;
proc print data=sasdata.blood;
run;

*MEANS procedure -- Default options*;
proc means data=sasdata.blood;
run;

*MEANS procedure -- use VAR statement and request specific statistics*;
proc means data=sasdata.blood n nmiss clm mean median Q1 Q3 maxdec=4;
   var RBC WBC;
run;

*MEANS procedure -- CLASS statement*;
*Both genders in one table;
proc means data=sasdata.blood n nmiss clm mean median Q1 Q3 maxdec=2;
   class gender;
   var RBC WBC;
run;

*Sort the data by Gender*;
proc sort data=sasdata.blood out=blood_sort;
  by gender;
run;

*MEANS procedure -- BY statement*;
*Separate tables for each gender;
proc means data=blood_sort n nmiss clm mean median Q1 Q3 maxdec=2;
   var RBC WBC;
   by gender;
run;

*FREQ procedure -- 2-way table*;
*Can also do multiple 2-way tables;
proc freq data=sasdata.blood;
  tables Gender*BloodType;
run;

*FREQ procedure -- 3-way table*;
proc freq data=sasdata.blood;
  tables Gender*BloodType*AgeGroup;
run;

*FREQ procedure -- 2-way table and Pearson chi-square test*;
proc freq data=sasdata.blood;
  tables Gender*BloodType /norow nocol nopercent chisq expected;
run;

*FREQ procedure -- OUTPUT statement*;
*Save your results in work library;
proc freq data=sasdata.blood noprint;
  tables Gender*BloodType / chisq;
  output out=blood_chisq chisq;
run;

*UNIVARIATE procedure*;
*Lots of useful stats for variables!;
proc univariate data=sasdata.blood;
  var RBC WBC Chol;
run;

****** Chapter 3: SAS Graphs ******;

*Simple Histogram for Height*;
proc sgplot data=sashelp.class;
  histogram height;
  title "Height Histogram";
run;

*Histogram for Height with normal density curve*;
proc sgplot data=sashelp.class;
  histogram height;
  density height;
  title "Height with Normal Density Curve";
run;

*Boxplot -- Height by gender*;
proc sgplot data=sashelp.class;
  hbox height / category=sex;
  title "Height by Gender";
run;

*Boxplot -- actual sale by countries per quarter*;
*Grouping with Box plots;
proc sgplot data=sashelp.prdsale;
  hbox actual / category=country group=quarter;
run;

*Bar chart -- two charts overlapped*;
proc sgplot data=sashelp.prdsale;
  yaxis label="Sales" min=200000;
  vbar country / response=predict;
  vbar country / response=actual
                  barwidth=0.5
                  transparency=0.2;
run;

*Scatterplot -- Height by Weight*;
proc sgplot data=sashelp.class;
  scatter x=height y=weight ;
  title "Scatter Plot of Height vs. Weight";
run;

*Scatterplot -- Height by Weight separated by gender*;
proc sgplot data=sashelp.class;
  scatter x=height y=weight / group=sex;
  title "Scatter Plot Separated by Gender";
run;

*Scatterplot with regression line -- Height by Weight*;
proc sgplot data=sashelp.class;
   reg y=weight x=height / group=sex;
   title "Scatter Plot with Regression Lines";
run;

*Line plot -- Three stocks over years*;
proc sgplot data=sashelp.stocks;
   series x=date y=close / group=stock;
   title "Line Plot of Stocks";
run;

****** Chapter 5: Regression Analysis (yes we are skipping chapter 4 for now)***;

*Pearson correlation analysis*;
proc corr data=sashelp.class cov;
	var height weight;
run;

*Simple linear regression with PROC REG*;
*lots of good plots and stats!;
proc reg data=sashelp.class;
	model Weight=Height / clb cli p r;
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
	
****** Chapter 6: Analysis of Variance ******;

*One-way ANOVA with PROC GLM*;
*one independent variable;
*difference between car types in terms of their highway mpg;
*dependent on left, independent on right;
*continuous variable is dependent;
*mean for each type of car;
proc glm data=sashelp.cars;
  class type;
  model MPG_Highway = type;
  means type / tukey;
run;

*Create a subset of data cars*;
*extract values from Front and Rear only from sashelp.cars;
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
*which pizza is more popular?;
*how much of the 16oz pizza is left?;
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