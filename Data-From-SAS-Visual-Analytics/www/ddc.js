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