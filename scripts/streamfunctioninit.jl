using DrWatson
@quickactivate "MonsoonTilt"
using IscaTools

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("compiled.jl"))

prj = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/"

streamfunctioninit(prjpath=prj,config="notilt");
streamfunctioninit(prjpath=prj,config="tilt5-slab1");
streamfunctioninit(prjpath=prj,config="tilt5-slab2");
streamfunctioninit(prjpath=prj,config="tilt5-slab5");
streamfunctioninit(prjpath=prj,config="tilt5-slab10");
streamfunctioninit(prjpath=prj,config="tilt5-slab20");
streamfunctioninit(prjpath=prj,config="tilt10-slab1");
streamfunctioninit(prjpath=prj,config="tilt10-slab2");
streamfunctioninit(prjpath=prj,config="tilt10-slab5");
streamfunctioninit(prjpath=prj,config="tilt10-slab10");
streamfunctioninit(prjpath=prj,config="tilt10-slab20");
streamfunctioninit(prjpath=prj,config="tilt15-slab1");
streamfunctioninit(prjpath=prj,config="tilt15-slab2");
streamfunctioninit(prjpath=prj,config="tilt15-slab5");
streamfunctioninit(prjpath=prj,config="tilt15-slab10");
streamfunctioninit(prjpath=prj,config="tilt15-slab20");
streamfunctioninit(prjpath=prj,config="tilt20-slab1");
streamfunctioninit(prjpath=prj,config="tilt20-slab2");
streamfunctioninit(prjpath=prj,config="tilt20-slab5");
streamfunctioninit(prjpath=prj,config="tilt20-slab10");
streamfunctioninit(prjpath=prj,config="tilt20-slab20");
streamfunctioninit(prjpath=prj,config="tilt25-slab1");
streamfunctioninit(prjpath=prj,config="tilt25-slab2");
streamfunctioninit(prjpath=prj,config="tilt25-slab5");
streamfunctioninit(prjpath=prj,config="tilt25-slab10");
streamfunctioninit(prjpath=prj,config="tilt25-slab20");
