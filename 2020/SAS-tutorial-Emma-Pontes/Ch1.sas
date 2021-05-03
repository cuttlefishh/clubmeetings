*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 1 Getting Your Data into SAS                          **;
*******************************************************************;

*The following title will appear as the first line of every page in the output*;
title "Jue Wang EPS 704 Chapter 1";

*Read in the dataset from a txt file and convert it to a SAS dataset (Library WORK)*;
data veggies;
	infile "/folders/myfolders/Datasets/veggies.txt";
	input name $ code $ days number price;
	costperseed = price/number;
run;

proc print data=veggies;
run;

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

*Add LABEL and using SET *;
data sasdata.veggies3;
	set sasdata.veggies2;
	label name = "Vegetable name"
	      code = "Product code"
	      days = "Days to germination"
	      number = "Number of seeds"
	      price = "Retail price"
	      costperseed = "Cost of seed";
run;

*Codes for importing data from Excel Spreadsheet (auto-generated)*;

/* Generated Code (IMPORT) */
/* Source File: Wages.xlsx */
/* Source Path: /folders/myfolders/Datasets */
/* Code generated on: 4/28/20, 7:33 PM */

%web_drop_table(SASDATA.wages);

FILENAME REFFILE '/folders/myfolders/Datasets/Wages.xlsx';

PROC IMPORT DATAFILE=REFFILE
	DBMS=XLSX
	OUT=SASDATA.wages;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=SASDATA.wages; 
RUN;

%web_open_table(SASDATA.wages);

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

*Uses of PROC SORT-- sort by one variable within another variable*;
proc sort data=sasdata.veggies3 out=sasdata.veggies4;
  by descending number descending costperseed;
run;


*Save the dataset as a plain text file using DATA step*;
data _null_;
   set sasdata.veggies;
   file "/folders/myfolders/Datasets/veg_output.txt";
   put name code costperseed;
run;





