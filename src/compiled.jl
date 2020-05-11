using JLD2

function streamfunctioninit(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(prjpath=prjpath,config=config,fname="atmos_daily");
    iscastreamfunction(init,iroot);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",pressure=350e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",pressure=450e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",pressure=500e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",pressure=550e2);
    iscaanalysis(init,iroot,modID="cpre",parID="psi_v",pressure=650e2);

end

function precipanalysis(;
    prjpath::AbstractString,
    config::AbstractString
)

    init,iroot = iscastartup(prjpath=prjpath,config=config,fname="atmos_daily");
    iscaanalysis(init,iroot,modID="msfc",parID="precipitation");

end

