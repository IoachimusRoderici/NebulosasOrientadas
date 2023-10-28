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
const N_rango = (1, 3) #kpc

"""
Rango de ángulos entre ̂u û_pr.
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

