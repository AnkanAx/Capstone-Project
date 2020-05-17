library(shiny)
shinyUI(fluidPage(
        titlePanel(column(8,"Text Prediction - Capstone Project", align = "left")),
        br(),
        br(),
        br(),
        fluidRow(column(6,p("This application predicts the next word you will write using a library of word sequences. 
                         To make a prediction just enter a sequence of words in the dialog box and then press \"Predict\".
                         Then wait for the top 3 predicted words to show up under \"Predicted words\"."), style ="color:blue", align = "left")),
        br(),
        br(),
        
        sidebarLayout(
            sidebarPanel(
                textInput("sentence", "Enter a sentence", value = ""),
                actionButton("do", "Predict")
            ),
            mainPanel(h4
                ("Predicted words:"), 
                fluidRow(column(5, verbatimTextOutput("out1", placeholder = TRUE))),
                fluidRow(column(5, verbatimTextOutput("out2", placeholder = TRUE))),
                fluidRow(column(5, verbatimTextOutput("out3", placeholder = TRUE)))
                                )
            )
        )
)

    