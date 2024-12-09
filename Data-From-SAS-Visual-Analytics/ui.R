shinyUI(
  bootstrapPage(
    # Include CSS
    includeCSS("www/style.css"),
    # Include the JavaScript which handles the communication
    includeScript("www/ddc.js"),
    
    div( id = "container", 
         # Display the text about number of rows and columns
         textOutput("text"),
         # Displaying the data frame as a static table
         tableOutput("table")
    )
  )
)