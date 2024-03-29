% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auxiliary.R
\name{plotSurface2D}
\alias{plotSurface2D}
\title{Contour plot of a 2D surface}
\usage{
plotSurface2D(x = seq_len(nrow(z)), y = seq_len(ncol(z)), f, z = NULL,
  nLev = 20, levels = NULL, fVect = FALSE, ...)
}
\arguments{
\item{x, y}{numerical grids fore each dimension. They must be in ascending
order.}

\item{f}{function to be plot. Must take a single argument (see examples).}

\item{z}{a vector of length \code{length(x) * length(y)} containing the
evaluation of \code{f} in the bivariate grid. If not provided, it is
computed internally.}

\item{nLev}{the number of levels the range of \code{z} will be divided into.}

\item{levels}{vector of contour levels. If not provided, it is set to
\code{quantile(z, probs = seq(0, 1, l = nLev))}.}

\item{fVect}{flag to indicate whether \code{f} is a vectorized function
(see examples).}

\item{...}{further arguments passed to \code{\link[graphics]{image}}}
}
\value{
The matrix \code{z}, invisible.
}
\description{
Convenient wrapper for plotting a contour plot of a real
function of two variables.
}
\examples{
\donttest{
grid <- seq(-pi, pi, l = 100)
plotSurface2D(grid, grid, f = function(x) sin(x[1]) * cos(x[2]), nLev = 20)
plotSurface2D(grid, grid, f = function(x) sin(x[, 1]) * cos(x[, 2]),
              levels = seq(-1, 1, l = 10), fVect = TRUE)
}
}
\keyword{internal}
