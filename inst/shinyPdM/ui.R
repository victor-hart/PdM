library(shiny)
library(shiny)
library(shinythemes)
library(ggplot2)
library(caret)
library(DT)

# Define UI for PdM app
ui <- tagList(
  fluidPage(theme = shinytheme("cerulean"),

  # App title ----
  titlePanel("PdM: A framework for predictive maintenance in industry 4.0 concept"),
  # App navbar ----
  navbarPage("PdM",
    # Load data from different sources (local csv file, SQL,..) ---
    tabPanel("Data Import", icon = icon("folder-open"),
             br(),
             fluidRow(column(3,
                             wellPanel(
                               h4(strong("Data Import")),
                               selectInput("source", label="Select Data Source",
                                           choices = list("MySQL" = "mysql",
                                                          "Local file" = "local",
                                                          "Source 3" = "Source 3"
                                           ),
                                           multiple=F),
                               textInput("host", "Host", "localhost"),
                               textInput("dbname", "Database Name", "rmysql"),
                               textInput("user", "User", "root"),
                               textInput("password", "Password", ""),
                               textInput("table", "Table Name", "train_data")

                             )),
                      column(9,
                             DT::dataTableOutput("mytable")
                      )

             )),
    # Data Exploration --- (summary, visualization)
    navbarMenu("Data Exploration", icon = icon("magic"),
               tabPanel("Descriptive Statistics",
                        icon = icon("list-alt")),
               tabPanel("Data Visualization",
                        icon = icon("bar-chart"))),
    # Data Preprocessing ---
    tabPanel("Preprocessing", icon = icon("graduation-cap")),
    tabPanel("Setting", icon = icon("cog")),
    tabPanel("Models", icon = icon("folder-open")),
    navbarMenu("Train and Tuning", icon = icon("wrench"),
               tabPanel("Train",
                        icon = icon("graduation-cap")),
               tabPanel("Tuning",
                        icon = icon("cog"))),
    tabPanel("Predict", icon = icon("flag")),
    tabPanel(title = "Github", icon = icon("github", "fa-lg"),
             value = "https://github.com/forvis/PdM")

 )
),

# App footer ----
tags$footer("© 2019 Cuong Sai, Maxim Shcherbakov (Volgograd State Technical University)", align = "left", style = "
              position:absolute;
              bottom:0;
              width:100%;
              height:50px;   /* Height of the footer */
              color: white;
              padding: 10px;
              background-color: #FF6600;
              z-index: 1000;")

)


