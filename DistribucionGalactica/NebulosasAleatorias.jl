module NebulosasAleatorias

export CuerpoOrientado
export nebulosa_aleatoria_alineada
export nebulosa_aleatoria_homogenea

include("../../MyLib/Julia/MyRandomVectors.jl") #ver https://github.com/IoachimusRoderici/MyLib/tree/main/Julia
using .MyRandomVectors

include("DistribucionGalactica.jl")
using .DistribucionGalactica: punto_galactico_aleatorio_cerca_de_la_tierra 

"""
Representa un punto y una orientación.
"""
struct CuerpoOrientado
    X::Vector{Float64}   #Posición con respecto al centro de la galaxia
    dir::Vector{Float64} #Vector dirección
end

"""
Devuelve una nebulosa aleatoria con orientación distribuída homogéneamente
en todas la direcciones, a no más de 3kpc de la tierra.
"""
function nebulosa_aleatoria_homogenea()
    CuerpoOrientado(punto_galactico_aleatorio_cerca_de_la_tierra(3), random_direction(3))
end

"""
Devuelve una nebulosa aleatoria con orientación distribuída homogéneamente
en un cono de apertura θ, a no más de 3kpc de la tierra.
"""
function nebulosa_aleatoria_alineada(θ)
    X = punto_galactico_aleatorio_cerca_de_la_tierra(3)
    CuerpoOrientado(X, random_direction_inside_cone(normalize(-X), θ))
end

end #NebulosasAleatorias