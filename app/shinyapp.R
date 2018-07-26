library(shiny)
library(request)
library(plotly)
library(jsonlite)

# Define the UI
ui <- bootstrapPage(
  h3('My awesome app'),
  plotlyOutput('plt_chart')
)


# Define the server code
server <- function(input, output) {
  output$plt_chart =renderPlotly({
    df = fromJSON('http://127.0.0.1:8000/data')
    
    p = plot_ly(data = df,
            x = ~ age,
            y = ~ education_num,
            text = ~value)
    p
  })
}

# Return a Shiny app object
shinyApp(ui = ui, server = server,options = list(height = 1080))