library(shiny)

ui <- fluidPage(
  # Crear un elemento de entrada para seleccionar archivos
  fileInput("files", "Selecciona archivos CSV", multiple = TRUE),
  # Puedes agregar otros elementos y la interfaz de usuario que necesites aquí
  # ...
)

server <- function(input, output) {
  # Cuando se seleccionen archivos, puedes trabajar con ellos en el servidor
  observe({
    if (!is.null(input$files)) {
      # input$files contiene la información sobre los archivos seleccionados
      # Puedes acceder a los nombres y rutas de los archivos seleccionados
      file_paths <- input$files$datapath
      
      # Aquí puedes leer e importar cada archivo CSV en un objeto de datos
      for (file_path in file_paths) {
        data <- read.csv(file_path)
        # Realiza operaciones con data (por ejemplo, almacenarlos en una lista o dataframe)
      }
    }
  })
}

shinyApp(ui, server)
