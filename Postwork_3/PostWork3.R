###################### PostWork Sesion 3
# Leemos el dataset del postwork2
PrimDiv <- read.csv("./Data/DataPostwork3/Ligas.csv")

# 1. Con el último data frame obtenido en el postwork de la sesión 2,
# elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

t.goles <- table("Local"= PrimDiv$FTHG,"Visitante"=PrimDiv$FTAG)

(t.goles)

# La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)

(local <- rowSums(t.goles))
(local.prob <- round(local/sum(local),3))
# pasando a dataframe para poder graficar
locales <- data.frame(local.prob)
goles <- data.frame(0:8)
locales <- cbind("Probabilidades"=locales,"Goles"=goles)
colnames(locales)[1] <- "Probabilidad"
colnames(locales)[2] <- "Goles"

# La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)

(visitante <- colSums(t.goles))
(visitante.prob <- round(visitante/sum(visitante),3))
# pasando a dataframe para poder graficar
visitantes <- data.frame(visitante.prob)
goles.v <- data.frame(0:6)
visitantes <- cbind(visitantes,goles.v)
colnames(visitantes)[1] <- "Probabilidad"
colnames(visitantes)[2] <- "Goles"

# La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y
# el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)

(conjunta.prob <- round(t.goles/sum(t.goles),4))
# pasando a dataframe para poder graficar
local.visit.prop <- data.frame(conjunta.prob)
colnames(local.visit.prop)[3] <- "Probabilidad"

# 2.Graficar lo siguiente;
library(ggplot2)
library(plotly)

# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa.
gl <- ggplot(data=locales, aes(x=Goles, y=Probabilidad)) +
    geom_bar(stat="identity", position="stack", fill = "darkslategrey") +
    ggtitle('     Probabilidades de los números de goles
          \       anotados por equipo local') +
    theme_replace()+
    theme(plot.title = element_text(face = "bold", size=10, colour = "darkslategray")) +
    theme(axis.text.x = element_text(face = "bold", color="lightsteelblue4" , size = 10, hjust = 1),
          axis.text.y = element_text(face = "bold", color="lightsteelblue4" , size = 10, hjust = 1))
ggplotly(gl)


# Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
gv <- ggplot(data=visitantes, aes(x=Goles, y=Probabilidad)) +
    geom_bar(stat="identity", position="stack", fill = "darkslategrey") +
    ggtitle('     Probabilidades de los números de goles
          \       anotados por equipo visitante') +
    theme_replace()+
    theme(plot.title = element_text(face = "bold", size=10, colour = "darkslategray")) +
    theme(axis.text.x = element_text(face = "bold", color="lightsteelblue4" , size = 10, hjust = 1),
          axis.text.y = element_text(face = "bold", color="lightsteelblue4" , size = 10, hjust = 1))
ggplotly(gv)

# Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.
ggp <- ggplot(local.visit.prop, aes(Local, Visitante)) +
    geom_tile(aes(fill = Probabilidad)) +
    ggtitle("                Probabilidades conjuntas") +
    theme(plot.title = element_text(face = "bold", size=10, colour = "darkslategray")) +
    theme(axis.text.x = element_text(face = "bold", color="darkslategray4" , size = 10, hjust = 1),
          axis.text.y = element_text(face = "bold", color="darkslategray4" , size = 10, hjust = 1)) +
    scale_fill_gradient(low = "grey", high = "darkslategray")
ggplotly(ggp)
