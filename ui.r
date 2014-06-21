#ui.r

shinyUI(fluidPage(
  titlePanel("Patient Queries for Vitamin D, 25-Hydroxy Procedures"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Creates a single graph  of all available Vitamin D data trajectories (segments) :  for all patients X axis is date, Y axis in ng/mL"),
      
      selectInput("mrn", 
                  label = "Choose your modified MRN",
                  choices = unique(lab.data[,1]),
                  selected = "99Y0Y998"),
      
      checkboxInput("checkbox", label= "Plot everyone", value = FALSE)      
      ),
    
    mainPanel(plotOutput("plot")))
  )
)
