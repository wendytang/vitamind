#server.r

##### read the data
#lab.data <- read.table("C:\\Users\\wtangalang\\Desktop\\Summer 2014\\RITM0032128_UCSF_sampleLab201406011modified.txt",
#                       sep='\t',as.is=T,quote='"',header=T)

#User has to import data himself/herself

lab.data[,3] <- as.Date(lab.data[,3],"%m/%d/%Y") ## convert to dates

subset.data <- lab.data[lab.data$ComponentName == "VITAMIND, 25-HYDROXY" ,c(1,3,9)]
subset.data$Value <- as.numeric(subset.data$Value)

shinyServer(
  function(input, output) {
  
    output$plot <- renderPlot({
      if(input$checkbox){
        plot(subset.data[ ,c(2,3)] ,las=3 ,
             xlab='Date',ylab= "VITAMIND, 25-HYDROXY", 
             xlim=c(min(lab.data$ContactDate),max(lab.data$ContactDate)),
             ylim=c(min(subset.data$Value),max(subset.data$Value)),
             main= "All Patients" )        
      }
      else if(dim(subset.data[subset.data$MRNmodified == input$mrn,c(2,3)])[1] ==0){
        plot(c(as.Date('2011-06-24')),c(0),type="n",xlab="Date",ylab="VITAMIND, 25-HYDROXY",
             xlim=c(min(lab.data$ContactDate),max(lab.data$ContactDate)),
             ylim=c(min(subset.data$Value),max(subset.data$Value)),
               main= paste("Modified MRN ",input$mrn))
      }
      else {
        plot(subset.data[subset.data$MRNmodified == input$mrn,c(2,3)] ,las=3 ,
             xlab='Date',ylab= "VITAMIND, 25-HYDROXY", 
             xlim=c(min(lab.data$ContactDate),max(lab.data$ContactDate)),
             ylim=c(min(subset.data$Value),max(subset.data$Value)),
             main= paste("Modified MRN ",input$mrn))
      }
    })
  }
)
