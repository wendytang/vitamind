
# Shiny Example -----------------------------------------------------------
## Originally developed for URAP data visualizations to display Patient VitaminD levels
## Author: Wendy Tang Contact: tangwendy92@gmail.com
## Update 4/8/2015: now contains fake data


# generate fake data ------------------------------------------------------

subset.data <- data.frame("MRN" = sample(c(1:15),30,T),
                          "CSN" = sample(c(1:15),30,T),
                          "ContactDate" = as.Date("2014-04-08") + sample(c(1:365),30,T),
                          "OrderID" = sample(c(1:15),30,T),
                          "ProcedureName" = "Vitamin D, 25-Hydroxy",
                          "LINE" = 1,
                          "ResultDate" = as.Date("2014-05-08") + sample(c(1:365),30,T),
                          "Value" = sample(c(10:55,10:25,10:25,25:40),30,T),
                          "Unit" = "xxx"
                          )


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
        labs(title = 'All Patients', x='Date',y='Vitamin D, 25-Hydroxy') + theme_bw()
        
      }
     else if(any(subset.data$MRN == input$MRN)){ 
       plot_some <- ggplot(subset.data, aes(x=ContactDate, y=Value))
       plot_some + geom_blank() + geom_line(data= subset.data[subset.data$MRN == input$MRN,]) + 
         geom_point(data= subset.data[subset.data$MRN == input$MRN,], size=3) + labs(title = paste("Modified MRN ",input$MRN), x='Date',y='Vitamin D, 25-Hydroxy') + theme_bw()
       
    } else { #If no entries!
      plot_none <- ggplot(subset.data, aes(x=ContactDate, y=Value, group=MRN))
      plot_none + geom_blank() + labs(title = paste("Modified MRN ",input$MRN), x='Date',y='Vitamin D, 25-Hydroxy') + theme_bw()        
      
      }
    })
  }
)
