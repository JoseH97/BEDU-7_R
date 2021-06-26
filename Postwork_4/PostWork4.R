###################### PostWork Sesion 4
# Leemos el dataset del postwork3
PrimDiv <- read.csv("./Data/DataPostwork3/Ligas.csv")

# 1.- Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote
# X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido.
# Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto
# de las probabilidades marginales correspondientes.

# Obtenemos los goles anotados tanto de visitantes como de locales
golesAnotados <- PrimDiv[ ,c("FTHG","FTAG")]

# Creamos la tabla de frecuencias
t.goles <- table("Local"= golesAnotados$FTHG,"Visitante"=golesAnotados$FTAG)

# Creamos la distribucion de probabilidad marginal de locales
(local <- rowSums(t.goles))
(local.prob <- round(local/sum(local),3))


# Creamos la distribucion de probabilidad marginal de visitantes
(visitante <- colSums(t.goles))
(visitante.prob <- round(visitante/sum(visitante),3))

# Creamos la distribucion de probabilidad conjunta
(conjunta.prob <- round(t.goles/sum(t.goles),3))

# Calculamos la matriz de multiplicacion de probabilidades marginales respectivas
# Utilizamos el outer product para generar la matriz
marginalProd <- local.prob %o% visitante.prob

# Calculamos los coeficientes : p(x_i,y_j)/(p(x_i)*p(y_j))
(coefTable <- conjunta.prob/marginalProd)


# 2.- Mediante un procedimiento de boostrap, obtén más cocientes similares a los
# obtenidos en la tabla del punto anterior. Esto para tener una idea de
# las distribuciones de la cual vienen los cocientes en la tabla anterior.
# Menciona en cuáles casos le parece razonable suponer que los cocientes de
# la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia
# de las variables aleatorias X y Y).

# La técnica de boostrap es una técnica de remuestreo y sirve para
# estimar estadisticos de una población (como la media,varianza,correlacion, etc...)

# Esta ténica la vamos a utilizar para hacer un remuestreo de los goles de local
# y los goles vistante, para despues cálcular los coeficientes p(x_i,y_j)/(p(x_i)*p(y_j))
# en cada muestra.

# Defino los parámetros del boostrap
k <- 10 # numero de submuestreos
n <- dim(golesAnotados)[1] # cantidad de datos que se van a remuestrear en una muestra


# Paso 1: calcular los coefiecientes para cada muestra

t.golesBoostrap <- replicate(k, {
    # muestreamos los goles de local y visitante
    golesAnotados.perSample <- data.frame("FTHG" = sample(golesAnotados$FTHG,n,replace = FALSE),
                                          "FTAG" = sample(golesAnotados$FTAG,n,replace = FALSE))

    # obtenemos las frecuencias relativas
    t.golesPerSample <- table("Local" = golesAnotados.perSample$FTHG,
                              "Visitante" = golesAnotados.perSample$FTAG)

    # Obtenemos la distribucion de probabilidad marginal de locales
    local.PerSample <- rowSums(t.golesPerSample)
    local.probPerSample <- round(local.PerSample/sum(local.PerSample),3)


    # Creamos la distribucion de probabilidad marginal de visitantes
    visitante.PerSample <- colSums(t.golesPerSample)
    visitante.probPerSample <- round(visitante.PerSample/sum(visitante.PerSample),3)

    # Creamos la distribucion de probabilidad conjunta
    conjunta.probPerSample <- round(t.golesPerSample/sum(t.golesPerSample),3)


    # Calculamos la matriz de multiplicacion de probabilidades marginales respectivas
    # Utilizamos el outer product para generar la matriz
    marginalProd.PerSample <- local.probPerSample %o% visitante.probPerSample


    # Calculamos los coeficientes : p(x_i,y_j)/(p(x_i)*p(y_j))
    coefTable.PerSample <- conjunta.probPerSample/marginalProd.PerSample


    coefTable.PerSample

})


# Paso 2: Calcular la media y sd de cada coeficiente sobre cada matriz de coeficientes
coefTable.BoostrapMean <- apply(t.golesBoostrap,c(1,2) ,mean) # Estimamos p(x_i,y_j)/(p(x_i)*p(y_j))
coefTable.BoostrapSd <- apply(t.golesBoostrap,c(1,2) ,sd) # error de la estimacion

# Mostramos los resultados
print(coefTable.BoostrapMean)
print(coefTable.BoostrapSd)


# Con base en los resultados mostrados en coefTable.BoostrapMean (boostrapCoef.jpg)
# Variables independientes :
# (Local=0,Visitante=0), (Local=1,Visitante=0), (Local=2,Visitante=0) ,(Local=3,Visitante=0)
# (Local=0,Visitante=1), (Local=1,Visitante=1), (Local=2,Visitante=1)

# Variables dependientes : son las variables que sobran

# El criterio para ver la dependencia es que la estimacion de Estimamos p(x_i,y_j)/(p(x_i)*p(y_j))
# se cercano a 1 +- 0.09, si la desviacion estandar es mayor que 0.1 no se toma









