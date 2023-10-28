using Roots, Distributions

"""
Radio efectivo de la galaxia.
"""
const R_disc = 3.0 #kpc

"""
Radio del bulge de la galaxia.
"""
const R_bulge = 5 #kpc

"""
Distancia del centro de la galaxia a la tierra.
"""
const R_tierra = 8 #kpc

"""
    PDF(R)
La función de distribución de probabilidad (PDF) calcula la densidad
de puntos a una distancia R del centro de la galaxia.

R (kpc) >= 0.
"""
PDF(R) = exp(-R/R_disc)/(2*π*R_disc^2)

"""
    CDF(R)
La función de distribución acumulativa (CDF) calcula la fracción
de puntos que están a una distancia menor a R del centro de la
galaxia.

R (kpc) >= 0.
"""
CDF(R) = 1 - exp(-R/R_disc) * (1 + R/R_disc)

"""
    CDF_inv(x)
Es la inversa de CDF.
"""
CDF_inv(x) = find_zero(p -> CDF(p)-x, 1.0)


"""
    R_aleatorio()
    R_aleatorio(R_min, R_max)
Elige una distancia aleatoria al centro de la galaxia con una distribución
de probabilidad consistente con la distribución de masa de la galaxia.

Si R_max y R_min están presentes, sólamente se devuelven valores en ese rango.
"""
R_aleatorio() = CDF_inv(rand())
function R_aleatorio(R_min, R_max)
    CDF_min = CDF(R_min)
    CDF_max = CDF(R_max)
    U = rand(Uniform(CDF_min, CDF_max))
    CDF_inv(U)
end

"""
    punto_galactico_aleatorio()
    punto_galactico_aleatorio(n)
Elige n puntos aleatorios en el espacio, con una distribución de probabilidad
consistente con la distribución de masa de la galaxia.
La versión sin n devuelve un sólo punto.
"""
function punto_galactico_aleatorio()
    θ = rand(Uniform(0, 2*π))
    R = R_aleatorio()

    z_max = R_bulge * exp(-R/R_disc)
    z = rand(Uniform(-z_max, z_max))
    
    [R * cos(θ), R * sin(θ), z]
end

punto_galactico_aleatorio(n) = [punto_galactico_aleatorio() for i in 1:n]

"""
    punto_galactico_aleatorio_cerca_de_la_tierra(distancia)
Elige un punto aleatorio en el espacio, con una distribución de probabilidad
consistente con la distribución de masa de la galaxia, recortada a una esfera
centrada en la tierra.
distancia es el radio de la esfera (kpc). Tiene que ser menor a R_tierra.
"""
function punto_galactico_aleatorio_cerca_de_la_tierra(distancia)
    P = Float64[0, 0, 0]

    #Rejection samplig:
    while hypot(P[1]-R_tierra, P[2], P[3]) > distancia
        #Tomamos R en un anillo centrado en la tierra
        R = R_aleatorio(R_tierra-distancia, R_tierra+distancia)

        #Tomamos θ en una cuña centrada en la tierra
        θ_max = asin(distancia/R_tierra)
        θ = rand(Uniform(-θ_max, θ_max))

        #Elejimos z:
        z_max = R_bulge * exp(-R/R_disc)
        z = rand(Uniform(-z_max, z_max))

        P = [R * cos(θ), R * sin(θ), z]
    end
    
    return P
end