module DistribucionesGalacticas

"""
Devuelve un punto aleatorio con distribución de probabiblidad
consistente con la distribución de la galaxia.
"""
function punto_galactico_aleatorio()
    # Parámetros de la distribución:
    R_disc = 3      #Radio efectivo de la galaxia
    M_gal = 6e10    #Masa de la galaxia

    Σ_0 = M_gal / (2 * π * R_disc^2) #Densidad en el centro de la galaxia

    # Calcular un radio aleatorio:
    rmin = 0
    rmax = 50

    Σ_min = Σ_0 * exp(-rmax/rd) #Σ_0 está de más porque después lo divide
    Σ_max = Σ_0 * exp(-rmin/rd)

    ε = rand(Uniform(Σ_min, Σ_max))/Σ_0

    r = -ln(ε) * R_disc 

end

end #DistribucionesGalacticas