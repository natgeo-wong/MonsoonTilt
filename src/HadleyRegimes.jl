using DrWatson
@quickactivate "MonsoonTilt"

using PyCall
using LaTeXStrings

include(srcdir("centmax.jl"));
include(srcdir("common.jl"));
pplt = pyimport("proplot");

function findregimes(config::AbstractString)

    prcp,lat = prcpmatrix(config); itczmax,_ = findITCZ(prcp,lat)
    maxpent,maxgrad = migration(itczmax);
    regimes = hadregimes(maxpent,maxgrad)

    return regimes

end

function findregimes(tilt::Vector{<:Real},slab::Vector{<:Real})

    nt = length(tilt); ns = length(slab);
    sl = zeros(nt,ns); eq = zeros(nt,ns);

    for is = 1 : ns, it = 1 : nt

        prcp,lat = prcpmatrix("tilt$(tilt[it])-slab$(slab[is])");
        itczmax,_ = findITCZ(prcp,lat); maxpent,maxgrad = migration(itczmax);
        regimes = hadregimes(maxpent,maxgrad)
        sl[it,is] = abs(sum(regimes[regimes.==1])) / length(regimes)
        eq[it,is] = abs(sum(regimes[regimes.==-1])) / length(regimes)

    end

    return sl,eq

end

tilt = [5,10,15,20,25];
slab = [1,2,5,10,20];
sl,eq = findregimes(tilt,slab)

pplt.close(); f,axs = pplt.subplots(ncols=3,axwidth=2,)

axs[1].contourf(tilt,slab,sl',levels=0:0.05:1)
axs[2].contourf(tilt,slab,eq',levels=0:0.05:1)
axs[3].contourf(tilt,slab,1 .-(sl.+eq)',levels=0:0.05:1)

axs[1].format(xlabel=L"Tilt / $\degree$",ylabel="Slab Depth / m",title="Solstitial Regime")
axs[2].format(title="Equinoctal Regime")
axs[3].format(title="Transition State")

cf = axs[1].contourf([5,6],[1,2],ones(2,2)*NaN,levels=0:5:100)
f.colorbar(cf,loc="r",label="Frequency / %")
f.savefig(plotsdir("regimes.png"),transparent=false,dpi=200)
