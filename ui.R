ui <- dashboardPage(
  skin = "black",
  title = "TLF",

  dashboardHeader(
    title = span("TLF"),
    titleWidth = 300,
    tags$li(
      a(
        strong("GitHub Codes !!"),
        height = 40,
        href = "https://github.com/saini1397/tlf/tree/master",
        title = "",
        target = "_blank"
      ),
      class = "dropdown"
    )
  ),

  dashboardSidebar(
    width = 300,
    div(class = "inlay", style = "height:15px;width:100%;background-color:#ecf0f5"),
    sidebarMenu(
      div(
        id = "sidebar_button",
        bsButton(
          inputId = "reset",
          label = "Reset",
          icon = icon("home"),
          style = "danger"
        )
      ),
      div(class = "inlay", style = "height:15px;width:100%;background-color:#ecf0f5"),
      menuItem(
        "Listing",
        tabName = "Listing Selection",
        icon = icon("list"), br(),
        div(
          div(
          selectInput(
            inputId = "dl1", label = "Select Dataset",
            choices = adam_list,
            selected="adae"
          )
        ),div(
          selectInput(
            inputId = "filter1", label = "Select Population Filter",
            choices = "ITTFL",
            selected="ITTFL"
          )
        ),
          div(
            shinyWidgets::pickerInput(
              inputId = "l1", label = "Select Columns:",
              choices = c("STUDYID","USUBJID","AETERM"),
              multiple = TRUE,
              selected=NULL,
              options = shinyWidgets::pickerOptions(
                actionsBox = TRUE,
                title = "Please select Columns to Display",
              ),width = "100%"
            )
          ),
          div(
            bsButton(
              "lb1",
              label = "Generate Listing",
              icon = icon("hand-point-right"),
              style = "success"
            ), br()
          )
        )
      ),
      menuItem(
        "Table",
        tabName = "Table Selection",
        icon = icon("table"), br(),
        div(
          div(
            selectInput(
              inputId = "dt1", label = "Select Dataset",
              choices = adam_list,
              selected="adae"
            )
          ),div(
            selectInput(
              inputId = "filter2", label = "Select Population Filter",
              choices = "ITTFL",
              selected="ITTFL"
            )
          ),
          div(
            selectInput(
              inputId = "t1", label = "Select Grouping Variable 1",
              choices = c("AESOC")
            )
          ),
          div(
            selectInput(
              inputId = "t2", label = "Select Grouping Variable 2",
              choices = c("AEDECOD")
            )
          ),
          div(
            bsButton(
              "tb1",
              label = "Generate Table",
              icon = icon("hand-point-right"),
              style = "success"
            ), br()
          )
        )
      ),
      menuItem(
        "Figure",
        tabName = "Figure Selection",
        icon = icon("paint-roller"), br(),
        div(
          div(
            selectInput(
              inputId = "df1", label = "Select Dataset",
              choices = adam_listf,
              selected="adlbhy"
            )
          ),div(
            selectInput(
              inputId = "filter3", label = "Select Population Filter",
              choices = "ITTFL",
              selected="ITTFL"
            )
          ),
          div(
            selectInput(
              inputId = "f1", label = "Select Parameter:",
              choices = c("NULL")
            )
          ),
          div(
            selectInput(
              inputId = "f4", label = "Select Graph Type:",
              choices = c("Bar Chart","Box Plot","Line/Scatter Plot"),
              multiple = FALSE
            )
          ),
          div(
            selectInput(
              inputId = "xaxis", label = "Select X-AXIS",
              choices = c("AVISIT")
            )
          ),
          div(
            selectInput(
              inputId = "yaxis", label = "Select Y-AXIS",
              choices = c("AVAL")
            )
          ),
          div(
            bsButton(
              "fb1",
              label = "Generate Figure",
              icon = icon("hand-point-right"),
              style = "success"
            )
          )
        )
      )
    )
  ),

  dashboardBody(
    tags$head(
      tags$link(
        rel = "stylesheet",
        type = "text/css",
        href = "tlf.css"
      )
    ),

    br(),


    hidden(div(id = "listing", fluidRow(
      div(
        column(
          width = 12,
          tabBox(
            width = NULL,
            height = 400,
            tabPanel(
              useShinyjs(),
              title = "Data Listing",
              withSpinner(
                dataTableOutput("listingo"),
                type = 4,
                color = "#d33724",
                size = 0.7
              )
            )
          )
        )
      )
    ))),

    hidden(div(id = "table", fluidRow(
      div(
        column(
          width = 12,
          tabBox(
            width = NULL,
            height = 400,
            tabPanel(
              useShinyjs(),
              title = "Table",
              withSpinner(
                dataTableOutput("tableo"),
                type = 4,
                color = "#d33724",
                size = 0.7
              )
            )
          )
        )
      )
    ))),
    hidden(div(id = "figure", fluidRow(
      div(
        column(
          width = 12,
          tabBox(
            width = NULL,
            height = 400,
            tabPanel(
              useShinyjs(),
              title = "Figure",
              withSpinner(
                plotlyOutput("figureo", height = "100%", width = "100%"),
                type = 4,
                color = "#d33724",
                size = 0.7
              )
            )
          )
        )
      )
    )))
    
  )
)
