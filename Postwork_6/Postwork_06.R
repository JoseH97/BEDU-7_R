# Importamos las librerias a utilizar
library(dplyr)
library(lubridate)

# Desarrollo
# Importa el conjunto de datos match.data.csv a R y realiza lo siguiente:

# Descargamos los datos del servidor si no los tenemos
if (file.exists("./data/DataPostwork6/match.data.csv") == FALSE){
    url <- "https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2021/main/Sesion-06/Postwork/match.data.csv"
    download.file(url = url, destfile = "./data/DataPostwork6/match.data.csv", mode = "wb")
}


matchData <- read.csv("data/DataPostwork6/match.data.csv",
                      colClasses = c("Date","character","integer","character","integer"))


# 1.- Agrega una nueva columna sumagoles que contenga la suma de goles por partido.
matchData <- matchData %>% mutate(sumaGoles = home.score + away.score)


# 2.- Obtén el promedio por mes de la suma de goles.
matchData <- matchData %>% group_by(año = year(date) ,mes = month(date)) %>%
                           summarise(promedioSumaGoles = mean(sumaGoles)) %>%
                           filter(año != "2020")

# 3.- Crea la serie de tiempo del promedio por mes de la suma de goles hasta diciembre de 2019.
ts_matchData <- ts(matchData[,3],start = c(2010,8),frequency = 10)


# 4.- Grafica la serie de tiempo
plot(ts_matchData, xlab = "Tiempo", ylab = "Promedio de la suma de goles por mes", main = "Serie tiempo de match.data.cvs",
     sub = "Serie mensual: Agosto de 2010 a Diciembre de 2019")

