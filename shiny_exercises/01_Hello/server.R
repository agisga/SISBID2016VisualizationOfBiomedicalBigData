library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$distPlot <- renderPlot({
        dist <- data.frame(
          normal = rnorm(n = input$obs, mean = input$mu, sd = input$sd),
          gamma = rgamma(n = input$obs, shape = input$shape, scale = input$scale))
        
        require(ggplot2)
        
        if(input$distrib == "Normal") {
          qplot(dist$normal, geom="histogram", binwidth = 0.25)
        } else if(input$distrib == "Gamma") {
          ggplot(dist, aes(dist$gamma)) + 
            geom_histogram(binwidth = 0.25, fill = "darkgreen")
        }
    })
})
