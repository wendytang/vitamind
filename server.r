
# Shiny Example -----------------------------------------------------------
## Originally developed for URAP data visualizations to display Patient VitaminD levels
## Author: Wendy Tang Contact: tangwendy92@gmail.com
## Update 4/8/2015: now contains fake data
load(file.path(getwd(),"fakeData.RData"))

# Setup -------------------------------------------------------------------
# install packages
packages <- c("ggplot2", "shiny")
newPackages <- packages[!(packages %in% installed.packages()[,"Package"])]

if(length(newPackages)){
  install.packages(newPackages)
}

library("ggplot2")
library("shiny")

# Server ------------------------------------------------------------------
shinyServer(
  function(input, output) {
  
    output$plot <- renderPlot({
      if(input$checkbox){     #if plot everyone is checkmarked
        plot_all <- ggplot(subset.data, aes(x=ContactDate, y=Value, group=MRN))
        plot_all +  geom_line(aes(colour = factor(MRN))) + geom_point(aes(colour = factor(MRN)),size=3) + 
        labs(title = 'All Patients', x='Date',y='Vitamin D, 25-Hydroxy')
        
      }
     else if(any(subset.data$MRN == input$MRN)){ 
       plot_some <- ggplot(subset.data, aes(x=ContactDate, y=Value))
       plot_some + geom_blank() + geom_line(data= subset.data[subset.data$MRN == input$MRN,]) + 
         geom_point(data= subset.data[subset.data$MRN == input$MRN,], size=3) + labs(title = paste("Modified MRN ",input$MRN), x='Date',y='Vitamin D, 25-Hydroxy')
       
    } else { #If no entries!
      plot_none <- ggplot(subset.data, aes(x=ContactDate, y=Value, group=MRN))
      plot_none + geom_blank() + labs(title = paste("Modified MRN ",input$MRN), x='Date',y='Vitamin D, 25-Hydroxy')        
      
      }
    })
  }
)
