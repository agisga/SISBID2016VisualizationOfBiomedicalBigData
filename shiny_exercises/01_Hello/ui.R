library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("Hello Shiny World!"),
    
    # Sidebar with a slider input for the number of bins
	sidebarPanel(
	    selectInput("distrib", "Distribution:", 
	                choices = c("Normal", "Gamma"), selected = "Normal"),
	    sliderInput("obs",
		        "Number of Observations:",
		        min = 0,
		        max = 5000,
		        value = 2500),
	    conditionalPanel(condition = "input.distrib == 'Normal'",
	      numericInput("mu",
	                   "Mean",
	                   step = 1,
	                   value = 0),
	      numericInput("sd",
	                   "Standard Deviation",
	                   value = 1,
	                   step = .1,
	                   min = .Machine$double.eps,
	                   max = Inf) ),
	    conditionalPanel(condition = "input.distrib == 'Gamma'",
	      numericInput("shape",
	                   "Shape",
	                   step = .1,
	                   value = 1,
	                   min = 0),
	      numericInput("scale",
	                   "Scale",
	                   value = 1,
	                   step = .1,
	                   min = .Machine$double.eps,
	                   max = Inf) )
	),

	# Show a plot of the generated distribution
	mainPanel(
	    plotOutput("distPlot")
	)
))
