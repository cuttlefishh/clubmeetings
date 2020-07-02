*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 4 Combining SAS Data Sets                             **;
*******************************************************************;

*The following title will appear as the first line of every page in the output*;
title "Jue Wang EPS 704 Chapter 4";

*Vertical merging: Input datalines for Boys and Girls*;
data boys;
 input name$ sex$ age height weight;
 datalines;
 Jeffrey M 13 62.5 84
 Alfred  M 14 69 112.5
 Ronald  M 15 67 133
 Philip  M 16 72 150 
 ;
run;

data girls;
 input name$ age sex$ height;
 datalines;
 Alice   13 F 56.5
 Barbara 13 F 65.3
 Carol   14 F 62.8
 Judy    14 F 64.3
 ;
run;

*Vertically merge Boys and Girls using SET*;
data allkids;
  set boys girls;
run;

proc print data=allkids;
run;

*PROC APPEND to merge cases vertically*;
proc append base=boys data=girls;
run;

proc print data=boys;
run;


*Horizontal merging: Input data responses*;
data height;
  input id sex$ age height;
  datalines;
  1 F 25 72
  2 F 33 68
  3 F 47 65
  4 F 29 69
  5 M 37 62
  6 M 42 64
  ;


data weight;
  input id weight;
  datalines;
  1 156
  4 190
  3 182
  6 156
  9 129
  ;
run;

*Sort both datasets by ID*;
proc sort data=height;
  by ID;
run;

proc sort data=weight;
  by ID;
run;

*Horizontally merge two datasets*;
data fulldata;
  merge height weight;
  by id;
run;

proc print data=fulldata;
run;

*Horizontally merge two datasets -- cases in both datasets*;
data completedata;
  merge height(in=a) weight(in=b);
  by id;
  if a and b;
run;

proc print data=completedata;
run;

*Horizontally merge two datasets -- cases in dataset Height*;
*only data from a;
data partialheight;
  merge height(in=a) weight(in=b);
  by id;
  if a;
run;

proc print data=partialheight;
run;

*only subjects that appear in b;
*selecting subsets of data;
data partialheight;
  merge height(in=a) weight(in=b);
  by id;
  if b;
run;

proc print data=partialheight;
run;

*Example I -- Merge in both directions (add cases and variables)*;
data oldsalary;
  input name$ ID sex$ age salary jobcat year;
  datalines;
  Roger  518 M 45 7677 2 1989
  Martha 321 F 28 5000 1 1989
  Zeke   444 M 33 6075 1 1989
  Barb  1728 F 40 9023 2 1989
  Bill   993 M 36 7739 3 1989
  Sandy 1002 F 29 6161 3 1989
  ;

data newsalary;
  input name$ ID salary jobcat year;
  datalines;
  Hank   108 11138 1 1995
  Fred   519 10035 2 1995
  Zeke   444  9697 1 1995
  Martha 321  7987 2 1995
  Sandy 1002  6995 2 1995
  Bill   993 12400 3 1995
  Roxy   773 10119 2 1995
  ;
run;

*Sort by ID*;
proc sort data=oldsalary;
  by ID;
run;

proc sort data=newsalary;
  by ID;
run;

*Merge with RENAME option*;
data combine1;
  merge oldsalary (rename=(salary=salary89 jobcat=jobcat89))
        newsalary (rename=(salary=salary95 jobcat=jobcat95));
  by ID;
  drop year;
run;

proc print data=combine1;
run;


*Example II -- one-to-many merging*;
data time_varying;
  input ID date:mmddyy10. weight height;
  format date mmddyy10.;
  datalines;
  4 01/09/2007 117 82
  2 03/15/2007 111 74
  2 04/25/2007 108 65
  1 05/17/2007 145 94
  1 11/22/2007 130 90
  1 01/12/2008 120 80
  3 01/22/2008 128 83
  ;

data one_per_line;
  input ID sex$ DOB:mmddyy10.;
  format DOB mmddyy10.;
  datalines;
  3 M 12/01/1980
  1 F 01/10/1978
  2 F 05/15/1976
  4 M 04/11/1981
  5 F 07/17/1980
  ;
run;

*Sort by ID*;
proc sort data=time_varying;
  by ID;
run;

proc sort data=one_per_line;
  by ID;
run;

*Merge two datasets using default options*;
data combine2;
  merge time_varying one_per_line;
  by ID;
run;

proc print data=combine2;
run;




