\name{invert}
\alias{invert}
\title{ Invert the censoring status of a Surv object }
\description{ Invert the censoring status of a Surv object }
\usage{
invert(x)
}
\arguments{
  \item{x}{ A \code{\link{Surv}} object. }
}
\details{ For each item, the "status" is reversed, so alive becomes dead, and dead becomes alive.

This may be useful to check for bias in censoring.
}
\value{ A \code{\link{Surv}} object. }
\examples{  

  surv <- Surv(colon$time / 365, colon$status)

  ## normal survival plot
  surviplot(surv ~ sex, data = colon,
    xlab = 'Time (years)', ylab = 'Fraction surviving')

  ## Censoring rate plot
  surviplot(invert(surv) ~ sex, data = colon,
    xlab = 'Time (years)', ylab = 'Fraction not censored')

}
\keyword{ survival }
