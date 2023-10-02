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
    R_aleatorio(R_max, R_min = 0.0)
Elige una distancia aleatoria al centro de la galaxia con una distribución
de probabilidad consistente con la distribución de masa de la galaxia.

Si R_max y R_min están presentes, sólamente se devuelven valores en ese rango.
"""
R_aleatorio() = CDF_inv(rand())
function R_aleatorio(R_max, R_min = 0.0)
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