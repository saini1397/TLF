
server <- (function(input, output) {
  
  observe({
    x1 <- as.name(input$d1)
    
  })
  
  observeEvent(input$lb1, {
      output$listingo <- renderDataTable({
        x1() %>% datatable(rownames = FALSE, extensions = c("FixedColumns"), 
                           options = list(
          #dom = c("f"),
          scrollX = TRUE,
          fixedColumns = list(leftColumns = 2)
          
        ))
      })
    })

  observeEvent(input$tb1, {
    
    output$tableo <- renderDataTable({
      adae %>% datatable(rownames = FALSE, extensions = c("FixedColumns"), options = list(
        #dom = c("f"),
        scrollX = TRUE,
        fixedColumns = list(leftColumns = 2)
        
      ))
    })
  })
  
  observeEvent(input$fb1, {
    output$figureo <- renderPlotly({
      plotly::plot_ly(
        data = adlb,
        x = ~AVISIT,
        y = ~AVAL,
        type = "bar",
        name = "Confirmed",
        marker = list(color = "blue")
      ) %>%
        plotly::add_trace(
          y = ~TRT01A,
          name = "Recovered",
          marker = list(color = "orange")
        ) %>%
        plotly::add_trace(
          y = ~TRT01P,
          name = "Death",
          marker = list(color = "red")
        ) %>%
        plotly::layout(
          barmode = "stack",
          yaxis = list(title = "Total cases"),
          xaxis = list(title = ""),
          hovermode = "compare",
          margin = list(
            # l = 60,
            # r = 40,
            b = 10,
            t = 10,
            pad = 2
          )
        )
    })
  })
  
  observeEvent(input$lb1, {
    show("listing")
    hide("table")
    hide("figure")
  })
  
  observeEvent(input$tb1, {
    hide("listing")
    show("table")
    hide("figure")
  })
  
  observeEvent(input$fb1, {
    hide("listing")
    hide("table")
    show("figure")
  })
  
})
