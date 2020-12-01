# Define server logic
server <- function(input, output) {
  load("~/GitHub/PdM/data/train_data.rda")
  output$mytable = DT::renderDataTable({
    train_data
  }, options = list(scrollX = TRUE),
  caption = "You imported the following data set")
}
