using Plots, Measures

include("DistribucionGalactica.jl")
using .DistribucionGalactica: R_aleatorio, R_bulge, R_disc

n_samples = 2000
R_min = 0.0 #kpc
R_max = 50.0  #kpc

#Distribución esperada:
x_cdf = LinRange(R_min, R_max, 100)
y_cdf = CDF.(x_cdf)

#Distribución de Peluca:
R_peluca = sort([R_aleatorio(R_min, R_max) for i in 1:n_samples])
z_peluca = [rand(Uniform(-1, 1)) * R_bulge * exp(-R/R_disc) for R in R_peluca]


#Distribución del poster:
function R_aleatorio_poster(R_min, R_max)
    Σ_min = exp(-R_max/R_disc)
    Σ_max = exp(-R_min/R_disc)

    ε = rand(Uniform(Σ_min, Σ_max))
    -log(ε) * R_disc
end

function punto_aleatorio_poster(R_min, R_max)
    φ = rand(Uniform(0, 2*π))    
    R = R_aleatorio_poster(R_min, R_max)
    θ = acos(rand(Uniform(-0.2959589691, 0.2959589691)))
    x = sin(θ)*cos(φ)
    y = sin(θ)*sin(φ)
    z = cos(θ)
    R .* [x, y, z]
end

puntos_poster = [punto_aleatorio_poster(R_min, R_max) for i in 1:n_samples]
R_poster = [hypot(punto[1], punto[2]) for punto in puntos_poster]
z_poster = getindex.(puntos_poster, 3)


#Comparar distribución de densidad del disco:
plot1 = plot(x_cdf, y_cdf, label="Teórica", linewidth=2)
plot!(plot1, R_peluca,       (1:n_samples)./n_samples, label="Peluca", linewidth=2)
plot!(plot1, sort(R_poster), (1:n_samples)./n_samples, label="Poster", linewidth=2)
xlabel!(plot1, "R (kpc)")
ylabel!(plot1, "Probabilidad acumulada")
title!(plot1, "Distribuciones de la variable R")
savefig(plot1, "comparacionR.png")

#Comparar vistas de perfil:
plot2a = scatter(R_peluca, z_peluca, label="Peluca", aspect_ratio=1, margin=3mm, size=(600, 300), ylabel="z (kpc)", title="Cortes transversales de la galaxia")
plot2b = scatter(R_poster, z_poster, label="Poster", aspect_ratio=1, margin=3mm, size=(600, 300), xlabel="R (kcp)", ylabel="z (kpc)",  markercolor=:green)
savefig(plot2a, "perfilPeluca.png")
savefig(plot2b, "perfilPoster.png")