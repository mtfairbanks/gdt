#' Aggregate data using summary statistics
#'
#' @description
#' Aggregate data using summary statistics such as mean or median. Can be calculated by group.
#'
#' @param .data A data.frame or data.table
#' @param ... Aggregations to perform
#' @param by Optional: `list()` of bare column names to group by
#'
#' @export
#'
#' @examples
#' example_dt <- data.table::data.table(
#'   a = c(1,2,3),
#'   b = c(4,5,6),
#'   c = c("a","a","b"),
#'   d = c("a","a","b"))
#'
#' dt_summarize(avg_a = mean(a),
#'              max_b = max(b),
#'              by = c)
#'
#' dt_summarize(avg_a = mean(a),
#'              by = list(c, d))
dt_summarize <- function(.data, ..., by = NULL) {
  if (!is.data.frame(.data)) stop(".data must be a data.frame or data.table")
  if (!is.data.table(.data)) .data <- as.data.table(.data)

  dots <- enexprs(...)
  by <- enexpr(by)

  eval_tidy(expr(
    .data[, list(!!!dots), !!by]
  ))
}

#' @export
#' @rdname dt_summarize
dt_summarise <- dt_summarize