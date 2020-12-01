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
create_model <- function(formula, df, method, metric, allowParallel=FALSE,...){

  m_list <- list()
  for (i in 1: length(method)) {
    m_list[[i]] <- train(formula, data=df, method= method[i], metric = metric, allowParallel=allowParallel,...)
  }
  #names(m_list) <- method
  results <- resamples(m_list)
  a <- summary(results)
  b <- dotplot(results)
  return(list(a,b))
}



