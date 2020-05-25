using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("common.jl"));
pplt = pyimport("proplot");

function plotaxs(config::Vector{<:AbstractString},ppltaxes::Vector{<:PyObject})

    ii = 0;
    for conii in config
        ii = ii + 1
        prcp,lat = prcpmatrix(conii);
        tsfc,lat = tsfcmatrix(conii); tsfc = tsfc .- 273.15;
        axs[ii].contourf(0.5:359.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
        axs[ii].contour(0.5:359.5,lat,tsfc,levels=0:5:40,colors="k",lw=0.5,labels=true)
        axs[ii].format(
            xlabel="Day of Year",xlim=(0,360),
            xlocator=[0,45,90,135,180,225,270,315,360],
            ylabel=L"Latitude / $\degree$",ylim=(-40,40),
            ylocator=[-40,-30,-20,-10,0,10,20,30,40],
            ultitle="$conii"
        )
    end

end

function meantsfc(config::Vector{<:AbstractString})

    for conii in config
        tsfc,lat = tsfcmatrix(conii);
        tsfc = dropdims(mean(tsfc,dims=2),dims=2)
        den = cosd.(lat); num = tsfc .* den
        mtsfc = integrate(lat,num) / integrate(lat,den)
        @info "The Mean Global Temperature for CONFIG $(uppercase(conii)) is $(mtsfc)ºC"
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
cf = axs[1].contourf([0,1],[0,1],ones(2,2)*NaN,levels=0:2.5:25,cmap="Blues")

f.colorbar(cf,loc="b",label="Daily Precipitation / mm",cols=2)
f.savefig(plotsdir("summaryplot.png"),transparent=false)

configvec = [
    "notilt",
    "tilt5-slab1","tilt5-slab5","tilt5-slab20",
    "tilt10-slab1","tilt10-slab5","tilt10-slab20",
    "tilt15-slab1","tilt15-slab5","tilt15-slab20",
    "tilt20-slab1","tilt20-slab5","tilt20-slab20",
    "tilt25-slab1","tilt25-slab5","tilt25-slab20"
]
meantsfc(configvec)
