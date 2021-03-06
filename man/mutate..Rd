% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mutate.R
\name{mutate.}
\alias{mutate.}
\title{Add/modify/delete columns}
\usage{
mutate.(.df, ..., .by = NULL)
}
\arguments{
\item{.df}{A data.frame or data.table}

\item{...}{Columns to add/modify}

\item{.by}{Columns to group by}
}
\description{
With \code{mutate.()} you can do 3 things:
\itemize{
\item Add new columns
\item Modify existing columns
\item Delete columns
}
}
\examples{
test_df <- data.table(
  a = c(1,2,3),
  b = c(4,5,6),
  c = c("a","a","b")
)

test_df \%>\%
  mutate.(double_a = a * 2,
          a_plus_b = a + b)

test_df \%>\%
  mutate.(double_a = a * 2,
          avg_a = mean(a),
          .by = c)
}
