# Acotando Ese Ángulo

En este documento se describe el método usado para acotar la orientación de una nebulosa dada,
usando solamente los datos disponibles en el catálogo.

## Convenciones y Nomenclatura

Elejimos un sistema de coordenadas cartesianas con la tierra en el origen de coordenadas, con el eje
$x$ apuntando de la tierra al centro de la galaxia, y con el eje $z$ perpendicular al plano de la
galaxia.

Todos los vectores que se usen estarán descritos en este sistema de coordenadas.

Llamamos $\mathbf{C} = (8, 0, 0)\ kpc$ a la ubicación del centro de la galaxia.

Llamamos $\mathbf{N}$ a la ubicación de una nebulosa dada.

Llamamos $\hat{u}$ al vector unitario que apunta en la dirección (real, no proyectada) en la que está 
orientada la nebulosa. Existen dos elecciones posibles para $\hat{u}$ (opuestas entre sí); tomamos la
que está del lado del centro de la galaxia.

![figura 1](fig1.png)

## Qué Queremos saber?

Queremos calcular el ángulo, en adelante $\alpha$, formado entre el eje de la nebulosa y la línea que une
la nebulosa con el centro de la galaxia.

Las observaciones no proveen información suficiente para calcular este ángulo como un valor puntual, pero
esperamos que un análisis suficientemente cuidadoso permita al menos establecer cotas superiores e
inferiores.

## Qué sabemos?

Para cada nebulosa, el catálogo contiene dos datos:
- La dirección desde la tierra hacia la nebulosa, en adelante representada por el vector unitario $\hat{N}$.
- La orientación de la nebulosa, como se ve proyectada sobre la esfera celeste; en adelante representada por el vector unitario $\hat{u}'$.

Estos dos datos permiten definir un plano, llamemoslo $\Pi$, que contiene a la tierra, a la nebulosa, y a $\hat{u}$.

![figura 2](fig2.png)

Todo lo que sabemos de $\hat{u}$ es que está contenido en este plano. Parece razonable agregar la restricción
de que $\hat{u}$ no esté demasiado cerca de ser paralelo a $\hat{N}$, porque si lo fuera entonces $\hat{u}'$
no sería observable. Sería bueno que Juana et al. tuvieran a bien aclarar este punto y determinar algún ángulo
mínimo entre $\hat{u}$ y $\hat{N}$; provisoriamente el valor de 1º parece ser conservador.

## Qué No Sabemos?

El catálogo carece de dos datos con los cuales el problema quedaría totalmente resuelto:
- La distancia entre la tierra y la nebulosa, en adelante $|\mathbf{N}|$.
- El ángulo entre $\hat{u}$ y $\hat{u}'$, en adelante $\theta$.

$|\mathbf{N}|$ puede ser acotada, *grosso modo*, entre $1\ kpc$ y $3\ kcp$. Esto nos permite decir que
la ubicación de la nebulosa está sobre el segmento de recta descrito por $\mathbf{N} = |\mathbf{N}|\ \hat{N}$.

El hecho de que $\hat{u}'$ es perpendicular a $\hat{N}$, sumado a la observación de más arriba sobre el ángulo
entre $\hat{u}$ y $\hat{N}$, nos permite acotar $\theta$ al intervalo de $\pm 89º$.

![figura 3](fig3.png)






