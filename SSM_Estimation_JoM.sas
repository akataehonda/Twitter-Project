* Twitter paper_GB SSM code (Local - Level Model);

* We need to save our log in a seperate file. SSM code is creating too many log output;
proc printto log="F:\ssm.log";
run;
* SSM estimation;
proc ucm data=ssm2. twitter
    noprint;
	by Datetime; * We created Datetime according to our analysis interval;
                 * For example, if we have a second-by-second frequency then;
                 * Datetime contains RIC, Year, Month, Day, Hour, Minute, Second;
	             * For instance, AAPL 20100512 142535;
	model Price;
	irregular;
	level;
	estimate outest=ssm2. twitteroutput;
run;
* tranposing our estimation results;
* In this file, there will be main two estimation outputs;
* Variances of Level (efficient price discovery) and Irregular (noise price discovery) components;
proc transpose data=ssm2. twitteroutput(keep=datetime component estimate)
               out=ssm2. twitteroutput1;
  by datetime;
  id component;
run;
