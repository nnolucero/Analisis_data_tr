library(shiny)
library(dplyr)

ui <- fluidPage(
  titlePanel("Cargar y Filtrar Archivo CSV"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Selecciona un archivo CSV")
    ),
    
    mainPanel(
      tableOutput("tabla_datos")
    )
  )
)

server <- function(input, output) {
  datos <- reactive({
    req(input$file)
    # Cargar csv solicitado
    data <- read.csv(input$file$datapath)
    
    # Eliminar filas con valores NA o vacíos en cualquier columna
    data <- na.omit(data)
    
    # Conservar solo columnas Trade#, Type, Date.Time y Profit %
    data <- data[ ,-c(3,5:7,9:14)]
    
    
    return(data)
  })
  
  output$tabla_datos <- renderTable({
    req(datos())
    datos()
  })
}

shinyApp(ui, server)