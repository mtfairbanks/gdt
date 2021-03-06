#' Build a data.table/tidytable
#'
#' @description
#' `tidytable()` constructs a data.table, but one with nice printing features.
#' As such it can be used exactly like a data.table would be used.
#'
#' @param ... Arguments passed to `data.table()`
#'
#' @md
#' @export
#'
#' @examples
#' tidytable(x = 1:3, y = c("a", "a", "b"))
tidytable <- function(...) {

  dots <- enquos(...)

  mask <- build_data_mask(dots)

  dt_expr <- dt_call2("data.table", !!!dots)

  .df <- eval_tidy(dt_expr, mask, caller_env())

  as_tidytable(.df)
}
