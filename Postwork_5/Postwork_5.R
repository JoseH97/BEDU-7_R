#Se fija el directorio
setwd("*/BEDU-7_R/Data/DataPostwork5")
#Se inicia la libreria
library(dplyr)
#Se inician las URL de los archivos
data.ur1 <- "https://www.football-data.co.uk/mmz4281/1718/SP1.csv"
data.ur2 <- "https://www.football-data.co.uk/mmz4281/1819/SP1.csv"
data.ur3 <- "https://www.football-data.co.uk/mmz4281/1920/SP1.csv"
#Descarga de archivod
download.file(url = data.ur1, destfile = "SP1-17.csv", mode = "wb")
download.file(url = data.ur2, destfile = "SP1-18.csv", mode = "wb")
download.file(url = data.ur3, destfile = "SP1-19.csv", mode = "wb")
#Verificamos la descarga de los archivos
dir()
#leemos los archivos
dt1 <- read.csv("SP1-17.csv")
dt1 <- select(dt1,Date,HomeTeam,FTHG,AwayTeam,FTAG)

dt2 <- read.csv("SP1-18.csv")
dt2 <- select(dt2,Date,HomeTeam,FTHG,AwayTeam,FTAG)

dt3 <- read.csv("SP1-19.csv")
dt3 <- select(dt3,Date,HomeTeam,FTHG,AwayTeam,FTAG)
#Union de archivos 
SmallData <- rbind(dt1,dt2,dt3)
#Cambio de nombre para poder ser empleados por fbRanks
SmallData <- rename(SmallData, date = Date, 
                    home.team = HomeTeam,
                    home.score = FTHG,
                    away.team = AwayTeam,
                    away.score = FTAG)
#Cambio de formato de fecha
SmallData <- mutate(SmallData, date = as.Date(date, "%d/%m/%Y"))
#escritura de csv
write.csv(SmallData, file="soccer.csv", row.names = FALSE)
#inicio de fbRanks
library(fbRanks)
listasoccer <- create.fbRanks.dataframes("soccer.csv")
#equipos y anotaciones
equipos <- listasoccer$teams
anotaciones <-listasoccer$scores
#FILTRO DE FECHAS
fecha <- sort(as.Date((unique(SmallData$date)), "%d/%m/%Y"))
n <- length(fecha)
#USO DE FBRANKING
ranking <- (rank.teams(scores = anotaciones, teams = equipos, max.date=fecha[n-1], min.date=fecha[1]))
#PREDICT
predict(ranking,date = fecha[n])

