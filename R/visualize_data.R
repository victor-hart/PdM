#' Training and Test data Visualization for predictive maintenance
#'
#' The function for plotting of ggplot objects. For more details about the
#' graphical parameter arguments, use \code{?visualize_data}
#'
#' @aliases visualize_data
#' @param df dataframe containing multiple multivariate time series formatted using
#' the specific Table Schema, use \code{showDF()} to display schema specification details.
#' @param id_engine id for the input data to be shown.
#' @param cols for the variable names of the input data to be shown.
#' @param type what type of plot should be drawn. Possible types are:
#' \describe{
#'   \item{l:}{for line graphs}
#'   \item{p:}{for point graphs (scatter plots)}
#'   \item{b:}{for both line and point graphs}
#'   \item{bp:}{for box plots}
#'   \item{h:}{for histogram}
#'   \item{hf:}{for histograms of the healthy vs failing sensor Values}
#' }
#' @return a ggplot object containing the subgraphs of each variable from the input data.
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#' @seealso \code{\link{showDF}}, \code{\link{validate_data}},\code{\link{summarize_data}}
#'
#' @keywords data visualization
#'
#' @examples
#' visualize_data(train_data, id_engine = 1:10, type = "l")
#' visualize_data(train_data, id_engine = 1:10, cols = c("s1", "s2", "S8", "c2"), type = "p")
#' visualize_data(train_data, id_engine = 1:20, type = "bp")
#' visualize_data(train_data, id_engine = 1:100, type = "h")
#' visualize_data(train_data, id_engine = 1:100, type = "hp", n_step = 30)
#'
#' @export

visualize_data <- function(df, id_engine, cols = NULL, type = "l", n_step = 20) {

  if (!validate_data(df)) {
    stop("Check the column names of input data frame. The input data needed in the form of
         a data frame containing columns named 'id', 'timestamp', starts_with 's' for sensors or 'c' for conditions.")
  }

  # subset data
  df <- df %>% dplyr::filter(id %in% id_engine)
  df$id <- factor(df$id)

  if (!is.null(cols)) {
    df_origin <- df %>% dplyr::select(id, timestamp)
    df_trans <- df %>% dplyr::select(cols)
    df <- dplyr::bind_cols(df_origin, df_trans)
  }

  # Create ggplot
  if (type %in% c("l", "p", "b")){
    df <- df %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp)
    df$s <- factor(df$s, levels=unique(as.character(df$s)))
    p <- ggplot2::ggplot(data = df, mapping = ggplot2::aes(x = timestamp, y = measurement, color = id))
  }

  if (type == "h"){
    df <- df %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp)
    df$s <- factor(df$s, levels=unique(as.character(df$s)))
    p <- ggplot2::ggplot(data = df, ggplot2::aes(x =  measurement, fill = s)) +
      ggplot2::geom_histogram() +
      ggplot2::facet_wrap(~ s, scales = "free", ncol = 4) +
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }


  if (type == "bp"){
    df <- df %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp)
    df$s <- factor(df$s, levels=unique(as.character(df$s)))
    p <- ggplot2::ggplot(data = df, ggplot2::aes(x = timestamp, y = measurement, color = s)) +
      ggplot2::geom_boxplot() +
      ggplot2::facet_wrap(~ s, scales = "free", ncol = 4) +
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }

 if (type == "hf"){
   # prepare data
    df1 <- df %>%  group_by(id) %>% filter(timestamp <= n_step) %>% ungroup
    df1$class <- "healthy"
    df1 <- df1 %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp, -class)
    df2 <- df %>% group_by(id) %>% filter(timestamp > (max(timestamp) - n_step)) %>% ungroup
    df2$class <- "failing"
    df2 <- df2 %>% tidyr::gather(key = "s", value = measurement, -id, -timestamp, -class)
    df3 <- dplyr::bind_rows(df1, df2)
    df3$s <- factor(df3$s, levels=unique(as.character(df3$s)))
    #df3 <- dplyr::filter(df3, s == "s3")
    p <- ggplot2:: ggplot(df3, mapping = ggplot2::aes(x=measurement, fill = class, color = class)) +
      ggplot2::geom_histogram(alpha=0.4, bins = 30) +
      viridis::scale_color_viridis(discrete = TRUE)+
      ggplot2::facet_wrap(~ s, scales = "free", ncol = 4) +
      ggplot2::ggtitle("Healthy vs Failing Sensor Values")+
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }

  # Line plot
  if (type == "l") {
    p <- p + ggplot2::geom_line() +
      ggplot2::geom_smooth(se = FALSE)+
      ggplot2::facet_wrap(~ s, ncol = 4, scales = "free_y") +
      viridis::scale_color_viridis(discrete = TRUE)+
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::labs(x = "Time", y = "Measurements") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }
  # for points
  if (type == "p"){
  p <- p + ggplot2::geom_point() +
      ggplot2::facet_wrap(~ s, ncol = 3, scales = "free_y") +
      viridis::scale_color_viridis(discrete = TRUE) +
      ggplot2::ggtitle("Sensor Traces") +
      ggplot2::labs(x = "Time", y = "Measurements") +
      ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
  }

 if (type == "b"){
   p <- p + ggplot2::geom_line() +
     ggplot2::geom_point()+
     ggplot2::geom_smooth(se = FALSE)+
     ggplot2::facet_wrap(~ s, ncol = 3, scales = "free_y") +
     viridis::scale_color_viridis(discrete = TRUE)+
     ggplot2::ggtitle("Sensor Traces") +
     ggplot2::labs(x = "Time", y = "Measurements") +
     ggplot2::theme(plot.title = ggplot2::element_text(hjust = 0.5))
 }

return(p)
}
