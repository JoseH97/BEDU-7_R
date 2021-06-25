#PostWork Sesion 2

#1. Leemos los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera división de la liga española.

Prim18 <- read.csv("SP1.csv")
Prim19 <- read.csv("SP2.csv")
Prim20 <- read.csv("SP3.csv")

#2. Revisamos la estructura de de los data frames con las siguientes funciones: 

str(Prim18)
str(Prim19) #Estructura
str(Prim20)

head(Prim18)
head(Prim19) #Primeros elementos de cada data frame
head(Prim20)

View(Prim18)
View(Prim19) #Visor de datos
View(Prim20)

summary(Prim18)
summary(Prim19) #Descripción de elementos de cada data frame
summary(Prim20)

#3.Utilizando la función select del paquete dplyr seleccionaremos sólo algunas columnas de nuestros data frames.

library(dplyr)

Lig18 <- select(Prim18,"Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")
Lig19 <- select(Prim19,"Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")
Lig20 <- select(Prim20,"Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")

#4 Haremos un único data frame con los datos de las tres temporadas que contengan las columnas seleccionadas anteriormente. 
#Necesitaremos que los datos de las columnas sean todos del mismo tipo, así que haremos un único formato para la fecha.

Lig18 <- mutate(Lig18, Date = as.Date(Date,"%d/%m/%y"))
Lig19 <- mutate(Lig19, Date = as.Date(Date,"%d/%m/%Y"))
Lig20 <- mutate(Lig20, Date = as.Date(Date,"%d/%m/%Y"))

#El data frame que resulta es el siguiente:

PrimDiv <- rbind(Lig18,Lig19,Lig20)
