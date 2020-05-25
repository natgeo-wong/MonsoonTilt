using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("centmax.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function plotaxs(config::Vector{<:AbstractString},ppltaxes::Vector{<:PyObject})

    ii = 0;
    for conii in config
        ii = ii + 1
        prcp,lat = prcpmatrix(conii); itczmax,_ = findITCZ(prcp,lat);
        tsfc,lat = tsfcmatrix(conii); heatmax,_ = findHEAT(tsfc,lat);
        psiv,lat = psivmatrix(conii);
        axs[ii].contourf(0.5:359.5,lat,psiv,levels=(-8:2:8)*100,cmap="RdBu_r",extend="both")
        axs[ii].plot(0.5:359.5,itczmax,c="b",lw=1)
        axs[ii].plot(0.5:359.5,heatmax,c="r",lw=1)
        axs[ii].contour(0.5:359.5,lat,psiv,levels=0:0,colors="k",linestyle=":")
        axs[ii].format(
            xlabel="Day of Year",xlim=(0,360),
            xlocator=[0,45,90,135,180,225,270,315,360],
            ylabel=L"Latitude / $\degree$",ylim=(-40,40),
            ylocator=[-40,-30,-20,-10,0,10,20,30,40],
            ultitle="$conii"
        )
    end

end

pplt.close(); f,axs = pplt.subplots(nrows=5,ncols=3,aspect=1.8,dpi=200)

configvec = [
    "tilt5-slab1","tilt5-slab5","tilt5-slab20",
    "tilt10-slab1","tilt10-slab5","tilt10-slab20",
    "tilt15-slab1","tilt15-slab5","tilt15-slab20",
    "tilt20-slab1","tilt20-slab5","tilt20-slab20",
    "tilt25-slab1","tilt25-slab5","tilt25-slab20"
]

plotaxs(configvec,axs)
cf = axs[1].contourf([0,1],[0,1],ones(2,2)*NaN,levels=(-8:2:8)*100,cmap="RdBu_r",extend="both")

f.colorbar(cf,loc="b",label=L"Mean Meridional Streamfunction / 10$^9$ kg s$^{-1}$",cols=2)
f.savefig(plotsdir("summaryplot-psivprcp.png"),transparent=false)
