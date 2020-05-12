using JLD2

function streamfunctioninit(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );

    iscastreamfunction(init,iroot);

end

function precipanalysis(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );

    iscaanalysis(init,iroot,modID="msfc",parID="precipitation",plvls="sfc");

end

function zmeanprecip(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean PRECIPITAION (ALL) data for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );

    imod,ipar,itime = iscainitialize(init,modID="msfc",parID="precipitation");
    nruns = itime["nruns"]; nlat = length(imod["lat"]); zprcp = zeros(nlat,360,nruns);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting PRECIPITAION (ALL) data for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);

        @info "$(Dates.now()) - Performing zonal-averaging for RUN $irun of CONFIG $(uppercase(config)) ..."
        zprcp[:,:,irun] = dropdims(mean(ivar[:],dims=1),dims=1);
        close(ids)
    end

    @info "$(Dates.now()) - Saving compiled zonal-mean PRECIPITAION (ALL) data for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-precip/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-precip.jld2" zprcp
    @save "$(dpath)/lat.jld2" init["lat"]

end

function zmeanpsiv500(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );

    imod,ipar,itime = iscainitialize(init,modID="msfc",parID="psi_v",pressure=500e2);
    nruns = itime["nruns"]; nlat = length(imod["lat"]); zprcp = zeros(nlat,360,nruns);
    lvl = ipar["level"]

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting MERIDIONAL STREAMFUNCTION data at 500 hPa for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);
        psiv[:,:,irun] = ivar[:,lvl,:]
        close(ids)
    end

    @info "$(Dates.now()) - Saving compiled zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-psiv/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-psiv-500hPa.jld2" zprcp
    @save "$(dpath)/lat.jld2" init["lat"]

end
