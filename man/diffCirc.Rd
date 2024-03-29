% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auxiliary.R
\name{diffCirc}
\alias{diffCirc}
\title{Lagged differences for circular time series}
\usage{
diffCirc(x, circular = TRUE, ...)
}
\arguments{
\item{x}{wrapped or unwrapped angles to be differenced. Must be a vector
or a matrix, see details.}

\item{circular}{convenience flag to indicate whether wrapping should be
done. If \code{FALSE}, the function is exactly \code{\link{diff}}.}

\item{...}{parameters to be passed to \code{\link{diff}}.}
}
\value{
The value of \code{diff(x, ...)}, circularly wrapped. Default
parameters give an object of the kind of \code{x} with one less entry or row.
}
\description{
Returns suitably lagged and iterated circular differences.
}
\details{
If \code{x} is a matrix then the difference operations are carried
out row-wise, on each column separately.
}
\examples{
# Vectors
x <- c(-pi, -pi/2, pi - 0.1, -pi + 0.2)
diffCirc(x) - diff(x)

# Matrices
set.seed(234567)
N <- 100
x <- t(euler2D(x0 = rbind(c(0, 0)), A = diag(c(1, 1)), sigma = rep(2, 2),
               mu = c(pi, pi), N = N, delta = 1, type = 2)[1, , ])
diffCirc(x) - diff(x)
}
