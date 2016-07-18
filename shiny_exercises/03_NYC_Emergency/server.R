library(shiny)
library(ggplot2)
library(dplyr)
library(readr)
library(lubridate)
library(stringr)

nyc <- read_csv("nyc_emergency.csv")

# generate a vector of dates of class Date
nyc$mdy <- vector(mode = "character", length = nrow(nyc))
for(i in 1:nrow(nyc)) {
  nyc$mdy[i] <- str_split(nyc$`Creation Date`[i], " ")[[1]][1]
}
nyc$mdy <- mdy(nyc$mdy)

# drop some copumns 
nyc1 <- select(nyc, Borough, mdy)

# rename Boroughs into all lower case
nyc1$Borough <- tolower(nyc1$Borough)

# get number of incidents for each day*Borough combination
boroughs <- unique(nyc1$Borough)
nyc2 <- data.frame() 
for(i in 1:length(boroughs)) {
  borough.dat <- nyc1 %>% filter(Borough == boroughs[i])
  uniq.dates <- unique(borough.dat$mdy)
  tmp <- as.data.frame(table(borough.dat$mdy))
  rownames(tmp) <- tmp$Var1 
  tmp <- tmp[as.character(uniq.dates), ] %>% tbl_df
  tmp$mdy <- uniq.dates
  tmp$Borough <- boroughs[i]
  nyc2 <- rbind(nyc2, tmp)
}

shinyServer(function(input, output) {
    
    nyc_subset <- reactive({
        nyc2 %>% filter(Borough == input$borough)
    })
    
    output$crime <- renderPlot({
        ggplot(data = nyc_subset(), aes(x = mdy, y = Freq)) +
            geom_line(aes(group=Borough)) + ggtitle("Number of incidents") +
            labs(x = "Month", y = "# incidents")
    })

})
