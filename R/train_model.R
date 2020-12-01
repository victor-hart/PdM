# define training control
# trainControl <- trainControl(method="cv", number=10, repeats = 3)
# evaluate the model
# fit <- train(Species~., data=iris, trControl=trainControl, method="nb")
# display the results
# evaluate the model
# fit <- train(Species~., data=iris, trControl=trainControl, method="nb")
# display the results
# print(fit)
#' @export
#'
train_model <- function(formula, df, method, metric="RMSE", allowParallel=FALSE,...){

  model_list <- list()
  for (i in method) {
    model_list[[i]] <-  train(formula, data=df, method = i, metric = metric, allowParallel=allowParallel,...)
  }
  return(model_list)
}



