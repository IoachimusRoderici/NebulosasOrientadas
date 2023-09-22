"""
Representa un punto y una orientación.
"""
struct CuerpoOrientado
    X::Vector{Float64}   #Posición con respecto al centro de la galaxia
    dir::Vector{Float64} #Vector dirección
end