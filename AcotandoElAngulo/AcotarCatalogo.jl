module AcotarCatalogo

export agregar_cotas_α

include("AcotarOrientacion.jl")
using .AcotarOrientacion

using Rotations, LinearAlgebra
using CSV, DataFrames

"""
    NebulosaObservada(latitud, longitud, GPA)

Crea un objeto NebulosaObservada a partir de los datos del catálogo.

Los tres parámetros son ángulos en radianes.
- latitud ∈ [-π/2, π/2]
- longitud ∈ [0, π]
- GPA ∈ [0, π]
"""
function NebulosaObservada(latitud, longitud, GPA)
    #Convertir latitud y longitud a coordenadas cartesianas:
    x = cos(latitud) * cos(longitud)
    y = cos(latitud) * sin(longitud)
    z = sin(latitud)
    N̂ = [x, y, z]

    #Para encontrar û_pr, empezar con el vector que apunta al
    #norte y rotarlo GPA al rededor de N̂, en sentido horario
    #o antihorario según corresponda para acercarse al centro
    #de la galaxia:

    #Si longitud < π, hay que girar antihorario:
    if (longitud < π) GPA *= -1 end

    #Vector perpendicular a N̂ que apunta al norte:
    x_norte = sin(-latitud) * cos(longitud)
    y_norte = sin(-latitud) * sin(longitud)
    z_norte = cos(latitud)
    norte = [x_norte, y_norte, z_norte]

    #Rotar:
    matriz_de_rotacion = AngleAxis(GPA, x, y, z)
    û_pr = Vector(matriz_de_rotacion * norte)

    return AcotarOrientacion.NebulosaObservada(N̂, û_pr)
end

"""
    acotar_α(latitud, longitud, GPA)

Calcula (α_min, α_max) para la nebulosa con los datos dados.

Los tres parámetros son ángulos en radianes.
- latitud ∈ [-π/2, π/2]
- longitud ∈ [0, π]
- GPA ∈ [0, π]
"""
function acotar_α(latitud, longitud, GPA) 
    α_min, α_max = AcotarOrientacion.acotar_α(NebulosaObservada(latitud, longitud, GPA))
    return (α_min=α_min, α_max=α_max)
end

"""
    agregar_cotas_α(catalogo::DataFrame)
    agregar_cotas_α(catalogo::AbstractString, output_file)

Recibe un catálogo con observaciones de las nebulosas y le agrega tres columnas:

- α_min: mínimo ángulo posible entre la nebulosa y el centro de la galaxia.
- α_max: máximo ángulo posible entre la nebulosa y el centro de la galaxia.
- α_rango: diferencia entre α_min y α_max.

El catálogo tiene que tener las columnas latitud, longitud, y GPA con ángulos
en radianes y sin elementos faltantes.
"""
function agregar_cotas_α(catalogo::DataFrame)
    transform!(catalogo, [:latitud, :longitud, :GPA] => ByRow(acotar_α) => [:α_min, :α_max])
    catalogo.α_rango = catalogo.α_max .- catalogo.α_min
end

function agregar_cotas_α(catalogo::AbstractString, output_file)
    #Cargar catálogo:
    catalogo_dataframe = DataFrame(CSV.File(catalogo))

    #Cambiar nombres de un par de columnas:
    rename!(catalogo_dataframe, Dict(:_Glat=>"latitud", :_Glon=>"longitud"))

    #Eliminar filas con datos faltantes:
    dropmissing!(catalogo_dataframe, :longitud, disallowmissing=true)
    dropmissing!(catalogo_dataframe, :latitud, disallowmissing=true)
    dropmissing!(catalogo_dataframe, :GPA, disallowmissing=true)

    #Agregar las cotas:
    agregar_cotas_α(catalogo_dataframe)

    #Volver a los nombres originales:
    rename!(catalogo_dataframe, Dict(:latitud=>"_Glat", :longitud=>"_Glon"))

    #Guardar:
    CSV.write(output_file, catalogo_dataframe)
end

end #AcotarCatalogo