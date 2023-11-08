source("global.R", local = TRUE)

server <- function(input, output, session){
  
  
  ########### the key is going to be to use as many functions as possible
  ########### because this script is going to get complicated very quickly
  #### I think this will have to be split into modules as it's bouta get fucking difficult
  
  ##### also I'm pretty sure I only need one div, as it keeps inserting elements below in the same div
  ##### however, this may make it difficult for reordering components
  
  ### at some point I may want to add somethig that says 'insert inside element'
  ### however this will inevitably rerendering all the parent elements
  
  ### Functions ###
  
  ## Insertion functions ##
  
  # Input #
  
  create_textInput <- function(inputId, label) {
    object <- paste0('textInput(inputId = "', inputId, '", label = "', label, '")')
    return(object)
  }
  
  create_actionBttn <- function(inputId, label, size) {
    object <- paste0('actionBttn(inputId = "', inputId, '", label = "', label, '", size = "', size, '")')
    return(object)
  }
  
  # Output #
  
  create_textOutput <- function(id) {
    object <- paste0('textOutput("', id, '")')
    return(object)
  }
  
  create_plotOutput <- function(id) {
    object <- paste0('plotOutput("', id, '")')
    return(object)
  }
  
  # UX #
  
  create_box <- function(width, label) {
    object <- paste0('fluidRow(
                         box(width = ', width, ',
                         title = "', label, '",
                         style = "font-size:14px; border-left: outset #3EB489;",
                         collapsible = TRUE,
                         collapsed = TRUE,
                     )
                     )'
    )
    #obviously at some point i will want to make this more customizable
  }
  
  
  create_tabPanel <- function(number, names) {
    tabPanels <- ""
    for (x in 1:number) {
      tabPanels <- paste0(tabPanels, paste0('tabPanel("', names[x], '"),'))
    }
    return(tabPanels)
  }
  
  create_tabBox <- function(width, number, names) {
    object <- paste0('fluidRow(
                         tabBox(width = ', width, ',',
                      create_tabPanel(number = number, names = names),
                      ')
                     )'
    )
  }
  
  generate_ui_block <- function(divId, createBlockType) {
    block <- paste0('insertUI(selector = "#', divId, '", ui = tags$div(', createBlockType, ', id = "', paste0(divId, '_inserted"'),'))'
    )
    return(block)
  }
  
  ## Creation UI functions ##
  hide_element_options_all <- function() {
    hide_element_options_parents()
    hide_element_options_children()
  }
  
  hide_element_options_parents <- function() {
    shinyjs::hideElement("input_type")
    shinyjs::hideElement("output_type")
    shinyjs::hideElement("ux_type")
  }
  
  hide_element_options_children <- function() {
    shinyjs::hideElement("text_input_args")
    shinyjs::hideElement("button_input_args")
    shinyjs::hideElement("selectize_input_args")
    shinyjs::hideElement("text_output_args")
    shinyjs::hideElement("plot_output_args")
    shinyjs::hideElement("box_ux_args")
    shinyjs::hideElement("tabbox_ux_args")
  }
  
  clear_picker_input <- function(inputId) {
    updatePickerInput(
      session, 
      inputId, 
      selected = ""
    )
  }
  
  clear_text_input <- function(inputId) {
    updateTextInput(
      session, 
      inputId, 
      value = ""
    )
  }
  
  clear_checkbox_input <- function(inputId) {
    updateCheckboxInput(
      session, 
      inputId, 
      value = ""
    )
  }
  
  ## Removal functions ##
  
  
  
  ### Variables ###
  
  
  
  ### Reactives ###
  
  # choosing parent element type
  observeEvent(input$element_type,{
    hide_element_options_all()
    if (input$element_type == "Input element") {
      shinyjs::showElement("input_type")
    } else if (input$element_type == "Output element") {
      shinyjs::showElement("output_type")
    } else if (input$element_type == "UX element") {
      shinyjs::showElement("ux_type")
    }
  })
  
  # choosing child element type (input)
  observeEvent(input$input_type, {
    hide_element_options_children()
    if (input$input_type == "Text input") {
      shinyjs::showElement("text_input_args")
    } else if (input$input_type == "Action button") {
      shinyjs::showElement("button_input_args")
    } else if (input$input_type == "Selectize") {
      shinyjs::showElement("selectize_input_args")
    }
  })
  
  # choosing child element type (output)
  observeEvent(input$output_type, {
    hide_element_options_children()
    if (input$output_type == "Text output") {
      shinyjs::showElement("text_output_args")
    } else if (input$output_type == "Plot output") {
      shinyjs::showElement("plot_output_args")
    }
  })
  
  # choosing child element type (UX)
  observeEvent(input$ux_type, {
    hide_element_options_children()
    if (input$ux_type == "Box") {
      shinyjs::showElement("box_ux_args")
    } else if (input$ux_type == "Tab box") {
      shinyjs::showElement("tabbox_ux_args")
    }
  })
  
  ## Element insertions ##
  
  # Input #
  
  # textInput
  observeEvent(input$ui_text_input_insert, {
    operation <- generate_ui_block(divId = "div001",
                                   createBlockType = create_textInput(
                                     inputId = input$ui_text_input_id,
                                     label = input$ui_text_input_label
                                   )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("input_type")
    clear_text_input("ui_text_input_id")
    clear_text_input("ui_text_input_label")
    hide_element_options_all()
  })
  
  # actionBttn
  observeEvent(input$ui_button_input_insert, {
    operation <- generate_ui_block(divId = "div001",
                                   createBlockType = create_actionBttn(
                                     inputId = input$ui_button_input_id,
                                     label = input$ui_button_input_label,
                                     size = input$ui_button_input_size
                                   )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("input_type")
    clear_text_input("ui_button_input_id")
    clear_text_input("ui_button_input_label")
    clear_picker_input("ui_button_input_size")
    hide_element_options_all()
  })
  
  # selectizeInput
  # observeEvent(input$ui_selectize_input_vector_type, {
  #   if (input$ui_selectize_input_vector_type == "Create vector") {
  #     ...
  #   }
  # })
  
  observeEvent(input$ui_selectize_input_insert, {
    operation <- generate_ui_block(divId = "div001",
                                   createBlockType = create_selectizeInput(
                                     inputId = input$ui_button_input_id,
                                     label = input$ui_button_input_label,
                                     size = input$ui_button_input_size
                                   )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("input_type")
    clear_text_input("ui_selectize_input_id")
    clear_text_input("ui_selectize_input_label")
    clear_picker_input("ui_selectize_input_vector_type")
    clear_picker_input("ui_selectize_input_vector")
    clear_picker_input("ui_selectize_input_multiple")
    hide_element_options_all()
  })
  
  # Output #
  
  # textOutput
  observeEvent(input$ui_text_output_insert, {
    operation <- generate_ui_block(divId = "div001",
                                   createBlockType = create_textOutput(
                                     id = input$ui_text_output_id
                                   )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("input_type")
    clear_text_input("ui_text_output_id")
    hide_element_options_all()
  })
  
  # plotOutput
  observeEvent(input$ui_plot_output_insert, {
    operation <- generate_ui_block(divId = "div001",
                                   createBlockType = create_plotOutput(
                                     id = input$ui_plot_output_id
                                   )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("input_type")
    clear_text_input("ui_plot_output_id")
    hide_element_options_all()
  })
  
  # UX #
  
  # box
  observeEvent(input$ui_box_ux_insert, {
    operation <- generate_ui_block(divId = "div001",
                                   createBlockType = create_box(
                                     width = input$ui_box_ux_width,
                                     label = input$ui_box_ux_label
                                   )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("ux_type")
    clear_text_input("ui_box_ux_width")
    clear_text_input("ui_box_ux_label")
    hide_element_options_all()
  })
  
  observeEvent(input$ui_tabbox_ux_insert, {
    split_names <- unlist(strsplit(input$ui_tabbox_ux_names, ","))
    operation <- generate_ui_block(divId = "div001",
                                    createBlockType = create_tabBox(
                                      width = input$ui_tabbox_ux_width,
                                      number = input$ui_tabbox_ux_number,
                                      names = split_names
                                    )
    )
    eval(parse(text = operation))
    clear_picker_input("element_type")
    clear_picker_input("ux_type")
    clear_text_input("ui_box_ux_width")
    clear_text_input("ui_box_ux_label")
    clear_text_input("ui_box_ux_names")
    hide_element_options_all()
  })
  
  ## Element removals ##
  
  ### Transients ###
  
  hide_element_options_all()
  
  #   # removeUI(
  #   #   selector = '#dynamic_ui_inserted'
  #   # )
  
  ### Outputs ###
  
  output$tp1 <- renderText({"Tab panel 1"})
  output$tp2 <- renderText({"Tab panel 2"})
  output$tp3 <- renderText({"Tab panel 3"})
  output$tp4 <- renderText({"Tab panel 4"})
  
}