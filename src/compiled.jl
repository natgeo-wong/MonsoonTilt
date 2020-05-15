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
    ); lat = init["lat"];

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
    @save "$(dpath)/lat.jld2" lat

end

function zmeanpsiv500(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );  lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="cpre",parID="psi_v",pressure=500e2);
    nruns = itime["nruns"]; nlat = length(imod["lat"]); psiv = zeros(nlat,360,nruns);
    lvl = ipar["level"]

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting MERIDIONAL STREAMFUNCTION data at 500 hPa for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);
        psiv[:,:,irun] = ivar[:,lvl,:]
        close(ids)
    end

    @info "$(Dates.now()) - Saving compiled zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-psiv/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-psiv-500hPa.jld2" psiv
    @save "$(dpath)/lat.jld2" lat

end

function era5matrix(;
    modID::AbstractString, parID::AbstractString,
    pre::Integer=0, nyr::Integer=40
)

    prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/ecmwf/"
    init,eroot = erastartup(aID=2,dID=1,path=prjpath);
    emod,epar,ereg,_ = erainitialize(init,modID=modID,parID=parID,regID="ASM");
    if pre != 0; epar["level"] = pre; end
    nlat = ereg["size"][2]; pmat = zeros(nlat,366,nyr)

    for yrii = 1 : nyr, mo = 1 : 12; yr = yrii + 1979;

        eds,evar = erarawread(emod,epar,ereg,eroot,Date(yr,mo));
        vdat = dropdims(mean(evar[:],dims=1),dims=1); close(eds)
        vdat = dropdims(mean(reshape(vdat,nlat,24,:),dims=2),dims=2);
        ndy  = size(prcp,2)
        ibeg = dayofyear(Date(yr,mo,1)); iend = dayofyear(Date(yr,mo,ndy))
        pmat[:,ibeg:iend,yrii] = vdat

    end

    era5mean = mean(@view pmat[:,1:365,:],dims=3)
    dpath = datadir("compiled/era5/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/era5-zmean-$(parID).jld2" psiv
    @save "$(dpath)/lat.jld2" lat

end
