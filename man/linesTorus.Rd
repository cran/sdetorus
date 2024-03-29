% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/auxiliary.R
\name{linesTorus}
\alias{linesTorus}
\title{Lines and arrows with wrapping in the torus}
\usage{
linesTorus(x, y, col = 1, lty = 1, ltyCross = lty, arrows = FALSE, ...)
}
\arguments{
\item{x}{vector with horizontal coordinates, wrapped in \eqn{[-\pi,\pi)}.}

\item{y}{vector with vertical coordinates, wrapped in \eqn{[-\pi,\pi)}.}

\item{col}{color vector of length \code{1} or the same length of \code{x} and
\code{y}.}

\item{lty}{line type as in \code{\link[graphics]{par}}.}

\item{ltyCross}{specific line type for crossing segments.}

\item{arrows}{flag for drawing arrows instead of line segments.}

\item{...}{further graphical parameters passed to
\code{\link[graphics]{segments}} or \code{\link[graphics]{arrows}}.}
}
\value{
Nothing. The functions are called for drawing wrapped lines.
}
\description{
Joins the corresponding points with line segments or arrows that
exhibit wrapping in \eqn{[-\pi,\pi)} in the horizontal and vertical axes.
}
\details{
\code{x} and \code{y} are wrapped to \eqn{[-\pi,\pi)} before
plotting.
}
\examples{
x <- toPiInt(rnorm(50, mean = seq(-pi, pi, l = 50), sd = 0.5))
y <- toPiInt(x + rnorm(50, mean = seq(-pi, pi, l = 50), sd = 0.5))
plot(x, y, xlim = c(-pi, pi), ylim = c(-pi, pi), col = rainbow(length(x)),
     pch = 19)
linesTorus(x = x, y = y, col = rainbow(length(x)), ltyCross = 2)
plot(x, y, xlim = c(-pi, pi), ylim = c(-pi, pi), col = rainbow(length(x)),
     pch = 19)
linesTorus(x = x, y = y, col = rainbow(length(x)), arrows = TRUE)
}
