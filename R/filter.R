#' Filter rows on one or more conditions
#'
#' @description
#' Filters a dataset to choose rows where conditions are true.
#'
#' @param .df A data.frame or data.table
#' @param ... Conditions to filter by
#' @param .by Columns to group by if filtering with a summary function
#'
#' @export
#'
#' @examples
#' test_df <- tidytable(
#'   a = 1:3,
#'   b = 4:6,
#'   c = c("a","a","b")
#' )
#'
#' test_df %>%
#'   filter.(a >= 2, b >= 4)
#'
#' test_df %>%
#'   filter.(b <= mean(b), .by = c)
filter. <- function(.df, ..., .by = NULL) {
  UseMethod("filter.")
}

#' @export
filter..data.frame <- function(.df, ..., .by = NULL) {

  .df <- as_tidytable(.df)

  .by <- enquo(.by)

  dots <- enquos(...)

  mask <- build_data_mask(dots)

  i <- expr(Reduce('&', list(!!!dots)))

  if (quo_is_null(.by)) {
    dt_expr <- dt_call_i(.df, i)

    .df <- eval_tidy(dt_expr, mask, caller_env())
  } else {
    .by <- select_vec_chr(.df, !!.by)

    col_order <- names(.df)

    dt_expr <- dt_call_i(.df, i, .by)

    .df <- eval_tidy(dt_expr, mask, caller_env())

    setcolorder(.df, col_order)
  }

  .df
}
