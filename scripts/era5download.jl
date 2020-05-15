using DrWatson
@quickactivate "MonsoonTilt"
using ClimateERA

global_logger(ConsoleLogger(stdout,Logging.Info))

prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/ecmwf/";
init,eroot = erastartup(aID=1,dID=1,path=prjpath);
gregioninfoadd(srcdir("addGeoRegions.txt"));

eradownload(init,eroot,modID="msfc",parID="prcp_tot",regID="ASM",timeID=[1980,2019])
eradownload(init,eroot,modID="dpre",parID="t_air",regID="ASM",timeID=[1980,2019])
