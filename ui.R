source("global.R", local = TRUE)

### Selectoze choice vectors ###



### JS ###

#jscode <- read...

### CSS ###

#css <- read...

ui <- dashboardPage(skin = "black",
                    
                    header <- dashboardHeader(title = "App Name",
                                              tags$li(a(href = "https://www.immunocore.com",
                                                        img(src = "logo2.png",
                                                            title = "Immunocore",
                                                            height = "25px"),
                                                        style = "padding-top:12px;
                                                        padding-bottom:5px;
                                                        padding-left:0px !important;
                                                        margin-left:0px !important;"),
                                                      class = "dropdown")
                    ),
                    
                    sidebar <- dashboardSidebar(width = 240,
                                                shinyjs::useShinyjs(),
                                                #shinyjs::inlineCSS(css),
                                                #extendShinyjs(text = jscode, functions = c('disableTab','enableTab')),
                                                sidebarMenu(id = "main_menu", 
                                                            style = "font-size:16px",
                                                            add_busy_bar(color = "#0096FF", timeout = 400, height = "4px"),
                                                            menuItem("Panel 1",
                                                                     tabName = "p1",
                                                                     icon = icon("console",
                                                                                 lib = "glyphicon"
                                                                     )
                                                            ),
                                                            conditionalPanel(condition = "input.main_menu == 'p1'",
                                                            ),
                                                            menuItem("Panel 2",
                                                                     tabName = "p2",
                                                                     icon = icon("console",
                                                                                 lib = "glyphicon"
                                                                     )
                                                            ),
                                                            conditionalPanel(condition = "input.main_menu == 'p2'",            
                                                            ),
                                                            menuItem("About",
                                                                     tabName = "about",
                                                                     icon = icon("info-sign",
                                                                                 lib = "glyphicon"
                                                                     )
                                                            ),
                                                            conditionalPanel(condition = "input.main_menu == 'about'",            
                                                            )
                                                )
                    ),
                    
                    body <- dashboardBody(
                      #tags$style(css),
                      tabItems(
                        tabItem(tabName = "p1", 
                                fluidRow(
                                  box(width = 4,
                                      title = "Box 1",
                                      style = "font-size:14px; border-left: outset #3EB489;",
                                      collapsible = TRUE,
                                      collapsed = TRUE,
                                  )
                                ),
                                fluidRow(
                                  downloadBttn("download_p1",
                                               color = "primary",
                                               size = "sm"
                                  ),
                                  style="padding-left:15px; padding-top:5px;"
                                ),
                                fluidRow(style = "margin-top: 21px", 
                                         column(width = 12, style="padding:0px",
                                                tabBox(width = 12, 
                                                       tabPanel("Tab panel 1",
                                                                textOutput("tp1")
                                                       ),
                                                       tabPanel("Tab panel 2",
                                                                textOutput("tp2")
                                                       )
                                                )
                                         )
                                )
                        ),
                        tabItem(tabName = "p2",
                                tags$div(id = "div001"),
                                dropdown(
                                  tags$h3("Add element"),
                                  pickerInput(inputId = "element_type",
                                              label = "Select element type",
                                              choices = c("Input element", "Output element", "UX element"),
                                              multiple = TRUE,
                                              selected = NULL,
                                              options = c(pickerOptions(maxOptions = 1))
                                  ),
                                  tags$div(id = "input_type",
                                           pickerInput(inputId = "input_type",
                                                       label = "Input elements",
                                                       choices = c("Text input", "Selectize", "Action button"),
                                                       multiple = TRUE,
                                                       selected = NULL,
                                                       options = c(pickerOptions(maxOptions = 1))
                                           )
                                  ),
                                  tags$div(id = "output_type",
                                           pickerInput(inputId = "output_type",
                                                       label = "Output elements",
                                                       choices = c("Text output", "Plot output"),
                                                       multiple = TRUE,
                                                       selected = NULL,
                                                       options = c(pickerOptions(maxOptions = 1))
                                           )
                                  ), 
                                  tags$div(id = "ux_type",
                                           pickerInput(inputId = "ux_type",
                                                       label = "UX element",
                                                       choices = c("Box", "Tab box"),
                                                       multiple = TRUE,
                                                       selected = NULL,
                                                       options = c(pickerOptions(maxOptions = 1))
                                           )
                                  ),
                                  ### Input ###
                                  tags$div(id = "text_input_args",
                                           textInput(inputId = "ui_text_input_id", #add tooltips at some point
                                                     label = "Enter element ID"
                                           ),
                                           textInput(inputId = "ui_text_input_label",
                                                     label = "Enter element label"
                                           ),
                                           actionBttn(inputId = "ui_text_input_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  tags$div(id = "button_input_args",
                                           textInput(inputId = "ui_button_input_id", #add tooltips at some point
                                                     label = "Enter element ID"
                                           ),
                                           textInput(inputId = "ui_button_input_label",
                                                     label = "Enter button text"
                                           ),
                                           pickerInput(inputId = "ui_button_input_size",
                                                       label = "Button size",
                                                       choices = c("xs", "sm", "md", "lg"),
                                                       multiple = TRUE,
                                                       selected = NULL,
                                                       options = c(pickerOptions(maxOptions = 1))
                                           ),
                                           actionBttn(inputId = "ui_button_input_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  tags$div(id = "selectize_input_args",
                                           textInput(inputId = "ui_selectize_input_id", #add tooltips at some point
                                                     label = "Enter element ID"
                                           ),
                                           textInput(inputId = "ui_selectize_input_label",
                                                     label = "Enter element label"
                                           ),
                                           pickerInput(inputId = "ui_selectize_input_vector_type",
                                                       label = "Choose choices option",
                                                       choices = c("Create vector now", "Existing vector", "Server side"),
                                                       multiple = TRUE,
                                                       selected = NULL,
                                                       options = c(pickerOptions(maxOptions = 1))
                                           ),
                                           tags$div(id = "ui_selectize_input_vector"),
                                           checkboxInput(inputId = "ui_selectize_input_multiple",
                                                       label = "Multi-selected allowed"
                                           ),
                                           actionBttn(inputId = "ui_selectize_input_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  ### Output ###
                                  tags$div(id = "text_output_args",
                                           textInput(inputId = "ui_text_output_id", #add tooltips at some point
                                                     label = "Enter element ID"
                                           ),
                                           actionBttn(inputId = "ui_text_output_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  tags$div(id = "plot_output_args",
                                           textInput(inputId = "ui_plot_output_id", #add tooltips at some point
                                                     label = "Enter element ID"
                                           ),
                                           actionBttn(inputId = "ui_plot_output_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  ### UX ###
                                  tags$div(id = "box_ux_args",
                                           numericInput(inputId = "ui_box_ux_width", #add tooltips at some point
                                                     label = "Enter element width",
                                                     value = NULL
                                           ),
                                           textInput(inputId = "ui_box_ux_label",
                                                     label = "Enter element label"
                                           ),
                                           actionBttn(inputId = "ui_box_ux_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  tags$div(id = "tabbox_ux_args",
                                           numericInput(inputId = "ui_tabbox_ux_width", #add tooltips at some point
                                                     label = "Enter element width",
                                                     value = NULL
                                           ),
                                           numericInput(inputId = "ui_tabbox_ux_number",
                                                     label = "Enter number of tab panels",
                                                     value = NULL
                                           ),
                                           textInput(inputId = "ui_tabbox_ux_names",
                                                     label = "Enter labels (comma separated)"
                                           ),
                                           actionBttn(inputId = "ui_tabbox_ux_insert",
                                                      label = "Insert",
                                                      size = "sm")
                                  ),
                                  style = "stretch", icon = icon("add"),
                                  status = "success", width = "300px",
                                  animate = animateOptions(
                                    enter = animations$fading_entrances$fadeIn,
                                    exit = animations$fading_exits$fadeOut
                                  )
                                )
                                
                        ),
                        tabItem(tabName = "about",
                                fluidRow(style = "margin-top: 21px", 
                                         column(width = 12,
                                                style="padding:0px",
                                                tabBox(width = 12,
                                                       tabPanel("User info",
                                                                includeMarkdown("www/USERINFO.md") # recommended to set absolute path
                                                       ),
                                                       tabPanel("Dev info",
                                                                includeMarkdown("README.md") # recommended to set absolute path
                                                       )
                                                )
                                         )
                                         
                                )
                        )
                      )
                    ),
                    
                    dashboardPage(
                      header,
                      sidebar,
                      body
                    )
)

