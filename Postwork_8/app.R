### Postwork_8

library(shiny)
#install.packages("shinydashboard")
library(shinydashboard)
#install.packages("shinythemes")
library(shinythemes)

#Establecemos el directorio
setwd("*/BEDU-7_R/Data/DataPostwork8")


#Llamamos a nuestros datos
data <- read.csv("match.data.csv")
data <- data.frame(data)

#ui
ui <-   dashboardPage(
            skin = "purple",
            
            dashboardHeader(title = "Football Data"),
            
            dashboardSidebar(
                
                sidebarMenu(
                    menuItem("Graficos de barras", tabName = "barras", icon = icon("bar-chart")),
                    menuItem("Probabilidades de goles", tabName = "imgp", icon = icon("futbol-o")),
                    menuItem("Tabla de datos", tabName = "data_table", icon = icon("table")),
                    menuItem("Factores de ganancia", tabName = "img", icon = icon("line-chart"))
                )
                
            ),
            
            dashboardBody(
                
                tabItems(
                
                    #Grafico de barras
                    tabItem(tabName = "barras", 
                            fluidRow(
                                titlePanel(h3("Gráficos de barras")),
                                selectInput("x", "Selecciona el valor de x",
                                            choices = c("Score Locales" = "home.score", "Score Visitantes" = "away.score")),
                                box(plotOutput("plot2", height = 600, width = 600) )
                                
                            )
                    ),

                    # Postwork3
                    tabItem(tabName = "imgp", 
                            fluidRow(
                                titlePanel(h3("    Probabilidad Marginal Local")),
                                img(src = "probabilidadMarginalLocal.png", height = 350, width = 350),
                                titlePanel(h3("    Probabilidad Marginal Visitante")),
                                img(src = "probabilidadMarginalVisitante.png", height = 350, width = 350),
                                titlePanel(h3("    Probabilidades Conjuntas")),
                                img(src = "probabilidadConjunta.png", height = 350, width = 350)
                            )
                    ),
                    
                     
                    # Data table del fichero match.data.csv
                    tabItem(tabName = "data_table",
                            fluidRow(        
                                titlePanel(h3("Data Table")),
                                dataTableOutput ("data_table")
                            )
                    ), 
                    
                    # Imagenes de las gráficas de los factores de ganancia mínimo y máximo
                    tabItem(tabName = "img",
                            fluidRow(
                                titlePanel(h3("Factores de ganancia mínima")),
                                img( src = "momios1.png", height = 350, width = 350),
                                titlePanel(h3("Factores de ganancia máxima")),
                                img( src = "momios2.png", height = 350, width = 350)
                                    )
                            )
                )
            )
        )
    

#De aquí en adelante es la parte que corresponde al server

server <- function(input, output) {
    
    library(ggplot2)
    library(plotly)
    
     #Grafico de barras
     output$plot2 <- renderPlot({
         
        x <- data[,input$x]
        fw <- data[,"away.team"]
        
        g <- ggplot(data=data, aes(x, fill = x)) + 
        geom_bar(stat="identity", position="stack", fill = "dodgerblue4") +
        facet_wrap(~fw) +
        theme_replace() +
        theme(axis.title = element_text(face="bold", family="Times New Roman", colour="darkslategray")) + # Tamaño de los títulos de los ejes
        theme(axis.text.x = element_text(face = "bold", color="darkslategray4", size = 10, hjust = 1),
              axis.text.y = element_text(face = "bold", color="darkslategray4", size = 10, vjust = 1))
        g
        #ggplotly(g)
        })

     
    # Data table del fichero match.data.csv
    output$data_table <- renderDataTable( {data}, 
                                          options = list(aLengthMenu = c(5,25,50),
                                                         iDisplayLength = 5)
    )
    
}


shinyApp(ui, server)

