
shinyUI(fluidPage(
  titlePanel("Patient Queries for Vitamin D, 25-Hydroxy Procedures"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Creates a single graph  of all available Vitamin D data trajectories (segments) :  for all patients X axis is date, Y axis in ng/mL"),
      
      selectInput("MRN", 
                  label = "Choose your modified MRN",
                  choices = c(1:15),
                  selected = "99Y0Y998"),
      
      checkboxInput("checkbox", label= "Plot everyone", value = FALSE)      
      ),
    
    mainPanel(plotOutput("plot")))
  )
)
