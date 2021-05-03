*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 2 Data Summary in SAS                                 **;
*******************************************************************;

*The following title will appear as the first line of every page in the output*;
title "Jue Wang EPS 704 Chapter 2";

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

*MEANS procedure -- Default options*;
proc means data=sasdata.blood;
run;

*MEANS procedure -- use VAR statement and request specific statistics*;
proc means data=sasdata.blood n nmiss clm mean median Q1 Q3 maxdec=2;
   var RBC WBC;
run;

*MEANS procedure -- CLASS statement*;
proc means data=sasdata.blood n nmiss clm mean median Q1 Q3 maxdec=2;
   class gender;
   var RBC WBC;
run;

*Sort the data by Gender*;
proc sort data=sasdata.blood out=blood_sort;
  by gender;
run;

*MEANS procedure -- BY statement*;
proc means data=blood_sort n nmiss clm mean median Q1 Q3 maxdec=2;
   var RBC WBC;
   by gender;
run;

*MEANS procedure -- OUTPUT statement*;
proc means data=sasdata.blood n nmiss clm mean median Q1 Q3 maxdec=2;
   class gender;
   var RBC;
   output out=out_RBC mean=mean_RBC std=sd_RBC;
run;

*UNIVARIATE procedure*;
proc univariate data=sasdata.blood;
  var RBC WBC Chol;
run;

*UNIVARIATE procedure -- plots*;
proc univariate data=sasdata.blood plots;
  var Chol;
run;

*FREQ procedure -- simple use showing proportions*;
proc freq data=sasdata.blood;
  tables Gender BloodType AgeGroup;
run;

*FREQ procedure -- 2-way table*;
proc freq data=sasdata.blood;
  tables Gender*BloodType;
run;

*FREQ procedure -- 3-way table*;
proc freq data=sasdata.blood;
  tables Gender*BloodType*AgeGroup;
run;

*FREQ procedure -- Multiple 2-way tables*;
proc freq data=sasdata.blood;
  tables Gender*BloodType Gender*AgeGroup;
run;

*FREQ procedure -- 2-way table and Pearson chi-square test*;
proc freq data=sasdata.blood;
  tables Gender*BloodType /norow nocol nopercent chisq expected;
run;

*FREQ procedure -- OUTPUT statement*;
proc freq data=sasdata.blood noprint;
  tables Gender*BloodType / chisq;
  output out=blood_chisq chisq;
run;

*FREQ procedure -- WEIGHT statement*;
data blood_freq;
  input Gender$ BloodType$ frequency;
  datalines;
  Female A  178
  Female AB 20
  Female B  34
  Female O  208
  Male   A  234
  Male   AB 24
  Male   B  62
  Male   O  240
  ;
run;

proc freq data=blood_freq;
  tables Gender*BloodType / chisq;
  weight frequency;
run;

*FREQ procedure -- Exercise: survey.txt*;
data sasdata.survey;
  infile "/folders/myfolders/Datasets/survey.txt";
  input ID Gender$ Age Salary Q1-Q5;
run;

proc freq data=sasdata.survey;
  tables Gender*Q3 / norow nocum nopercent chisq;
run;

*STANDARD procedure*;
proc standard data=sasdata.blood out=standard_blood mean=0 std=1;
   var RBC WBC;
run;

*Before using PROC STANDARD*;
title "Before using PROC STANDARD";
proc means data=sasdata.blood mean std;
   var RBC WBC;
run;

*After using PROC STANDARD*;
title "After using PROC STANDARD";
proc means data=standard_blood mean std;
   var RBC WBC;
run;

