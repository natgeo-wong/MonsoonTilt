using JLD2
using IscaTools
using ClimateERA

function zmeanprecip(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean PRECIPITATION (ALL) data for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    ); lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="msfc",parID="precipitation");
    nruns = itime["nruns"]; nlat = length(imod["lat"]); zprcp = zeros(nlat,360,nruns);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting PRECIPITATION (ALL) data for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);

        @info "$(Dates.now()) - Performing zonal-averaging for RUN $irun of CONFIG $(uppercase(config)) ..."
        zprcp[:,:,irun] = dropdims(mean(ivar[:]*1,dims=1),dims=1);
        close(ids)
    end

    @info "$(Dates.now()) - Saving compiled zonal-mean PRECIPITATION (ALL) data for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-precip/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-precip.jld2" zprcp
    @save "$(dpath)/lat.jld2" lat

end

function zmeantsurf(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean SURFACE TEMPERATURE data for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    ); lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="dsfc",parID="t_surf");
    nruns = itime["nruns"]; nlat = length(imod["lat"]); tsfc = zeros(nlat,360,nruns);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting SURFACE TEMPERATURE data for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);

        @info "$(Dates.now()) - Performing zonal-averaging for RUN $irun of CONFIG $(uppercase(config)) ..."
        tsfc[:,:,irun] = dropdims(mean(ivar[:]*1,dims=1),dims=1);
        close(ids)
    end

    @info "$(Dates.now()) - Saving compiled zonal-mean SURFACE TEMPERATURE data for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-tsfc/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-tsfc.jld2" tsfc
    @save "$(dpath)/lat.jld2" lat

end

function zmeantair(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean AIR TEMPERATURE data for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    ); lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="dpre",parID="temp");
    nruns = itime["nruns"]; nlat = length(imod["lat"]); tair = zeros(nlat,360,nruns);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting AIR TEMPERATURE data for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);
        tair[:,:,:,irun] = ivar[:,:,:]*1
        close(ids)
    end

    tair = dropdims(mean(tair,dims=4),dims=4);

    @info "$(Dates.now()) - Saving compiled zonal-mean AIR TEMPERATURE data for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-tair-all/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-tair-all.jld2" tair
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
        psiv[:,:,irun] = ivar[:,lvl,:]*1
        close(ids)
    end

    @info "$(Dates.now()) - Saving compiled zonal-mean MERIDIONAL STREAMFUNCTION data at 500 hPa for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-psiv-500hPa/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-psiv-500hPa.jld2" psiv
    @save "$(dpath)/lat.jld2" lat

end

function zmeanpsivall(
    prjpath::AbstractString,
    config::AbstractString
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean MERIDIONAL STREAMFUNCTION data at ALL PRESSURE LEVELS for CONFIG $(uppercase(config))..."
    init,iroot = iscastartup(
        prjpath=prjpath,config=config,
        fname="atmos_daily",welcome=false
    );  lat = init["lat"];

    imod,ipar,itime = iscainitialize(init,modID="cpre",parID="psi_v");
    nruns = itime["nruns"]; nlat = length(imod["lat"]); nlvls = length(imod["levels"]);
    psiv = zeros(nlat,nlvls,360,nruns);

    for irun = 1 : nruns
        @info "$(Dates.now()) - Extracting MERIDIONAL STREAMFUNCTION data at ALL PRESSURE LEVELS for RUN $irun of CONFIG $(uppercase(config)) ..."
        ids,ivar = iscarawread(ipar,iroot,irun=irun);
        psiv[:,:,:,irun] = ivar[:,:,:]*1
        close(ids)
    end

    psiv = dropdims(mean(psiv,dims=4),dims=4);

    @info "$(Dates.now()) - Saving compiled zonal-mean MERIDIONAL STREAMFUNCTION data at ALL PRESSURE LEVELS for CONFIG $(uppercase(config))..."
    dpath = datadir("compiled/zmean-psiv-all/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/$(config)-zmean-psiv-all.jld2" psiv
    @save "$(dpath)/lat.jld2" lat

end

function era5matrix(;
    modID::AbstractString, parID::AbstractString,
    pre::Integer=0, nyr::Integer=40
)

    @info "$(Dates.now()) - Beginning compilation of zonal-mean PRECIPITATION (ALL) data for ERA5 reanalysis data ..."

    prjpath = "/n/holyscratch01/kuang_lab/nwong/MonsoonTilt/data/ecmwf/"
    init,eroot = erastartup(aID=2,dID=1,path=prjpath);
    emod,epar,ereg,_ = erainitialize(init,modID=modID,parID=parID,regID="ASM");
    if pre != 0; epar["level"] = pre; end
    nlat = ereg["size"][2]; lat = ereg["lat"]; pmat = zeros(nlat,366,nyr)

    for yrii = 1 : nyr, mo = 1 : 12; yr = yrii + 1979;

        @info "$(Dates.now()) - Processing PRECIPITATION (ALL) data for $(yr)/$(mo)"
        eds,evar = erarawread(emod,epar,ereg,eroot,Date(yr,mo));
        vdat = dropdims(mean(evar[:]*1,dims=1),dims=1); close(eds)
        vdat = dropdims(mean(reshape(vdat,nlat,24,:),dims=2),dims=2);
        ndy  = size(vdat,2)
        ibeg = dayofyear(Date(yr,mo,1)); iend = dayofyear(Date(yr,mo,ndy))
        pmat[:,ibeg:iend,yrii] = vdat

    end

    @info "$(Dates.now()) - Saving compiled zonal-mean PRECIPITATION (ALL) data for ERA5 reanalysis data ..."
    eview = @view pmat[:,1:365,:]; era5mean = mean(eview,dims=3)
    dpath = datadir("compiled/era5/"); if !isdir(dpath); mkpath(dpath); end
    @save "$(dpath)/era5-zmean-$(parID).jld2" era5mean
    @save "$(dpath)/lat.jld2" lat

end
