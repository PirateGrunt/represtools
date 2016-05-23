#' Reproducible research helper
#'
#' @export
#'
rrtAddin <- function() {

  # Get the document context.
  context <- rstudioapi::getActiveDocumentContext()

  # Set the default data to use based on the selection.
  text <- context$selection[[1]]$text
  defaultData <- text

  # Generate UI for the gadget.
  ui <- miniPage(
    gadgetTitleBar("represtools"),
    miniContentPanel(
        actionButton("btnMojo", getwd()),
        textInput("gather", "Gather"),
        textInput("cook", "Cook"),
        textInput("analyze", "Analyze"),
        textInput("present", "Present"),
        actionButton("btnGather", "Gather"),
        actionButton("btnMakeGather", "Make Gather")
      )
  )


  # Server code for the gadget.
  server <- function(input, output, session) {

    reactiveData <- reactive({
    })

    # Listen for 'done'.
    observeEvent(input$done, {
      print(input$gather)
      if (nchar(input$gather) != 0){
      represtools::Gather(input$gather)
    }
      invisible(stopApp())

    })

    observeEvent(input$cancel, {
      print ("User cancelled")
      invisible(stopApp())

    })
  }

  # Use a modal dialog as a viewr.
  viewer <- dialogViewer("represtools", width = 1000, height = 800)
  runGadget(ui, server, viewer = viewer)

}
