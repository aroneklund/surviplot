\name{censor}
\alias{censor}
\title{ Censor survival data at a specified time }
\description{ Censor survival data at a specified time }
\usage{
censor(x, at)
}
\arguments{
  \item{x}{ An object of class \code{\link[survival]{Surv}}. }
  \item{at}{ Numeric, the time point at which to censor. }
}
\details{ Any samples with survival times beyond \code{at} are modified such that time = \code{at} and status = 0. }
\value{ An object of class \code{\link[survival]{Surv}}. }
\note{ This function works only on right-censored survival data. }
\examples{  
  s <- with(aml, Surv(time, status))
 
  ## Plot the original data 
  surviplot(s ~ x, data = aml)

  ## Artificially censor at time = 50
  surviplot(censor(s, 50) ~ x, data = aml)

}
\keyword{ survival }
