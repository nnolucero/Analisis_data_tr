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
    data <- read.csv(input$file$datapath)
    
    # Eliminar filas con valores NA o vacíos en cualquier columna
    data <- na.omit(data)
    
    return(data)
  })
  
  output$tabla_datos <- renderTable({
    req(datos())
    datos()
  })
}

shinyApp(ui, server)
