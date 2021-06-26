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






