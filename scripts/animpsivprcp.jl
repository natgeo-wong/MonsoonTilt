using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("centmax.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function plot(config::AbstractString)

    @load srcdir("pfull.jld2") pfull;
    prcp,lat = prcpmatrix(config);
    tsfc,lat = tsfcmatrix(config);
    psiv,lat = psivmatrix(config);

    for ii = 1 : 360

        pplt.close(); array = [[1],[1],[2]]
        f,axs = pplt.subplots(
            array,dpi=150,sharey=0,axwidth=4,aspect=1.5,hspace=0.3,
            sharex=2
        )

        cf = axs[1].contourf(
            lat,pfull,psiv[:,:,ii]',
            levels=-500:50:500,extend="both",cmap="RdBu_r"
        )
        axs[1].format(
            xlabel=L"Latitude / $\degree$",xscale="sine",
            ylabel="Pressure / hPa",ylim=(1000,0),
            suptitle="$(uppercase(config))"
        )

        axs[2].plot(lat,prcp[:,ii],c="b",lw=0.5);
        maxprcp = maxlat(prcp[:,ii],lat,10,ϕN=90,ϕS=-90)
        maxtsfc = maxlat(tsfc[:,ii],lat,20,ϕN=90,ϕS=-90)
        axs[2].plot([1,1]*maxprcp,[0,25],c="b",lw=2)
        axs[2].plot([1,1]*maxtsfc,[0,25],c="r",lw=2)
        axs[2].format(
            xlabel=L"Latitude / $\degree$",xscale="sine",
            ylabel=L"$P$ / mm day$^{-1}$",ylim=(0,25)
        )

        ay = axs[2].twinx()
        ay.plot(lat,tsfc[:,ii],c="r",lw=0.5);
        ay.format(ylabel=L"$T_s$ / K",ylim=(270,310),xticklabels=[])

        axs[1].colorbar(cf,loc="r",label=L"$\Psi_{500}$ / kg s$^{-1}$")
        f.savefig(
            plotsdir("anim-$(config)/psivprcp-$(@sprintf("%03d",ii)).png"),
            transparent=false,dpi=200
        )

    end

end

plot("tilt10-slab1")
plot("tilt15-slab1")
plot("tilt25-slab1")
plot("tilt25-slab5")
plot("tilt25-slab20")
