\name{cutn}
\alias{cutn}
\title{ Convert numeric to factor, using bins of equal cardinality }
\description{ This is similar to cut, except that the breakpoints are chosen such that each bin contains roughly the same number of samples.}
\usage{
cutn(x, n = 2, ...)
}
\arguments{
  \item{x}{ A numeric vector. }
  \item{n}{ Integer, the number of bins. }
  \item{\dots}{ Further arguments passed to \code{\link{cut}}; e.g. "labels". }
}
\details{ Missing values are silently ignored. }
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
