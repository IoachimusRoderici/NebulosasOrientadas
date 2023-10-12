include("AcotarOrientacion.jl")

#Datos reales:
miN = [-1,1,1.0]
miû = normalize([0.7,0.7,0.3])

α = rad2deg(acos(miû·(C - miN)/norm(C - miN)))
println("Ángulo real: $α º")

#Datos observados:
N̂ = normalize(miN)
û_pr = normalize(miû - (miû·N̂)*N̂)
nebulosa = NebulosaObservada(N̂, û_pr)

#Datos reconstruídos:
miα(θN)  = α_real(nebulosa, θN[1], θN[2])
miα2(θN) = -miα(θN)

resultado_min = bboptimize(miα,  SearchRange=box, TraceMode=:silent)
resultado_max = bboptimize(miα2, SearchRange=box, TraceMode=:silent)

θ_min, N_min = best_candidate(resultado_min)
θ_min = rad2deg(θ_min)
α_min = rad2deg(best_fitness(resultado_min))
θ_max, N_max = best_candidate(resultado_max)
θ_max = rad2deg(θ_max)
α_max = rad2deg(-best_fitness(resultado_max))

println("Rango reconstruído: [$α_min º, $α_max º]")
println("El ángulo mínimo se da con θ=$θ_min º y N=$N_min kpc.")
println("El ángulo máximo se da con θ=$θ_max º y N=$N_max kpc.")