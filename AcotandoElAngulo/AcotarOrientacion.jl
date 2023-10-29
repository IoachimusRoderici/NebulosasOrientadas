using LinearAlgebra, BlackBoxOptim

"""
Describe la información observada de una nebulosa.
"""
struct NebulosaObservada
    N̂::Vector{Float64}    #Vector unitario que apunta de la tierra a la nebulosa
    û_pr::Vector{Float64} #Orientación de la nebulosa, proyectada sobre la esfera celeste.
end

"""
Rango de distancias de la tierra a las nebulosas.
"""
const N_rango = (1.0, 3.0) #kpc

"""
Rango de ángulos entre ̂u y û_pr.
"""
const θ_rango = (deg2rad(-89), deg2rad(89))

"""
Rango donde buscar extremos de α.
"""
const box = [θ_rango, N_rango]

"""
El centro de la galaxia.
"""
const C = [8, 0, 0] #kpc

"""
La ecuación para α deducida en el readme.
"""
function α_real(nebulosa, θ, N)
    A = nebulosa.û_pr · C
    B = nebulosa.N̂ · C - N
    R = hypot(A, B)
    ϕ = acos(B/R)
    cosα = cos(ϕ - θ) * R/norm(C - N*nebulosa.N̂)

    acos(cosα)
end

"""
    acotar_α(nebulosa)

Calcula (α_min, α_max) para la nebulosa dada.
"""
function acotar_α(nebulosa)
    α(θN)  = α_real(nebulosa, θN[1], θN[2])
    resultado_min = bboptimize(α,  SearchRange=box, TraceMode=:silent)
    α_min = best_fitness(resultado_min)

    α2(θN) = -α(θN)
    resultado_max = bboptimize(α2, SearchRange=box, TraceMode=:silent)
    α_max = -best_fitness(resultado_max)

    return (α_min, α_max)
end