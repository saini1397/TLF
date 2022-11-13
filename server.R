server <- (function(input, output,session) {
  
  
  x1 <- reactive({
    get(input$dl1)
  })
  
  x2 <- reactive({
    get(input$dt1)
  })
  
  x3 <- reactive({
    get(input$df1)
  })
  
  # To get Treatment Variable
  
  trt_vart <- reactive({
    
   if (length(names(x2())[names(x2()) %in% c("TRTA")])!=0)
   "TRTA"
   else if (length(names(x2())[names(x2()) %in% c("TRT01A")])!=0)
   "TRT01A"
   else if (length(names(x2())[names(x2()) %in% c("TRTP")])!=0)
   "TRTP"
   else if (length(names(x2())[names(x2()) %in% c("TRT01P")])!=0)
   "TRT01P"
    
  })
  
  trt_varf <- reactive({
    
    if (length(names(x3())[names(x3()) %in% c("TRTA")])!=0)
      "TRTA"
    else if (length(names(x3())[names(x3()) %in% c("TRT01A")])!=0)
      "TRT01A"
    else if (length(names(x3())[names(x3()) %in% c("TRTP")])!=0)
      "TRTP"
    else if (length(names(x3())[names(x3()) %in% c("TRT01P")])!=0)
      "TRT01P"
    
  })
  
 
  # To update drop down dynamically based on platform selected
  observe({
    
    shinyWidgets::updatePickerInput(session, "l1",
                      choices = unique(names(x1())),
                      selected=names(x1())[1:5],
                      options = shinyWidgets::pickerOptions(
                        actionsBox = TRUE,
                        title = "Please select Columns to Display",
                        header = "This is a Listing"
                      ),
                      choicesOpt = list(
                        style = rep(("color: black; background: lightgrey; font-weight: bold;"),1000))
    )

    
    updateSelectInput(session, "filter1",
                      choices = c(names(x1())[names(x1()) %in% c("SAFFL","ITTFL","EFFFL")])
    )
    
    updateSelectInput(session, "filter2",
                      choices = c(names(x2())[names(x2()) %in% c("SAFFL","ITTFL","EFFFL")])
    )
    updateSelectInput(session, "filter3",
                      choices = c(names(x3())[names(x3()) %in% c("SAFFL","ITTFL","EFFFL")])
    )
    
    
    updateSelectInput(session, "t1",
                      choices = c(names(x2())[!names(x2()) %in% c("TRTA","TRTP","TRTAN","TRTPN","SAFFL","ITTFL","EFFFL","STUDYID","USUBJID","SUBJID", "SITEID", "SITEGR1","ARM","TRT01P", "TRT01PN","TRT01A", "TRT01AN","TRTSDT", "TRTEDT", "TRTDURD","AVGDD")])
    )
    
    updateSelectInput(session, "t2",
                      choices = c(names(x2())[!names(x2()) %in% c("TRTA","TRTP","TRTAN","TRTPN","SAFFL","ITTFL","EFFFL","STUDYID","USUBJID","SUBJID", "SITEID", "SITEGR1","ARM","TRT01P", "TRT01PN","TRT01A", "TRT01AN","TRTSDT", "TRTEDT", "TRTDURD","AVGDD")])
    )
    
    updateSelectInput(session, "f1",
                      choices = unique(x3()$PARAM)
    )
    
    updateSelectInput(session, "xaxis",
                      choices = c(names(x3())[!names(x3()) %in% c("TRTA","TRTP","TRTAN","TRTPN","SAFFL","ITTFL","EFFFL","STUDYID","USUBJID","SUBJID", "SITEID", "SITEGR1","ARM","TRT01P", "TRT01PN","TRT01A", "TRT01AN","TRTSDT", "TRTEDT", "TRTDURD","AVGDD","RACE","RACEN")])
    )
    
    updateSelectInput(session, "yaxis",
                      choices = c(names(x3() %>% dplyr::select(where(is.numeric)))) 
                       
    )
    
    
  })
  
  
  summ <- reactive({
    req(x2())
    
    
      x2() %>% filter(.data[[input$filter2]]=="Y") %>% 
        # bind_rows(x2() %>% filter(.data[[input$filter2]]=="Y") %>% mutate(AEDECOD = "Any") ) %>% 
        # bind_rows(x2() %>% filter(.data[[input$filter2]]=="Y") %>% mutate(AESOC = "Any", AEDECOD = "Any") ) %>% 
        group_by(.data[[trt_vart()]],.data[[input$t1]],.data[[input$t2]]) %>% 
        rename(TRT01A=.data[[trt_vart()]]) %>% 
        summarise(cnt=n_distinct(USUBJID)) %>% 
        left_join(tot,by=c("TRT01A")) %>% 
        mutate(per = paste0(as.character(cnt)," (",as.character(round((cnt/tot)*100)) ,"%)"),
               lab=paste0(TRT01A," (N=",tot,")")) %>% 
        pivot_wider(
          id_cols = c(.data[[input$t1]], .data[[input$t2]]),
          names_from = lab,
          values_from = per
        ) %>%
        replace(is.na(.), "0") %>% 
        arrange(.data[[input$t1]],.data[[input$t2]])
      
    
  })
  
  
  fig <- reactive({
    
  if (grepl("Bar",input$f4)){  
    x3()  %>% filter(.data[[input$filter3]]=="Y") %>% filter(PARAM==input$f1) %>% 
      plot_ly(x=~.data[[input$xaxis]],y = ~.data[[input$yaxis]], color = ~.data[[trt_varf()]], type = "bar") %>% 
      layout(title=paste0("Bar Chart for ",input$f1),xaxis=list(title=input$xaxis),yaxis=list(title=input$yaxis) )
    
  }
    
 else if (grepl("Box",input$f4)){  
      x3()  %>% filter(.data[[input$filter3]]=="Y") %>% filter(PARAM==input$f1) %>% 
        plot_ly(x=~.data[[input$xaxis]],y = ~.data[[input$yaxis]], color = ~.data[[trt_varf()]], type = "box") %>% 
     layout(title=paste0("Box Plot for ",input$f1),xaxis=list(title=input$xaxis),yaxis=list(title=input$yaxis) )
 }  
    
    else if (grepl("Scatter",input$f4)){  
       x3()  %>% filter(.data[[input$filter3]]=="Y") %>% filter(PARAM==input$f1) %>% 
      plot_ly(x = ~.data[[input$xaxis]], y = ~.data[[input$yaxis]], type = 'scatter', mode = 'scatter',color=~USUBJID)  %>% 
        layout(title=paste0("Line & Scatter Plot for ",input$f1),xaxis=list(title=input$xaxis),yaxis=list(title=input$yaxis) )
    }
  })
  
  
  observeEvent(input$lb1, {
      output$listingo <- renderDataTable({
        x1()  %>% filter(.data[[input$filter1]]=="Y") %>% select(one_of(input$l1)) %>% 
          datatable(filter = 'top',  extensions = 'Buttons',options = list(
            scrollX = TRUE,
            pageLength = 25, autoWidth = TRUE,
            dom = 'Bfrtip',
            buttons = c('copy', 'csv', 'excel','pdf')
          ))
      })
    })

  observeEvent(input$tb1, {
    
    output$tableo <- renderDataTable({
      summ()  %>% 
        datatable(filter = 'top', extensions = 'Buttons', options = list(
          scrollX = TRUE,
          pageLength = 25, autoWidth = TRUE,
          dom = 'Bfrtip',
          buttons = c('copy', 'csv', 'excel','pdf')
        ))
    })
  })
  
  observeEvent(input$fb1, {
    output$figureo <- renderPlotly({
        
     fig()
      
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
  
  observeEvent(input$reset, {
    hide("listing")
    hide("table")
    hide("figure")
  })
  
})
