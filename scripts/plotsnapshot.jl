using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using JLD2
using LaTeXStrings

include(srcdir("centmax.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function plot(config::AbstractString,dyvec::Vector{<:Integer})

    ncon = length(config); ndy = length(dyvec)

    pplt.close(); array = [collect(1:ndy),collect(1:ndy),collect(1:ndy).+ndy]
    f,axs = pplt.subplots(
        array,dpi=150,sharey=0,axwidth=3,aspect=1.5,hspace=0.3,
        sharex=0
    )

    @load srcdir("pfull.jld2") pfull;
    prcp,lat = prcpmatrix(config);
    tsfc,lat = tsfcmatrix(config);
    psiv,lat = psivmatrix(config);

    ii = 0;
    for dy in dyvec; ii = ii + 1;

        cf = axs[ii].contourf(
            lat,pfull,psiv[:,:,dy]',
            levels=-500:50:500,extend="both",cmap="RdBu_r"
        )
        axs[ii].format(
            xscale="sine",
            ylabel="Pressure / hPa",ylim=(1000,0)
        )

        if ii == 1
            axs[ii].format(
                xscale="sine",
                ylabel="Pressure / hPa",ylim=(1000,0),
                abc=true
            )
        else
            axs[ii].format(
                ylim=(1000,0),xscale="sine",ylabel="",yticklabels=[],abc=true
            )
        end

        if ii == ndy
            axs[ii].colorbar(cf,loc="r",label=L"$\Psi_{500}$ / kg s$^{-1}$")
        end

        axs[ii+ndy].plot(lat,prcp[:,dy],c="b",lw=0.5);
        maxprcp = maxlat(prcp[:,dy],lat,10,ϕN=90,ϕS=-90)
        maxtsfc = maxlat(tsfc[:,dy],lat,20,ϕN=90,ϕS=-90)
        axs[ii+ndy].plot([1,1]*maxprcp,[0,25],c="b",lw=2)
        axs[ii+ndy].plot([1,1]*maxtsfc,[0,25],c="r",lw=2)
        axs[ii+ndy].format(
            xlabel=L"Latitude / $\degree$",xscale="sine",
            ylabel=L"$P$ / mm day$^{-1}$",ylim=(0,25)
        )

        if ii == 1
            axs[ii+ndy].format(
                xlabel=L"Latitude / $\degree$",xscale="sine",
                ylabel=L"$P$ / mm day$^{-1}$",ylim=(0,25)
            )
        else
            axs[ii+ndy].format(
                xlabel=L"Latitude / $\degree$",xscale="sine",
                yticklabels=[],ylim=(0,25),ylabel=""
            )
        end

        ay = axs[ii+ndy].twinx()
        ay.plot(lat,tsfc[:,dy],c="r",lw=0.5);
        if ii + ndy != 2*ndy
            ay.format(ylim=(270,310),xticklabels=[],yticklabels=[])
        else
            ay.format(ylim=(270,310),xticklabels=[],ylabel=L"$T_s$ / K")
        end

    end

    f.savefig(
        plotsdir("snapshots/$config.png"),
        transparent=false,dpi=200
    )

end

plot("tilt20-slab1",[30,120])
