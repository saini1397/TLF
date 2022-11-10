
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
          inputId = "home",
          label = "Home",
          icon = icon("home"),
          style = "danger"
        )
      ),
      div(class = "inlay", style = "height:15px;width:100%;background-color:#ecf0f5"),
      menuItem(
        "Data Selection",
        tabName = "Data Selection",
        icon = icon("paint-roller"), br(),
        div(
          div(
            selectInput(
              inputId = "d1", label = "Select Dataset",
              choices = adam_list
            )
          ),
          br(),
          div(
            bsButton(
              "db1",
              label = "Confirm",
              icon = icon("hand-point-right"),
              style = "success"
            ), br()
          )
        )
      ),
      menuItem(
        "Listing Selection",
        tabName = "Listing Selection",
        icon = icon("paint-roller"), br(),
        div(
          div(
            selectInput(
              inputId = "l1", label = "Select Column",
              choices = c("STUDYID","USUBJID","AETERM")
            )
          ),
          br(),
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
        "Table Selection",
        tabName = "Table Selection",
        icon = icon("paint-roller"), br(),
        div(
          div(
            selectInput(
              inputId = "t1", label = "Select Group 1",
              choices = c("PARAM")
            )
          ),
          div(
            selectInput(
              inputId = "t2", label = "Select Group 2",
              choices = c("AVISIT")
            )
          ),
          br(),
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
        "Figure Selection",
        tabName = "Figure Selection",
        icon = icon("paint-roller"), br(),
        div(
          
          div(
            selectInput(
              inputId = "f1", label = "Select Group 1",
              choices = c("PARAM")
            )
          ),
          div(
            selectInput(
              inputId = "f2", label = "Select Group 2",
              choices = c("AVISIT")
            )
          ),
          div(
            selectInput(
              inputId = "x1", label = "Select X-AXIS",
              choices = c("ADY")
            )
          ),
          div(
            selectInput(
              inputId = "x2", label = "Select Y-AXIS",
              choices = c("AVAL")
            )
          ),
          br(),
          div(
            bsButton(
              "fb1",
              label = "Generate Figure",
              icon = icon("hand-point-right"),
              style = "success"
            ), br()
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
