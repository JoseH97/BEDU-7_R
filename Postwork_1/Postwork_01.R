# 1.1 Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española
# df.liga <- read.csv("./data/SP1.csv")

# 1.2. Extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG)
#    y los goles anotados por los equipos que jugaron como visitante (FTAG)
# (golesAnotados <- df.liga[ ,c("FTHG","FTAG")]) opcional, es mas rapido hacer el procesamiento en read.csv


# Descargamos los datos del servidor si no los tenemos
if (file.exists("./data/DataPostwork1/SP1.csv") == FALSE){
    url <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
    download.file(url = url, destfile = "./data/SP1.csv", mode = "wb")
}

golesAnotados <- read.csv("./data/DataPostwork1/SP1.csv",
                 colClasses = c(rep("NULL",5),rep("integer",2),rep("NULL",98)))



# 1.3. Consulta cómo funciona la función table en R al ejecutar en la consola ?table
t.goles <- table("Local"= golesAnotados$FTHG,"Visitante"=golesAnotados$FTAG)

# 1.3.1 La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x = 0, 1, 2, ...)

(local <- rowSums(t.goles))
(local.prob <- round(local/sum(local),3))


# 1.3.2 La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y = 0, 1, 2, ...)

(visitante <- colSums(t.goles))
(visitante.prob <- round(visitante/sum(visitante),3))

# 1.3.3 La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y
# el equipo que juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...)

(conjunta.prob <- round(t.goles/sum(t.goles),3))

