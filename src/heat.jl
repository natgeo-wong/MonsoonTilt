using NumericalIntegration

function HEATmax(tsfc::Vector,lat::Vector)

    tsfc = (tsfc .- minimum(tsfc)) ./ 20;

    num = tsfc.^10 .* lat
    den = tsfc.^10

    return integrate(lat,num) / integrate(lat,den);

end

function HEATcent(tsfc::Vector,lat::Vector)

    tsfc = tsfc .- minimum(tsfc);

    num = (tsfc .* cosd.(lat)) .* lat
    den = (tsfc .* cosd.(lat))

    return integrate(lat,num) / integrate(lat,den);

end
