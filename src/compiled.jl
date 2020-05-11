using JLD2

function streamfunctioninit(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(prjpath=prjpath,config=config,fname="atmos_daily");
    iscastreamfunction(init,iroot);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",plvls=350e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",plvls=450e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",plvls=500e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",plvls=550e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",plvls=650e2);

end

function precipanalysis(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(prjpath=prjpath,config=config,fname="atmos_daily");
    iscaanalysis(init,iroot,modID="msfc",parID="precipitation",plvls="sfc");

end

function zmeanprecip(
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(prjpath=prjpath,config=config,fname="atmos_daily");
    imod,ipar,itime = iscainitialize(init,modID="msfc",parID="precipitation");
    nruns = itime["nruns"]; nlat = length(imod["lat"]); zprcp = zeros(nlat,360,nruns);

    for irun = 1 : nruns
        ids,ivar = iscarawread(ipar,iroot,irun=irun);
        zprcp[:,:,irun] = dropdims(mean(ivar[:],dims=1),dims=1);
        close(ids)
    end

    dpath = datadir("compiled/zmean-precip/"); if !isdir; mkpath(dpath); end
    @save "$(datadir("$(config)-zmean-precip")).jld2" zprcp

end

function zmeanpsiv500(
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(prjpath=prjpath,config=config,fname="atmos_daily");
    imod,ipar,itime = iscainitialize(init,modID="msfc",parID="psi_v",pressure=500e2);
    nruns = itime["nruns"]; nlat = length(imod["lat"]); zprcp = zeros(nlat,360,nruns);
    lvl = ipar["level"]

    for irun = 1 : nruns
        ids,ivar = iscarawread(ipar,iroot,irun=irun);
        psiv[:,:,irun] = dropdims(mean(ivar[:,:,lvl,:],dims=1),dims=1);
        close(ids)
    end

    dpath = datadir("compiled/zmean-psiv/"); if !isdir; mkpath(dpath); end
    @save "$(datadir("$(config)-zmean-psiv-500hPa")).jld2" zprcp

end
