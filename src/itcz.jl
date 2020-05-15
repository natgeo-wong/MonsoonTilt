using NumericalIntegration

function ITCZmax(prcp::Vector,lat::Vector)

    phi = lat[(lat.<40).&(lat.>-40)]
    P = prcp[(lat.<40).&(lat.>-40)]

    num = (P .* cosd.(phi)).^10 .* phi
    den = (P .* cosd.(phi)).^10

    return integrate(phi,num) / integrate(phi,den);

end

function ITCZcent(prcp::Vector,lat::Vector)

    phi = lat[(lat.<40).&(lat.>-40)]
    P = prcp[(lat.<40).&(lat.>-40)]

    num = (P .* cosd.(phi)) .* phi
    den = (P .* cosd.(phi))

    return integrate(phi,num) / integrate(phi,den);

end
