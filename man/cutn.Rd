\name{cutn}
\alias{cutn}
\title{ Convert numeric to factor, using bins of equal cardinality }
\description{ This is similar to cut, except that the breakpoints are chosen such that each bin contains roughly the same number of samples.}
\usage{
cutn(x, n = 2, right = TRUE, ...)
}
\arguments{
  \item{x}{ A numeric vector. }
  \item{n}{ Integer, the (maximum) number of bins. The actual number of bins is limited by the number of unique values in x.}
  \item{right}{ see \code{\link{cut}} }
  \item{\dots}{ Further arguments passed to \code{\link{cut}}; e.g. "labels", "include.lowest". }
}
\details{ 
Some effort is made to return sensible values, even with repeated values that make completely evenly-sized bins impossible.

Missing values are silently ignored. 
}
\value{ A factor of the same length as \code{x}. }
\seealso{ \code{\link{cut}} }
\examples{ 
  table(cutn(1:100, n = 3))

  ## a practical demonstration:
  ## divide a cohort into two equally-sized strata according to age

  attach(ovarian)
  s <- Surv(futime, fustat)
  
  surviplot(s ~ cutn(age))

  surviplot(s ~ cutn(age, n = 3), stitle = 'Age (years)')

}
\keyword{ misc }
