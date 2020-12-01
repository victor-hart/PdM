
# Only the last cycle of each test engine is selected for prediction
prepare_test <- function(df) {
  X_out <- df %>% group_by(id) %>% mutate(max = max(timestamp)) %>% ungroup
  X_out$max = NULL
  test_df <- X_out
  max_cycle <- plyr::ddply(test_df, "id", plyr::summarise, timestamp = max(timestamp))
  data <- plyr::join(max_cycle, test_df, by = c("id", "timestamp"))
  return(data)
}
