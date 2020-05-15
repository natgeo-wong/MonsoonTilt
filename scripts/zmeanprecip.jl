using DrWatson
@quickactivate "MonsoonTilt"

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("zmean.jl"))

prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/"

zmeanprecip(prjpath,"notilt");

zmeanprecip(prjpath,"tilt5-slab1");
zmeanprecip(prjpath,"tilt5-slab2");
zmeanprecip(prjpath,"tilt5-slab5");
zmeanprecip(prjpath,"tilt5-slab10");
zmeanprecip(prjpath,"tilt5-slab20");

zmeanprecip(prjpath,"tilt10-slab1");
zmeanprecip(prjpath,"tilt10-slab2");
zmeanprecip(prjpath,"tilt10-slab5");
zmeanprecip(prjpath,"tilt10-slab10");
zmeanprecip(prjpath,"tilt10-slab20");

zmeanprecip(prjpath,"tilt15-slab1");
zmeanprecip(prjpath,"tilt15-slab2");
zmeanprecip(prjpath,"tilt15-slab5");
zmeanprecip(prjpath,"tilt15-slab10");
zmeanprecip(prjpath,"tilt15-slab20");

zmeanprecip(prjpath,"tilt20-slab1");
zmeanprecip(prjpath,"tilt20-slab2");
zmeanprecip(prjpath,"tilt20-slab5");
zmeanprecip(prjpath,"tilt20-slab10");
zmeanprecip(prjpath,"tilt20-slab20");

zmeanprecip(prjpath,"tilt25-slab1");
zmeanprecip(prjpath,"tilt25-slab2");
zmeanprecip(prjpath,"tilt25-slab5");
zmeanprecip(prjpath,"tilt25-slab10");
zmeanprecip(prjpath,"tilt25-slab20");

zmeanprecip(prjpath,"tiltE-slab1");
zmeanprecip(prjpath,"tiltE-slab2");
zmeanprecip(prjpath,"tiltE-slab5");
zmeanprecip(prjpath,"tiltE-slab10");
zmeanprecip(prjpath,"tiltE-slab20");
