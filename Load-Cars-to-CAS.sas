* Provide the CAS libname of where you want the Cars table to be stored;
%let targetCASLib = Public;

* Start a CAS session;
cas mySess;

* Promote the Cars table to CAS, ensuring it is fresh;
proc casUtil inCASLib="&targetCASLib." outCASLib="&targetCASLib.";
	dropTable casData='Cars' quiet;
	load data=sashelp.cars casOut='Cars';
	promote casData='Cars';
run; quit;

* Terminate the CAS session;
cas mySess terminate;

* Cleaning up the macro variable;
%symdel targetCASLib;