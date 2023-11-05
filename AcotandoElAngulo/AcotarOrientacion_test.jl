include("AcotarOrientacion.jl")

#Datos reales:
N = [-1,1,1.0]
û = normalize([0.7,0.7,0.3])

#Datos observados:
N̂ = normalize(N)
û_pr = normalize(û - (û·N̂)*N̂)
nebulosa = NebulosaObservada(N̂, û_pr)

#Ángulos reales:
θ = acos(û·û_pr)
α = acos(û·(C - N)/norm(C - N))

#Datos reconstruídos:
miα(θN)  = α_real(nebulosa, θN[1], θN[2])
miα2(θN) = -miα(θN)

resultado_min = bboptimize(miα,  SearchRange=box, TraceMode=:silent)
θ_min, N_min = best_candidate(resultado_min)
α_min = best_fitness(resultado_min)

resultado_max = bboptimize(miα2, SearchRange=box, TraceMode=:silent)
θ_max, N_max = best_candidate(resultado_max)
α_max = -best_fitness(resultado_max)

#Informar:
println("Datos reales:")
@show N
@show û
println("|N| = $(norm(N))")
println("θ = $(rad2deg(θ))º")
println("Ángulo real: $(rad2deg(α))º")

println("\nValores observados:")
@show N̂
println("û' = $û_pr")

println("\nValores reconstruídos:")
println("Rango para α: [$(rad2deg(α_min))º, $(rad2deg(α_max))º]")
println("El ángulo mínimo se da con θ=$(rad2deg(θ_min))º y N=$N_min kpc.")
println("El ángulo máximo se da con θ=$(rad2deg(θ_max))º y N=$N_max kpc.")