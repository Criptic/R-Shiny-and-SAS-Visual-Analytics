library(shiny)

shinyServer(function(input, output, session) {
  
  observeEvent(input$data, {
    if (!is.null(input$data)) {
      num_of_rows <- input$data$rowCount
      num_of_cols <- length(input$data$columns)
      
      # Construct the appropriate text based on row/column count
      if (num_of_rows < 2 && num_of_cols < 2) {
        text <- paste("The data has", num_of_rows, "row and", num_of_cols, "column.")
      } else if (num_of_rows < 2) {
        text <- paste("The data has", num_of_rows, "row and", num_of_cols, "columns.")
      } else if (num_of_cols < 2) {
        text <- paste("The data has", num_of_rows, "rows and", num_of_cols, "column.")
      } else {
        text <- paste("The data has", num_of_rows, "rows and", num_of_cols, "columns.")
      }
      
      # Render the constructed text
      output$text <- renderText({ text })
      
      # Extract column metadata
      column_labels <- sapply(input$data$columns, function(col) col$label)
      
      # Create DataFrame
      data_matrix <- do.call(rbind, input$data$data)
      df <- as.data.frame(data_matrix)
      colnames(df) <- column_labels

      # Render the DataFrame as a table
      output$table <- renderTable({ df }, rownames = TRUE)
    } else {
      output$text <- renderText({ "No data received." })
      output$table <- renderTable({ NULL }) # Clear table if no data
    }
  })
})
