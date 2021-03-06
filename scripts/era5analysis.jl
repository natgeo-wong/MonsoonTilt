using DrWatson
@quickactivate "MonsoonTilt"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))

prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/ecmwf/";
init,eroot = erastartup(aID=1,dID=1,path=prjpath); t = [1980,2019];
gregioninfoadd(srcdir("addGeoRegions.txt"));

eranalysis(init,eroot,modID="msfc",parID="prcp_tot",regID="ASM",timeID=t,plvls="sfc");
eranalysis(init,eroot,modID="dpre",parID="t_air",regID="ASM",timeID=t,plvls=1000);
