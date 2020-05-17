using DrWatson
@quickactivate "MonsoonTilt"

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("isca.jl"))

prj = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/isca"

precipanalysis(prjpath=prj,config="notilt");
precipanalysis(prjpath=prj,config="tilt5-slab1");
precipanalysis(prjpath=prj,config="tilt5-slab2");
precipanalysis(prjpath=prj,config="tilt5-slab5");
precipanalysis(prjpath=prj,config="tilt5-slab10");
precipanalysis(prjpath=prj,config="tilt5-slab20");
precipanalysis(prjpath=prj,config="tilt10-slab1");
precipanalysis(prjpath=prj,config="tilt10-slab2");
precipanalysis(prjpath=prj,config="tilt10-slab5");
precipanalysis(prjpath=prj,config="tilt10-slab10");
precipanalysis(prjpath=prj,config="tilt10-slab20");
precipanalysis(prjpath=prj,config="tilt15-slab1");
precipanalysis(prjpath=prj,config="tilt15-slab2");
precipanalysis(prjpath=prj,config="tilt15-slab5");
precipanalysis(prjpath=prj,config="tilt15-slab10");
precipanalysis(prjpath=prj,config="tilt15-slab20");
precipanalysis(prjpath=prj,config="tilt20-slab1");
precipanalysis(prjpath=prj,config="tilt20-slab2");
precipanalysis(prjpath=prj,config="tilt20-slab5");
precipanalysis(prjpath=prj,config="tilt20-slab10");
precipanalysis(prjpath=prj,config="tilt20-slab20");
precipanalysis(prjpath=prj,config="tilt25-slab1");
precipanalysis(prjpath=prj,config="tilt25-slab2");
precipanalysis(prjpath=prj,config="tilt25-slab5");
precipanalysis(prjpath=prj,config="tilt25-slab10");
precipanalysis(prjpath=prj,config="tilt25-slab20");
