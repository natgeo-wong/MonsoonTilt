using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

pplt = pyimport("proplot");

function era5prcp()

    ddir = datadir("compiled/era5/")

    @load "$(ddir)/lat.jld2" lat; nlat = length(lat);
    @load "$(ddir)/era5-zmean-prcp_tot.jld2" era5mean;

    prcp = dropdims(mean(era5mean,dims=3),dims=3)*1000*24;
    return prcp,lat

end

function era5tair()

    ddir = datadir("compiled/era5/")

    @load "$(ddir)/lat.jld2" lat; nlat = length(lat);
    @load "$(ddir)/era5-zmean-t_air.jld2" era5mean;

    tair = dropdims(mean(era5mean,dims=3),dims=3);
    return tair.-273.15,lat

end

function iscaprcp(config::AbstractString)

    ddir = datadir("compiled/zmean-precip/")

    @load "$(ddir)/lat.jld2" lat;
    @load "$(ddir)/$(config)-zmean-precip.jld2" prcp;
    prcp = dropdims(mean(prcp,dims=3),dims=3);
    prcp = circshift(prcp,(0,-90))
    return prcp*3600*24,lat

end

function iscatsfc(config::AbstractString)

    ddir = datadir("compiled/zmean-tsfc/")

    @load "$(ddir)/lat.jld2" lat; nlat = length(lat)
    @load "$(ddir)/$(config)-zmean-tsfc.jld2" tsfc;

    tsfc = dropdims(mean(tsfc,dims=3),dims=3);
    tsfc = circshift(tsfc,(0,-90))
    return tsfc.-273.15,lat

end

function findITCZ(prcp::Array{<:Real,2})
    nt = size(prcp,2); itczlat = zeros(nt)
    for ii = 1 : nt; pt = @view prcp[:,ii]; itczlat[ii] = lat[argmax(pt)] end
    return itczlat
end

pplt.close();
f,axs = pplt.subplots(
    ncols=2,aspect=1.8,dpi=200,axwidth=3
)

prcp,lat = era5prcp(); itcz = findITCZ(prcp)
tair,lat = era5tair();
cf = axs[1].contourf(0.5:364.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
axs[1].contour(0.5:364.5,lat,tair,levels=20:2:30,colors="k",lw=0.2,labels=true)
#axs[1].plot(0.5:364.5,itcz,c="r")
axs[1].format(
    xlabel="Day of Year",xlim=(0,365),
    xlocator=[0,45,90,135,180,225,270,315,360],
    ylabel=L"Latitude / $\degree$",ylim=(-40,40),
    ylocator=[-40,-30,-20,-10,0,10,20,30,40],
    abc=true,
    suptitle="Daily Precipitation",title="ERA5 Reanalysis"
)

prcp,lat = iscaprcp("tiltE-slab10"); itcz = findITCZ(prcp)
tsfc,lat = iscatsfc("tiltE-slab10");
cf = axs[2].contourf(0.5:359.5,lat,prcp,levels=0:2.5:25,cmap="Blues")
axs[2].contour(0.5:359.5,lat,tsfc,levels=20:2:30,colors="k",lw=0.2,labels=true)
#axs[2].plot(0.5:359.5,itcz,c="r")
axs[2].format(
    xlabel="Day of Year",xlim=(0,360),
    xlocator=[0,45,90,135,180,225,270,315,360],
    ylabel=L"Latitude / $\degree$",ylim=(-40,40),
    ylocator=[-40,-30,-20,-10,0,10,20,30,40],
    abc=true,suptitle="Daily Precipitation",
    title=L"Aquaplanet (23.5$\degree$, 10m)"
)

f.colorbar(cf,loc="r")
f.savefig(plotsdir("era5vsisca.png"),transparent=false)
