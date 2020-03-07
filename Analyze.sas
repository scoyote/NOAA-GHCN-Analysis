
%macro PullStation(dsname,id);
	data &dsname;
		set daily.allstations (where = (ID = "&id"))	;
	run;
	proc sort data=&dsname;
		by id datestamp element;
	run;
	
	/* put the observations in columns by date */
	proc transpose 
			data=&dsname
			out=daily.&dsname._71_20 (drop=element)
			name=element;
		by id datestamp;
		id element;
		where element in ('PRCP','TMAX','TMIN','PSUN');
	run;
	
	proc export data=daily.&dsname._71_20 
	            file="/data/&dsname..csv"
	            dbms=csv replace;
	run;
%mend PullStation;

libname daily '/data/';
%pullstation(KATL,USW00013874);
%pullstation(ATL_PEACHTREE_AP,USW00053863);
%pullstation(MARIETTA_DOBBINS_AFB,USW00013864);
%pullstation(ATLANTA_FULTON_CO_AP,USW00003888);
%pullstation(CARTERSVILLE_AP,USW00053873);


data Cartersville_recent;
	set daily.Cartersville_ap_71_20;
	format datestamp 8.;
	*where datestamp > '01JAN2020'd ;*and weekday(datestamp) = 2;
run;

/* Stream a CSV representation of SASHELP.CARS directly to the user's browser. */
proc export data=daily.katl_71_20
            file='/data/KATL.csv'
            dbms=csv replace;
run;
proc export data=daily.Cartersville_ap_71_20
            file='/data/cartersville_ap.csv'
            dbms=csv replace;
run;



/*  */
/*  */
/* data KATL; */
/* 	set daily.allstations (where = (ID = 'USW00013874'))	; */
/* 	where element in ('PRCP','TMAX','TMIN','PSUN'); */
/* run; */
/* proc sort data=KATL; */
/* 	by id datestamp element; */
/* run; */
/*  */
/* put the observations in columns by date */
/* proc transpose  */
/* 		data=KATL */
/* 		out=daily.KATL_71_20 (drop=element) */
/* 		name=element; */
/* 	by id datestamp; */
/* 	id element; */
/* run; */
/*  */
/* data Mondays; */
/* 	set daily.d_71_20; */
/* 	where datestamp > '01JAN2019'd and weekday(datestamp) = 2; */
/* run; */
/*  */
/*  */
/*  */
/*  */
/*  */
/* data ATL_PEACHTREE_AP; */
/* 	set daily.allstations (where = (ID = 'USW00053863'))	; */
/* 	where element in ('PRCP','TMAX','TMIN','PSUN'); */
/* 	 */
/* run; */
/* proc sort data=ATL_PEACHTREE_AP; */
/* 	by id datestamp element; */
/* 	where element in ('PRCP','TMAX','TMIN','PSUN'); */
/* run; */
/*  */
/* put the observations in columns by date */
/* proc transpose  */
/* 		data=ATL_PEACHTREE_AP */
/* 		out=daily.ATL_PEACHTREE_AP_71_20 (drop=element) */
/* 		name=element; */
/* 	by id datestamp; */
/* 	id element; */
/* run; */
/*  */
/* data ATL_PEACHTREE_AP_recent; */
/* 	set daily.ATL_PEACHTREE_AP_71_20; */
/* 	format datestamp WEEKDATX.; */
/* 	where datestamp > '01JAN2020'd ;*and weekday(datestamp) = 2; */
/* run; */



