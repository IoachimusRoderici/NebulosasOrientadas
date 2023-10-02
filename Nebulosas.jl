module Nebulosas

export CuerpoOrientado
export nebulosa_aleatoria_alineada
export nebulosa_aleatoria_homogenea

include("../MyLib/Julia/MyRandomVectors.jl") #ver https://github.com/IoachimusRoderici/MyLib/tree/main/Julia
using .MyRandomVectors

include("DistribucionGalactica/DistribucionGalactica.jl")

"""
Representa un punto y una orientación.
"""
struct CuerpoOrientado
    X::Vector{Float64}   #Posición con respecto al centro de la galaxia
    dir::Vector{Float64} #Vector dirección
end

"""
Devuelve un CuerpoOrientado con ubicación aleatoria y orientación
de distribución homogenea en todas las direcciones.
"""
function nebulosa_aleatoria_homogenea()
    CuerpoOrientado(punto_galactico_aleatorio(), random_direction(3))
end

"""
Devuelve un CuerpoOrientado con ubicación aleatoria y orientación
hacia el centro de la galaxia con un ángulo de desvío aleatorio
entre 0 y θ.
"""
function nebulosa_aleatoria_alineada(θ)
    X = punto_galactico_aleatorio()
    CuerpoOrientado(X, random_direction_inside_cone(normalize(-X), θ))
end

end #Nebulosas