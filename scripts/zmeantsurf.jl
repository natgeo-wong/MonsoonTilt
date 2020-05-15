using DrWatson
@quickactivate "MonsoonTilt"
using IscaTools

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("zmean.jl"))

prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/isca"

zmeantsurf(prjpath,"spinup");
zmeantsurf(prjpath,"notilt");

zmeantsurf(prjpath,"tilt5-slab1");
zmeantsurf(prjpath,"tilt5-slab2");
zmeantsurf(prjpath,"tilt5-slab5");
zmeantsurf(prjpath,"tilt5-slab10");
zmeantsurf(prjpath,"tilt5-slab20");

zmeantsurf(prjpath,"tilt10-slab1");
zmeantsurf(prjpath,"tilt10-slab2");
zmeantsurf(prjpath,"tilt10-slab5");
zmeantsurf(prjpath,"tilt10-slab10");
zmeantsurf(prjpath,"tilt10-slab20");

zmeantsurf(prjpath,"tilt15-slab1");
zmeantsurf(prjpath,"tilt15-slab2");
zmeantsurf(prjpath,"tilt15-slab5");
zmeantsurf(prjpath,"tilt15-slab10");
zmeantsurf(prjpath,"tilt15-slab20");

zmeantsurf(prjpath,"tilt20-slab1");
zmeantsurf(prjpath,"tilt20-slab2");
zmeantsurf(prjpath,"tilt20-slab5");
zmeantsurf(prjpath,"tilt20-slab10");
zmeantsurf(prjpath,"tilt20-slab20");

zmeantsurf(prjpath,"tilt25-slab1");
zmeantsurf(prjpath,"tilt25-slab2");
zmeantsurf(prjpath,"tilt25-slab5");
zmeantsurf(prjpath,"tilt25-slab10");
zmeantsurf(prjpath,"tilt25-slab20");

zmeantsurf(prjpath,"tiltE-slab1");
zmeantsurf(prjpath,"tiltE-slab2");
zmeantsurf(prjpath,"tiltE-slab5");
zmeantsurf(prjpath,"tiltE-slab10");
zmeantsurf(prjpath,"tiltE-slab20");
