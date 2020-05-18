using JLD2

function prcpmatrix(config::AbstractString)

    ddir = datadir("compiled/zmean-precip/")

    @load "$(ddir)/lat.jld2" lat
    nlat = length(lat); prcp = zeros(nlat,360,20)

    #@load "$(ddir)/spinup-zmean-precip.jld2" zprcp;    prcp[:,:,1:3]  = zprcp
    @load "$(ddir)/$(config)-zmean-precip.jld2" prcp;

    prcp[prcp.<0] .= 0; prcp[prcp.>50] .= 50;
    prcp = dropdims(mean(prcp,dims=3),dims=3);
    return prcp*3600*24,lat

end

function tsfcmatrix(config::AbstractString)

    ddir = datadir("compiled/zmean-tsfc/")

    @load "$(ddir)/lat.jld2" lat; nlat = length(lat);
    @load "$(ddir)/$(config)-zmean-tsfc.jld2" tsfc;

    tsfc = dropdims(mean(tsfc,dims=3),dims=3);
    return tsfc,lat

end

function psivmatrix(config::AbstractString)

    ddir = datadir("compiled/zmean-psiv-all/")
    @load "$(ddir)/$(config)-zmean-psiv-all.jld2" psiv;
    @load "$(ddir)/lat.jld2" lat; nlat = length(lat);

    return psiv./1e9,lat

end

function findITCZ(prcp::Array{<:Real,2},lat::Vector{<:Real})
    nlat,nt = size(prcp); pt = zeros(nlat);
    itczmax = zeros(nt); itczmaxA = zeros(nt);
    itczcent = zeros(nt); itczcentF = zeros(nt)
    for it = 1 : nt
        for ilat = 1 : nlat; pt[ilat] = prcp[ilat,it]; end
        itczmax[it]  = maxlat(pt,lat,10,ϕN=90,ϕS=-90)
        itczcent[it] = centlat(pt,lat,ϕN=45,ϕS=-45)
    end
    return itczmax,itczcent
end

function findHEAT(tsfc::Array{<:Real,2},lat::Vector{<:Real})
    nlat,nt = size(tsfc); tt = zeros(nlat);
    heatmax = zeros(nt); heatmaxA = zeros(nt);
    heatcent = zeros(nt); heatcentF = zeros(nt)
    for it = 1 : nt
        for ilat = 1 : nlat; tt[ilat] = tsfc[ilat,it]; end
        heatmax[it]   = maxlat(tt,lat,20,ϕN=90,ϕS=-90)
        heatcent[it]  = centlat(tt,lat,ϕN=90,ϕS=-90)
    end
    return heatmax,heatcent
end

function climatology(config::AbstractString)

    pdir = datadir("compiled/zmean-precip/")
    tdir = datadir("compiled/zmean-tsfc/")
    adir = datadir("compiled/zmean-tair-all/")
    sdir = datadir("compiled/zmean-psiv-all/")

    @load "$(pdir)/lat.jld2" lat
    @load "$(pdir)/$(config)-zmean-precip.jld2"   prcp;
    @load "$(tdir)/$(config)-zmean-tsfc.jld2"     tsfc;
    @load "$(adir)/$(config)-zmean-tair-all.jld2" tair;
    @load "$(sdir)/$(config)-zmean-psiv-all.jld2" psiv;

    prcp = dropdims(mean(prcp,dims=3),dims=3); prcp = dropdims(mean(prcp,dims=2),dims=2);
    tsfc = dropdims(mean(tsfc,dims=3),dims=3); tsfc = dropdims(mean(tsfc,dims=2),dims=2);
    tair = dropdims(mean(tair,dims=3),dims=3); temp = cat(tair,tsfc,dims=2)
    psiv = dropdims(mean(psiv,dims=3),dims=3);

    return prcp*3600*24,temp,psiv./1e9,lat

end
