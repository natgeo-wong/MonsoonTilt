using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("itcz.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function prcpmatrix(config::AbstractString)

    ddir = datadir("compiled/zmean-precip/")

    @load "$(ddir)/lat.jld2" lat
    nlat = length(lat); prcp = zeros(nlat,360,20)

    #@load "$(ddir)/spinup-zmean-precip.jld2" zprcp;    prcp[:,:,1:3]  = zprcp
    @load "$(ddir)/$(config)-zmean-precip.jld2" zprcp;

    zprcp[zprcp.<0] .= 0; zprcp[zprcp.>50] .= 50;
    prcp = dropdims(mean(zprcp,dims=3),dims=3);
    return prcp*3600*24,lat

end

function psivmatrix(config::AbstractString)

    ddir = datadir("compiled/zmean-psiv-500hPa/")

    @load "$(ddir)/lat.jld2" lat
    nlat = length(lat); prcp = zeros(nlat,360,20)

    #@load "$(ddir)/spinup-zmean-precip.jld2" zprcp;    prcp[:,:,1:3]  = zprcp
    @load "$(ddir)/$(config)-zmean-psiv-500hPa.jld2" psiv;

    psiv = dropdims(mean(psiv,dims=3),dims=3) / 1e9;
    return psiv,lat

end

function findITCZ(prcp::Array{<:Real,2},lat::Vector{<:Real})
    nlat,nt = size(prcp); pt = zeros(nlat);
    itczmax = zeros(nt); itczmax2 = zeros(nt); itczcent = zeros(nt)
    for it = 1 : nt
        for ilat = 1 : nlat; pt[ilat] = prcp[ilat,it]; end
        itczmax[it]  = ITCZmax(pt,lat)
        itczmax2[it]  = ITCZmax2(pt,lat)
        itczcent[it] = ITCZcent(pt,lat)
    end
    return itczmax,itczmax2,itczcent
end

function plotaxs(config::Vector{<:AbstractString},ppltaxes::Vector{<:PyObject})

    ii = 0;
    for conii in config
        ii = ii + 1
        prcp,lat = prcpmatrix(conii); itczmax,itczmax2,itczcent = findITCZ(prcp,lat)
        psiv,lat = psivmatrix(conii);
        axs[ii].contourf(0.5:359.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
        axs[ii].contour(0.5:359.5,lat,psiv,levels=0:0,colors="k",lw=0.2)
        axs[ii].plot(0.5:359.5,itczmax,c="r")
        axs[ii].plot(0.5:359.5,itczmax2,c="k")
        axs[ii].plot(0.5:359.5,itczcent,c="g")
        axs[ii].format(
            xlabel="Day of Year",xlim=(0,360),
            xlocator=[0,45,90,135,180,225,270,315,360],
            ylabel=L"Latitude / $\degree$",ylim=(-40,40),
            ylocator=[-40,-30,-20,-10,0,10,20,30,40],
            abc=true
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
cf = axs[1].contourf([0,1],[0,1],ones(2,2)*NaN,levels=0:2.5:25,cmap="Blues")

f.colorbar(cf,loc="r")
f.savefig(plotsdir("test.png"),transparent=false)
