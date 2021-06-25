#PostWork Sesion 2

# Descargamos los datos del servidor si no los tenemos

if (all(file.exists(c("./data/DataPostwork2/SP1.csv","./data/DataPostwork2/SP2.csv",
                      "./data/DataPostwork2/SP3.csv"))) == FALSE){

    # Si al memos un .cvs no se descargó, volvemos a descargar todos

    url1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
    download.file(url = url1, destfile = "./Data/DataPostwork2/SP1.csv", mode = "wb")

    url2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
    download.file(url = url2, destfile = "./Data/DataPostwork2/SP2.csv", mode = "wb")

    url3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
    download.file(url = url3, destfile = "./Data/DataPostwork2/SP3.csv", mode = "wb")
}


#1. Leemos los datos de soccer de las temporadas 2017/2018, 2018/2019 y 2019/2020 de la primera divisi?n de la liga espa?ola.

# El directorio se situa en ./BEDU-7_R
# Leemos los archivos .csv automaticamente con lapply

Prims <- lapply(paste("./Data/DataPostwork2/",dir("./Data/DataPostwork2"),sep = ""),read.csv)

# Opcional
#Prim18 <- read.csv("./Data/DataPostwork2/SP1.csv")
#Prim19 <- read.csv("./Data/DataPostwork2/SP2.csv")
#Prim20 <- read.csv("./Data/DataPostwork2/SP3.csv")


#2. Revisamos la estructura de de los data frames con las siguientes funciones:

str(Prims[[1]])
str(Prims[[2]]) #Estructura
str(Prims[[3]])

head(Prims[[1]])
head(Prims[[2]]) #Primeros elementos de cada data frame
head(Prims[[3]])

View(Prims[[1]])
View(Prims[[2]]) #Visor de datos
View(Prims[[3]])

summary(Prims[[1]])
summary(Prims[[2]]) #Descripci?n de elementos de cada data frame
summary(Prims[[3]])

#3.Utilizando la funci?n select del paquete dplyr seleccionaremos s?lo algunas columnas de nuestros data frames.

library(dplyr)

Ligas <- lapply(Prims, select, "Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")

# Opcional
#Lig18 <- select(Prim18,"Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")
#Lig19 <- select(Prim19,"Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")
#Lig20 <- select(Prim20,"Date","HomeTeam","AwayTeam","FTHG","FTAG","FTR")

#4 Haremos un ?nico data frame con los datos de las tres temporadas que contengan las columnas seleccionadas anteriormente.
#Necesitaremos que los datos de las columnas sean todos del mismo tipo, as? que haremos un ?nico formato para la fecha.

Ligas <- lapply(Ligas, mutate, Date = as.Date(Date,"%d/%m/%y"))

# Opcional
#Lig18 <- mutate(Lig18, Date = as.Date(Date,"%d/%m/%y"))
#Lig19 <- mutate(Lig19, Date = as.Date(Date,"%d/%m/%y"))
#Lig20 <- mutate(Lig20, Date = as.Date(Date,"%d/%m/%y"))


#El data frame que resulta es el siguiente:

Ligas <- do.call(rbind, Ligas)

# opcional
#PrimDiv <- rbind(Lig18,Lig19,Lig20)


