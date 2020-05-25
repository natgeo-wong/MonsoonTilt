using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("common.jl"));
pplt = pyimport("proplot");

function plotmeanclimate(config::AbstractString)

    @load srcdir("pfull.jld2") pfull; pcrp,temp,psiv,lat = climatology(config);
    pre = vcat(pfull,1000);

    pplt.close(); f,axs = pplt.subplots(ncols=2,dpi=150,sharey=0,axwidth=3,aspect=1.5)

    cf = axs[1].contourf(
        lat,pre,temp',
        levels=210:5:310,extend="both",cmap="RdBu_r"
    )
    axs[1].contour(
        lat,pfull,psiv',
        levels=-500:50:500,colors="k",lw=0.5,labels=true
    )
    axs[1].format(
        xlabel=L"Latitude / $\degree$",xscale="sine",
        ylabel="Pressure / hPa",ylim=(1000,0),
        abc=true,title="Temperature / K"
    )
    axs[1].colorbar(cf,loc="r")

    axs[2].plot(
        lat,pcrp,lw=0.5
    )
    axs[2].format(
        xlabel=L"Latitude / $\degree$",xscale="sine",
        ylabel=L"mm day$^{-1}$",ylim=(0,25),
        abc=true,title="Precipitation Rate"
    )

    f.savefig(plotsdir("meanclimate/meanclimate-$(config).png"),transparent=false)

end

function plotmeanclimate(config::Vector)

    for conii in config; plotmeanclimate(conii) end

end

configvec = [
    "notilt",
    "tilt5-slab1","tilt5-slab2","tilt5-slab5","tilt5-slab10","tilt5-slab20",
    "tilt10-slab1","tilt10-slab2","tilt10-slab5","tilt10-slab10","tilt10-slab20",
    "tilt15-slab1","tilt15-slab2","tilt15-slab5","tilt15-slab10","tilt15-slab20",
    "tilt20-slab1","tilt20-slab2","tilt20-slab5","tilt20-slab10","tilt20-slab20",
    "tilt25-slab1","tilt25-slab2","tilt25-slab5","tilt25-slab10","tilt25-slab20",
    "tiltE-slab1","tiltE-slab2","tiltE-slab5","tiltE-slab10","tiltE-slab20"
]

plotmeanclimate(configvec)
