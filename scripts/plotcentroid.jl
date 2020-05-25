using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("centmax.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function findITCZ(prcp::Array{<:Real,2},lat::Vector{<:Real})
    nlat,nt = size(prcp); pt = zeros(nlat);
    itczmax = zeros(nt); itczmaxA = zeros(nt);
    itczcent = zeros(nt); itczcentF = zeros(nt)
    for it = 1 : nt
        for ilat = 1 : nlat; pt[ilat] = prcp[ilat,it]; end
        itczmax[it]  = maxlat(pt,lat,10,ϕN=90,ϕS=-90)
        itczmaxA[it] = maxAlat(pt,lat)
        itczcent[it] = centlat(pt,lat,ϕN=45,ϕS=-45)
        itczcentF[it] = centFlat(pt,lat)
    end
    return itczmax,itczmaxA,itczcent,itczcentF
end

function findHEAT(tsfc::Array{<:Real,2},lat::Vector{<:Real})
    nlat,nt = size(tsfc); tt = zeros(nlat);
    heatmax = zeros(nt); heatmaxA = zeros(nt);
    heatcent = zeros(nt); heatcentF = zeros(nt)
    for it = 1 : nt
        for ilat = 1 : nlat; tt[ilat] = tsfc[ilat,it]; end
        heatmax[it]   = maxlat(tt,lat,20,ϕN=90,ϕS=-90)
        heatmaxA[it]  = maxAlat(tt,lat)
        heatcent[it]  = centlat(tt,lat,ϕN=90,ϕS=-90)
        heatcentF[it] = centFlat(tt,lat)
    end
    return heatmax,heatmaxA,heatcent,heatcentF
end

function plotaxs(config::Vector{<:AbstractString},ppltaxes::Vector{<:PyObject})

    ii = 0;
    for conii in config
        ii = ii + 1
        prcp,lat = prcpmatrix(conii);
        itczmax,itczmaxA,itczcent,itczcentF = findITCZ(prcp,lat)
        axs[ii].contourf(0.5:359.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
        axs[ii].plot(0.5:359.5,itczmaxA,c="r")
        axs[ii].plot(0.5:359.5,itczmax,c="k",linestyle=":")
        axs[ii].plot(0.5:359.5,itczcentF,c="b")
        axs[ii].plot(0.5:359.5,itczcent,c="w",linestyle=":")
        axs[ii].format(
            xlabel="Day of Year",xlim=(0,360),
            xlocator=[0,45,90,135,180,225,270,315,360],
            ylabel=L"Latitude / $\degree$",ylim=(-40,40),
            ylocator=[-40,-30,-20,-10,0,10,20,30,40],
            ultitle="$(conii)"
        )

        tsfc,lat = tsfcmatrix(conii);
        heatmax,heatmaxA,heatcent,heatcentF = findHEAT(tsfc,lat)
        axs[ii+3].contourf(0.5:359.5,lat,tsfc,levels=270:2.5:310)
        axs[ii+3].plot(0.5:359.5,heatmaxA,c="r")
        axs[ii+3].plot(0.5:359.5,heatmax,c="k",linestyle=":")
        axs[ii+3].plot(0.5:359.5,heatcentF,c="b")
        axs[ii+3].plot(0.5:359.5,heatcent,c="w",linestyle=":")
        axs[ii+3].format(
            xlabel="Day of Year",xlim=(0,360),
            xlocator=[0,45,90,135,180,225,270,315,360],
            ylabel=L"Latitude / $\degree$",ylim=(-40,40),
            ylocator=[-40,-30,-20,-10,0,10,20,30,40]
        )
    end

end

pplt.close(); f,axs = pplt.subplots(nrows=2,ncols=3,aspect=1.5,axwidth=2,hspace=0.15)

configvec = [
    "tilt5-slab1","tilt15-slab1","tilt25-slab1"
]

plotaxs(configvec,axs)
cf1 = axs[1].contourf([0,1],[0,1],ones(2,2)*NaN,levels=0:2.5:25,cmap="Blues")
cf2 = axs[1].contourf([0,1],[0,1],ones(2,2)*NaN,levels=270:2.5:310)

f.colorbar(cf1,loc="r",rows=1,label=L"Rainfall / mm day$^{-1}$")
f.colorbar(cf2,loc="r",rows=2,label="Temperature / K")
f.savefig(plotsdir("centroidmaxlat.png"),transparent=false,dpi=200)
