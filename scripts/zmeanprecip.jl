using DrWatson
@quickactivate "MonsoonTilt"
using IscaTools

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("compiled.jl"))

prj = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/"

zmeanprecip(prjpath=prj,config="notilt");
zmeanprecip(prjpath=prj,config="tilt5-slab1");
zmeanprecip(prjpath=prj,config="tilt5-slab2");
zmeanprecip(prjpath=prj,config="tilt5-slab5");
zmeanprecip(prjpath=prj,config="tilt5-slab10");
zmeanprecip(prjpath=prj,config="tilt5-slab20");
zmeanprecip(prjpath=prj,config="tilt10-slab1");
zmeanprecip(prjpath=prj,config="tilt10-slab2");
zmeanprecip(prjpath=prj,config="tilt10-slab5");
zmeanprecip(prjpath=prj,config="tilt10-slab10");
zmeanprecip(prjpath=prj,config="tilt10-slab20");
zmeanprecip(prjpath=prj,config="tilt15-slab1");
zmeanprecip(prjpath=prj,config="tilt15-slab2");
zmeanprecip(prjpath=prj,config="tilt15-slab5");
zmeanprecip(prjpath=prj,config="tilt15-slab10");
zmeanprecip(prjpath=prj,config="tilt15-slab20");
zmeanprecip(prjpath=prj,config="tilt20-slab1");
zmeanprecip(prjpath=prj,config="tilt20-slab2");
zmeanprecip(prjpath=prj,config="tilt20-slab5");
zmeanprecip(prjpath=prj,config="tilt20-slab10");
zmeanprecip(prjpath=prj,config="tilt20-slab20");
zmeanprecip(prjpath=prj,config="tilt25-slab1");
zmeanprecip(prjpath=prj,config="tilt25-slab2");
zmeanprecip(prjpath=prj,config="tilt25-slab5");
zmeanprecip(prjpath=prj,config="tilt25-slab10");
zmeanprecip(prjpath=prj,config="tilt25-slab20");
