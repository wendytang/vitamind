#setwd('C:\\Users\\wtangalang\\Desktop\\Summer 2014\\Shiny_practice')

##### read the data
#lab.data <- read.table("C:\\Users\\wtangalang\\Desktop\\Summer 2014\\RITM0032128_UCSF_sampleLab201406011modified.txt",
#                      sep='\t',as.is=T,quote='"',header=T)

#User has to import data himself/herself

##### Packages to install
#install.packages('shiny') ; library(shiny)
#install.packages('ggplot2') ; library('ggplot2')

lab.data[,3] <- as.Date(lab.data[,3],"%m/%d/%Y") ## convert to dates

subset.data <- lab.data[lab.data$ComponentName == "VITAMIND, 25-HYDROXY" ,c(1,3,9)]
subset.data$Value <- as.numeric(subset.data$Value)

shinyServer(
  function(input, output) {
  
    output$plot <- renderPlot({
      if(input$checkbox){     #if plot everyone is checkmarked
        
#        plot(subset.data[ ,c(2,3)] ,las=3 ,
#             xlab='Date',ylab= "VITAMIND, 25-HYDROXY", 
#             xlim=c(min(lab.data$ContactDate),max(lab.data$ContactDate)),
#             ylim=c(min(subset.data$Value),max(subset.data$Value)),
#             main= "All Patients" )
        plot_all <- ggplot(subset.data, aes(x=ContactDate, y=Value, group=MRNmodified))
        plot_all +  geom_line(aes(colour = factor(MRNmodified))) + geom_point(aes(colour = factor(MRNmodified)),size=3) + 
        labs(title = 'All Patients', x='Date',y='Vitamin D, 25-Hydroxy')
        
      }
      else if(dim(subset.data[subset.data$MRNmodified == input$mrn,c(2,3)])[1] ==0){ #If no entries!
#        plot(c(as.Date('2011-06-24')),c(0),type="n",xlab="Date",ylab="VITAMIND, 25-HYDROXY",
#             xlim=c(min(lab.data$ContactDate),max(lab.data$ContactDate)),
#             ylim=c(min(subset.data$Value),max(subset.data$Value)),
#               main= paste("Modified MRN ",input$mrn))
        
        plot_none <- ggplot(subset.data, aes(x=ContactDate, y=Value, group=MRNmodified))
        plot_none + geom_blank() + labs(title = paste("Modified MRN ",input$mrn), x='Date',y='Vitamin D, 25-Hydroxy')
        
      }
      else {
#        plot(subset.data[subset.data$MRNmodified == input$mrn,c(2,3)] ,las=3 ,
#             xlab='Date',ylab= "VITAMIND, 25-HYDROXY", 
#             xlim=c(min(lab.data$ContactDate),max(lab.data$ContactDate)),
#             ylim=c(min(subset.data$Value),max(subset.data$Value)),
#             main= paste("Modified MRN ",input$mrn))
        
        plot_none <- ggplot(subset.data, aes(x=ContactDate, y=Value))
        plot_none + geom_blank() + geom_line(data= subset.data[subset.data$MRNmodified == input$mrn,]) + 
          geom_point(data= subset.data[subset.data$MRNmodified == input$mrn,], size=3) + labs(title = paste("Modified MRN ",input$mrn), x='Date',y='Vitamin D, 25-Hydroxy')
                
      }
    })
  }
)
