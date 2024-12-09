shinyUI(
  bootstrapPage(
    
    # include css
    includeCSS("www/style.css"),
    
    includeScript("www/ddc.js"),
    
    div( id = "container", 
         # text output
         textOutput("text"),
         
         # Displaying the data frame as a static table
         tableOutput("table")
    )
  )
)