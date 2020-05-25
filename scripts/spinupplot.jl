using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

pplt = pyimport("proplot");

function spinprcp(config::AbstractString)

    ddir = datadir("compiled/zmean-precip/")

    @load "$(ddir)/lat.jld2" lat
    nlat = length(lat); prcp = zeros(nlat,360,23)

    @load "$(ddir)/spinup-zmean-precip.jld2" zprcp;    prcp[:,:,1:3]  = zprcp
    @load "$(ddir)/$(config)-zmean-precip.jld2" zprcp; prcp[:,:,4:23] = zprcp

    zprcp[zprcp.<0] .= 0; zprcp[zprcp.>50] .= 50;
    return prcp[:,:,20:23]*3600*24,lat

end

function spinpsiv(config::AbstractString)

    ddir = datadir("compiled/zmean-psiv/")

    @load "$(ddir)/lat.jld2" lat
    nlat = length(lat); apsi = zeros(nlat,360,23)

    @load "$(ddir)/spinup-zmean-psiv-500hPa.jld2" psiv;    apsi[:,:,1:3]  = psiv
    @load "$(ddir)/$(config)-zmean-psiv-500hPa.jld2" psiv; apsi[:,:,4:23] = psiv

    return apsi[:,:,20:23]./1e9,lat

end

pplt.close(); f,axs = pplt.subplots(nrows=3,axwidth=4,aspect=3,dpi=200)

prcp,lat = spinprcp("tilt5-slab1"); prcp = reshape(prcp,length(lat),:)
psiv,lat = spinpsiv("tilt5-slab1"); psiv = reshape(psiv,length(lat),:)
cf = axs[1].contourf((-359:1080) .-0.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
axs[1].contour((-359:1080) .-0.5,lat,psiv,levels=0:0,colors="k",lw=0.5)

prcp,lat = spinprcp("tilt15-slab1"); prcp = reshape(prcp,length(lat),:)
psiv,lat = spinpsiv("tilt15-slab1"); psiv = reshape(psiv,length(lat),:)
axs[2].contourf((-359:1080) .-0.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
axs[2].contour((-359:1080) .-0.5,lat,psiv,levels=0:0,colors="k",lw=0.5)

prcp,lat = spinprcp("tilt25-slab1"); prcp = reshape(prcp,length(lat),:)
psiv,lat = spinpsiv("tilt25-slab1"); psiv = reshape(psiv,length(lat),:)
axs[3].contourf((-359:1080) .-0.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
axs[3].contour((-359:1080) .-0.5,lat,psiv,levels=0:0,colors="k",lw=0.5)

for ax in axs
    ax.format(
        xlabel="Day of Year",xlim=(-360,1080),
        xlocator=[-360,0,360,720,1080],
        ylabel=L"Latitude / $\degree$",ylim=(-40,40),
        ylocator=[-40,-30,-20,-10,0,10,20,30,40],
        abc=true
    )
end

f.colorbar(cf,loc="r")
f.savefig(plotsdir("spin.png"),transparent=false)
