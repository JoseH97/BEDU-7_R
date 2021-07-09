# Postwork 07. Alojar un fichero a un local host de MongoDB

# DESARROLLO
# Utilizando el manejador de BDD Mongodb Compass (previamente instalado), deberás de realizar 
# las siguientes acciones:
  
# 1. Alojar el fichero match.data.csv en una base de datos llamada match_games, 
#    nombrando al collection como match

#install.packages("mongolite")
library(mongolite)

df.data <- read.csv("./data/DataPostwork7/match.data.csv")
names(df.data)


myMongoInfo <- mongo(
  collection = "match",
  db = "match_games",
  url = "mongodb://localhost:27017/")
        
if ( myMongoInfo$count() > 0 ) myMongoInfo$drop ()
myMongoInfo$insert(df.data)


# 2. Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base
myMongoInfo$count()

# 3. Realiza una consulta utilizando la sintaxis de Mongodb en la base de datos, para conocer el 
#    número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, 
#    ¿perdió ó fue goleada?

solicitud <- myMongoInfo $ find ( '{ "date": "2015-12-20" ,   "$or": [ {"home_team":"Real Madrid"} , {"away_team_team":"Real Madrid"} ]}' )

paste("El", solicitud$date,"jugo",
      solicitud$home_team, "vs", 
      solicitud$away_team, "quedando: ",
      solicitud$home_score,"-",solicitud$away_score)


# 4. Por último, no olvides cerrar la conexión con la BDD
rm ( myMongoInfo )
