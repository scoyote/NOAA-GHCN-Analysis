filename stations url 'https://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt';

data stations;
	infile stations;
	input
		inputID  $    1-11    
		LATITUDE     13-20   
		LONGITUDE    22-30   
		ELEVATION    32-37   
		STATE      $  39-40   
		NAME       $  42-71   
		GSN_FLAG   $  73-75   
		HCNCRN_FLAG $ 77-79   
		WMO_ID    $   81-85   
;
run;

data NorthGA;
	set stations;
/* 	where (latitude  between 33 and 35 ) */
/* 	  and (longitude between -83.5 and -85) */
	where state = "GA"
	  and substr(inputID,3,1) = "W";
run;
proc sort data=northga; by name; 
proc print; run;