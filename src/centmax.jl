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

    n = length(centmax); gradvec = zeros(n);
    for ii = 2 : n-1
        gradvec[ii] = (centmax[ii+1]-centmax[ii-1])/2
    end
    gradvec[1] = NaN;#(centmax[2]-centmax[end])/4
    gradvec[n] = NaN;#(centmax[1]-centmax[n-1])/4
    gradvec[Int(n/2 + 1)] = NaN;#gradvec[Int(n/2 + 1)]/2
    gradvec[Int(n/2)] = NaN;#gradvec[Int(n/2)]/2

    pent = mean(reshape(centmax,5,:),dims=1)[:]
    grad = zeros(length(pent)); gradvec = reshape(gradvec,5,:)

    for ii = 1 : length(pent)
        gradii = @view gradvec[:,ii];
        gradib = @view gradii[gradii .!== NaN];
        grad[ii] = mean(gradib)
    end

    pent = vcat(pent,pent[1])
    grad = vcat(grad,grad[1])

    return pent,grad

end

function hadregimes(pent::Real,grad::Real)
    if abs(pent) > 10 && abs(grad) < 0.25
          return 1
    elseif abs(pent) < 5 && abs(grad) < 0.25
          return -1
    else; return 0
    end
end

function hadregimes(pent::Vector{<:Real},grad::Vector{<:Real})
    nx = length(pent); regime = zeros(nx)
    for ix = 1 : nx
        regime[ix] = hadregimes(pent[ix],grad[ix])
    end
    if !any(regime .== 1); regime .= -1; end
    return regime
end
