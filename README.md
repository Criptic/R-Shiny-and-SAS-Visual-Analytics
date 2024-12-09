# R Shiny and SAS Visual Analytics
In this example I showcase how you can integrate an R Shiny application with SAS Visual Analytics (VA). This enables us to send data with full access rights management and row level security enabled to our R Shiny application and then build out our R Shiny dashboard as you want.

See this repository in action in this [YouTube video](https://youtu.be/C9fiHHDETrA).

## Setup in SAS Viya

You can either import the [transfer package](./R-Shiny.json), which will create a folder called R-Shiny in Public and contain a SAS script + the VA report, or you can follow the next steps:

1.   Go to SAS Studio, open up a new program and run the code from the [Load-Cars-toCAS.sas](./Load-Cars-toCAS.sas).
2.   Now the Cars dataset is available in CAS
3.   Navigate to SAS VA (Explore and Visualize) and click *New report* .
4.   As a data source select the *Cars* dataset (by default it will be loaded into the *Public* CAS library).
5.   Go to the *Objects* pane, search for *Data-driven content* and drag it into the page
6.   Assign it a couple of columns and you are set now over to R

## Setup in R

Either clone this repository or copy the full content of the [Data-From-SAS-Visual-Analytics](./Data-From-SAS-Visual-Analytics) folder. This script was tested on R 4.3.1 and you will need to have Shiny (version 1.7.5 was used) installed (install.packages("shiny")).

Now you can already run the app, if you open up the server.R script. Make sure that you have deployed R Shiny so that VA can reach it.

## Background

The data driven content object (DDC) in VA enables users to integrate third-party visualization tools into VA by passing data between the two applications in the context of the specific user. In JavaScript we can receive the data in every easy way - this is the content of [ddc.js](./www/ddc.js):

```javascript
if (window.addEventListener) {
  // For standards-compliant web browsers
  window.addEventListener('message', onMessage, false);
} else {
  window.attachEvent('onmessage', onMessage);
}

// Retrieve data and begin processing
function onMessage(event) {
  if (event && event.data) {
    // Display the data from SAS Visual Analytics in the Browsers developer console
    //console.log(event.data);
    Shiny.setInputValue("data", event.data);
  }
}
```

With this function in place we can send data to our Shiny application and can receive it - this is an excerpt from [server.R](./server.R):

```R
library(shiny)

shinyServer(function(input, output, session) {
  observeEvent(input$data, {
    print(input$data)
  }
}
```

Now we just need to convert the input data into a data frame and you can start building as you see fit while enjoying the authentication and authorization from SAS.

## Additional Links

-   Great introduction on how to use JavaScript with R Shiny in the [Engineering Production-Grade Shiny Apps](https://engineering-shiny.org/using-javascript.html) guide.
-   My deep dive into the DDC object on my [Substack](https://davidweik.substack.com/p/creating-data-driven-content-in-sas-visual-analytics).
-   Programming Consideration for the DDC in the [SAS Documentation](https://go.documentation.sas.com/doc/en/vacdc/default/varef/n109mqtyl6quiun1mwfgtcn2s68b.htm).
-   To find and share samples of third-party visualizations, see the SAS Software GitHub repository: https://github.com/sassoftware/sas-visualanalytics-thirdpartyvisualizations.

