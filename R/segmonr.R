# Load required packages
#' @import ggplot2
#' @import dplyr
#' @import scales
#' @importFrom dplyr row_number
#' @importFrom ggplot2 aes

#' Create a segmented motion pie chart
#'
#' @param data A data frame containing at least two columns: `text` (labels for segments) and `value` (numerical values for segments).
#' @param color An optional vector of colors for the segments. If NULL, colors will be auto-generated.
#'
#' @return A ggplot object representing the segmented radial plot.
#' @export
#'
#' @examples
#' data <- data.frame(
#'   text = c("A", "B", "C", "D"),
#'   value = c(25, 35, 20, 20),
#'   color = c("#FF0000", "#00FF00", "#0000FF", "#FFFF00")
#' )
#' segmonr(data)

utils::globalVariables(c("|>", "value", "proportion", "start",
                         "inner_radius", "x", "y", "text", "outer_radius",
                         "end", "percentage"))

segmonr <- function(data, color = NULL) {
  # Ensure the required columns are in the data
  required_columns <- c("text", "value")
  missing_columns <- setdiff(required_columns, names(data))
  if (length(missing_columns) > 0) {
    stop(paste("The following columns are required in the data:", paste(missing_columns, collapse = ", ")))
  }

  # Assign colors if not provided
  if (is.null(color)) {
    if ("color" %in% names(data)) {
      color <- data$color
    } else {
      color <- scales::hue_pal()(nrow(data))
    }
  }

  data <- data |>
    dplyr::mutate(
      proportion = value / sum(value),
      percentage = round(proportion * 100, 1),
      start = 90,
      end = 90 - cumsum(proportion) * 360 + 15,
      inner_radius = dplyr::row_number(),  # Lebih ringkas menggunakan row_number()
      outer_radius = inner_radius + 1
    )

  # Function to create arc coordinates
  createarc <- function(start, end, inner_radius, outer_radius, n = 100) {
    angles_outer <- seq(start, end, length.out = n) * pi / 180
    angles_inner <- seq(end, start, length.out = n) * pi / 180
    data.frame(
      x = c(outer_radius * cos(angles_outer), inner_radius * cos(angles_inner)),
      y = c(outer_radius * sin(angles_outer), inner_radius * sin(angles_inner))
    )
  }

  # Create arc data for each segment
  arcdata <- dplyr::bind_rows(
    lapply(1:nrow(data), function(i) {
      createarc(data$start[i], data$end[i], data$inner_radius[i], data$outer_radius[i]) |>
        dplyr::mutate(text = data$text[i], color = color[i])
    })
  )

  # Build the plot
  ggplot2::ggplot() +
    ggplot2::geom_polygon(data = arcdata, aes(x = x, y = y, group = text, fill = I(color)),
                          color = "white", linewidth = 1) +  # Updated from `size` to `linewidth`
    ggplot2::geom_text(data = data,
                       aes(x = (inner_radius + outer_radius) / 2 * cos(start * pi / 180),
                           y = (inner_radius + outer_radius) / 2 * sin(start * pi / 180),
                           label = text),
                       size = 3, hjust = 1.2, fontface = "bold") +
    ggplot2::geom_text(data = data,
                       aes(x = (inner_radius + outer_radius) / 2 * cos(end * pi / 180),
                           y = (inner_radius + outer_radius) / 2 * sin(end * pi / 180),
                           label = paste0(percentage, "%")),
                       size = 3, hjust = 0.5, fontface = "italic", color = "black") +
    ggplot2::coord_fixed(clip = "off") +
    ggplot2::theme_void()
}
