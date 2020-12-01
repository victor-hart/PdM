#' RUL visualization
#'
#' Generates data_visualization
#'
#' @aliases data_visualization
#' @param df data
#' @param id_engine indentificator
#' @param cols specisly cols
#' @return a list with the following variables
#'
#' @details load input data
#'
#'
#'
#' @author Cuong Sai and Maxim Shcherbakov.
#'
#' @keywords data
#'
#' @export

visualize_RUL <- function(df, id_engine, type = "bar") {
    df <- df %>% filter(id %in% id_engine)
    df$id <- as.factor(df$id)
    # Plot
    p <- ggplot2::ggplot(df, ggplot2::aes(x = id, y =  RUL, fill = id))
    p <- p + ggplot2::geom_bar(stat="identity")
    # ggplot2::geom_line() +
    # ggplot2::geom_smooth(se = FALSE) +
    # viridis::scale_color_viridis(discrete = TRUE) +
    # ggplot2::facet_wrap(~ s, ncol = 3, scales = "free_y")+
    # ggplot2::ggtitle("Sensor Traces") +
    # ggplot2::xlab("Time (Cycles)") +
    # ggplot2::ylab("Measurements") +
    # ggplot2::theme(plot.title = element_text(hjust = 0.5))

    if (type == "h") {
    RUL <- df %>% select(id, timestamp, RUL) %>% group_by(id) %>%
      summarize(rul = RUL[1])
    nbins = nclass.FD(RUL$rul)

    p <- ggplot2:: ggplot(RUL, aes(x = rul, y = ..density..)) +
      geom_histogram(col = "red", fill = "green", alpha = 0.2, bins = nbins) +
      geom_density(col = "red", size = 1)+
      ggtitle("Distribution of RUL")+
      theme(plot.title = element_text(hjust = 0.5))
    }

  print(p)
}
