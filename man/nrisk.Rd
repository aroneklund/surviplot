\name{nrisk}
\alias{nrisk}
\title{ Get number-at-risk from a survfit object }
\description{ Retrieve the number-at-risk from a survfit object for the specified times, for each strata. }
\usage{
nrisk(x, times = pretty(x$time))
}
\arguments{
  \item{x}{ An object of type \code{\link[survival]{survfit}}. }
  \item{times}{ The timepoints of interest. }
}
\value{ A matrix indicating the number-at-risk for each timepoint (columns) and stratum (rows). }
\seealso{ \code{\link{surviplot}} }
\examples{  

data(colon)
surv <- Surv(colon$time, colon$status)

## example with stratification
nrisk(survfit(surv ~ colon$rx))

## example without stratification
nrisk(survfit(surv ~ 1))

}
\keyword{ survival }
