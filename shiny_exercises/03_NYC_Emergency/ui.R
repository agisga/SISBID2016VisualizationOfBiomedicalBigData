library(shiny)

nyc <- read.csv("nyc_emergency.csv", stringsAsFactors = FALSE)
# rename Boroughs into all lower case
nyc$Borough <- tolower(nyc$Borough)

shinyUI(fluidPage(
    
    titlePanel("NYC Crime Data"),
    
	sidebarPanel(
	    selectInput("borough", "Borough", choices = sort(unique(nyc$Borough)), 
                  selected = "brooklyn")
	),

	mainPanel(
	    plotOutput("crime")
	)
))
