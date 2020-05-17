using NumericalIntegration

function maxlat(X::Vector,lat::Vector,N::Integer;ϕN::Real,ϕS::Real)

    X = X .- minimum(X)
    ϕ = lat[(lat.<ϕN).&(lat.>ϕS)]
    X = X[(lat.<ϕN).&(lat.>ϕS)]

    num = X.^N .* cosd.(ϕ) .* ϕ
    den = X.^N .* cosd.(ϕ)

    return integrate(ϕ,num) / integrate(ϕ,den);

end

function maxAlat(X::Vector,lat::Vector)

    ϕ = lat[(lat.<20).&(lat.>-20)]
    X = X[(lat.<20).&(lat.>-20)]

    num = (X .* cosd.(ϕ)).^10 .* ϕ
    den = (X .* cosd.(ϕ)).^10

    return integrate(ϕ,num) / integrate(ϕ,den);

end

function centlat(X::Vector,lat::Vector;ϕN::Real,ϕS::Real)

    X = X .- minimum(X)
    ϕ = lat[(lat.<ϕN).&(lat.>ϕS)]
    X = X[(lat.<ϕN).&(lat.>ϕS)]

    num = X .* cosd.(ϕ) .* ϕ
    den = X .* cosd.(ϕ)

    return integrate(ϕ,num) / integrate(ϕ,den);

end

function centFlat(X::Vector,lat::Vector)

    ϕ = lat[(lat.<20).&(lat.>-20)]
    X = X[(lat.<20).&(lat.>-20)]

    num = X .* cosd.(ϕ) .* ϕ
    den = X .* cosd.(ϕ)

    return integrate(ϕ,num) / integrate(ϕ,den);

end

function migration(centmax::Vector)

    vec1 = circshift(centmax,1)
    vec2 = circshift(centmax,-1)
    n = length(centmax); gradvec = zeros(n);
    return (vec2 .- vec1)/2

end
