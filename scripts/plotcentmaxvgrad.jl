using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using LaTeXStrings

include(srcdir("centmax.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function plotaxs(config::Vector{<:AbstractString},ppltaxes::Vector{<:PyObject})

    ii = 0;
    for conii in config
        ii = ii + 1
        prcp,lat = prcpmatrix(conii); itczmax,itczcent = findITCZ(prcp,lat)
        maxpent,maxgrad  = migration(itczmax);
        centpent,centgrad = migration(itczcent);
        # axs[ii].plot(centpent,centgrad,c="blue1",lw=1)
        axs[ii].plot(maxpent,maxgrad,c="blue6",lw=1)
        axs[ii].scatter(maxpent,maxgrad,c="blue6",markersize=1)

        tsfc,lat = tsfcmatrix(conii); heatmax,heatcent = findHEAT(tsfc,lat)
        maxpent,maxgrad  = migration(heatmax);
        centpent,centgrad = migration(heatcent);
        # axs[ii].plot(centpent,centgrad,c="red1",lw=1)
        axs[ii].plot(maxpent,maxgrad,c="red6",lw=1)
        axs[ii].scatter(maxpent,maxgrad,c="red6",markersize=1)
        axs[ii].format(
            xlabel=L"$\phi_{max}$",xlim=(-40,40),
            ylabel=L"$\partial_t\phi_{max}$ / $\degree$ day$^{-1}$",ylim=(-2,2),
            urtitle="$conii"
        )
    end

end

pplt.close(); f,axs = pplt.subplots(nrows=2,ncols=3,axwidth=2,)

configvec = [
    "tilt15-slab1","tilt15-slab5","tilt15-slab20",
    "tilt25-slab1","tilt25-slab5","tilt25-slab20"
]

plotaxs(configvec,axs)

f.savefig(plotsdir("centroidgrad.png"),transparent=false,dpi=200)
