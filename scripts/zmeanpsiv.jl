using DrWatson
@quickactivate "MonsoonTilt"
using IscaTools

global_logger(ConsoleLogger(stdout,Logging.Info))
include(srcdir("zmean.jl"))

prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/isca"

zmeanpsiv500(prjpath,"spinup");
zmeanpsiv500(prjpath,"notilt");

zmeanpsiv500(prjpath,"tilt5-slab1");
zmeanpsiv500(prjpath,"tilt5-slab2");
zmeanpsiv500(prjpath,"tilt5-slab5");
zmeanpsiv500(prjpath,"tilt5-slab10");
zmeanpsiv500(prjpath,"tilt5-slab20");

zmeanpsiv500(prjpath,"tilt10-slab1");
zmeanpsiv500(prjpath,"tilt10-slab2");
zmeanpsiv500(prjpath,"tilt10-slab5");
zmeanpsiv500(prjpath,"tilt10-slab10");
zmeanpsiv500(prjpath,"tilt10-slab20");

zmeanpsiv500(prjpath,"tilt15-slab1");
zmeanpsiv500(prjpath,"tilt15-slab2");
zmeanpsiv500(prjpath,"tilt15-slab5");
zmeanpsiv500(prjpath,"tilt15-slab10");
zmeanpsiv500(prjpath,"tilt15-slab20");

zmeanpsiv500(prjpath,"tilt20-slab1");
zmeanpsiv500(prjpath,"tilt20-slab2");
zmeanpsiv500(prjpath,"tilt20-slab5");
zmeanpsiv500(prjpath,"tilt20-slab10");
zmeanpsiv500(prjpath,"tilt20-slab20");

zmeanpsiv500(prjpath,"tilt25-slab1");
zmeanpsiv500(prjpath,"tilt25-slab2");
zmeanpsiv500(prjpath,"tilt25-slab5");
zmeanpsiv500(prjpath,"tilt25-slab10");
zmeanpsiv500(prjpath,"tilt25-slab20");

zmeanpsiv500(prjpath,"tiltE-slab1");
zmeanpsiv500(prjpath,"tiltE-slab2");
zmeanpsiv500(prjpath,"tiltE-slab5");
zmeanpsiv500(prjpath,"tiltE-slab10");
zmeanpsiv500(prjpath,"tiltE-slab20");
