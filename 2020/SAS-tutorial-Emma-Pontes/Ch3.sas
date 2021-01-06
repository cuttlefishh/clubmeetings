*******************************************************************;
** Author: Jue Wang                                              **;
** Course: EPS 704                                               **;
** Chapter 3 SAS Graphs                                          **;
*******************************************************************;

*The following title will appear as the first line of every page in the output*;
title "Jue Wang EPS 704 Chapter 3";

*Dataset class in SASHELP library*;
proc print data=sashelp.class (obs=5);
run;

*Frequency for Gender*;
proc freq data=sashelp.class;
   tables gender;
run;

*Descriptive statistics*;
proc means data=sashelp.class;
   var age height weight;
run;

proc freq data=sashelp.class;
   tables sex;
run;

*Simple Histogram for Height*;
proc sgplot data=sashelp.class;
  histogram height;
run;

*Histogram for Height with normal density curve*;
proc sgplot data=sashelp.class;
  histogram height;
  density height;
run;

*Boxplot -- Height by gender*;
proc sgplot data=sashelp.class;
  hbox height / category=sex;
run;

*Boxplot -- actual sale by countries per quarter*;
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
  scatter x=height y=weight;
run;

*Scatterplot -- Height by Weight separated by gender*;
proc sgplot data=sashelp.class;
  scatter x=height y=weight / group=sex;
run;

*Scatterplot with regression line -- Height by Weight*;
proc sgplot data=sashelp.class;
   reg y=weight x=height / group=sex;
run;

*Scatterplot with user defined markers -- Height by Weight*;
proc sgplot data=sashelp.class;
  scatter x=height y=weight / markerattrs=(color=red size=10 symbol=trianglefilled);
run;

*Line plot -- Three stocks over years*;
proc sgplot data=sashelp.stocks;
   series x=date y=close / group=stock;
run;

*Line plot -- Display only two stocks over years*;
proc sgplot data=sashelp.stocks;
   where stock in ('IBM', 'Microsoft');
   series x=date y=close / group=stock;
run;

*Line plot -- Multiple SERIES statements*;
proc sgplot data=sashelp.stocks;
   where stock in ('Intel');
   series x=date y=high;
   series x=date y=low;
   series x=date y=close;
run;

*Line plot -- COVID-19 cases of Florida*;
proc sgplot data=us;
   where state in ('Florida');
   series x=date y=cases;
   series x=date y=deaths / y2axis;
run;

*Line plot -- COVID-19 cases of China, Italy, and USA*;
proc sgplot data=world;
   where countrycode in ('CHN','ITA','USA');
   series x=date y=cases / group=country Lineattrs = (thickness = 2.5);
run;





