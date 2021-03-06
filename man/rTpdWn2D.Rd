% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{rTpdWn2D}
\alias{rTpdWn2D}
\title{Simulation from the approximated transition distribution of a WN diffusion in 2D}
\usage{
rTpdWn2D(n, x0, t, mu, alpha, sigma, rho = 0, maxK = 2L, expTrc = 30)
}
\arguments{
\item{n}{sample size.}

\item{x0}{a matrix of dimension \code{c(nx0, 2)} giving the starting values.}

\item{t}{vector of length \code{nx0} containing the times between observations.}

\item{mu}{a vector of length \code{2} giving the mean.}

\item{alpha}{vector of length \code{3} parametrizing the \code{A} matrix as in \code{\link{alphaToA}}.}

\item{sigma}{vector of length \code{2} containing the \strong{square root} of the diagonal of \eqn{\Sigma}, the diffusion matrix.}

\item{rho}{correlation coefficient of \eqn{\Sigma}.}

\item{maxK}{maximum absolute value of the windings considered in the computation of the WN.}

\item{expTrc}{truncation for exponential: \code{exp(x)} with \code{x <= -expTrc} is set to zero. Defaults to \code{30}.}
}
\value{
An array of dimension \code{c(n, 2, nx0)} containing the \code{n} samples of the transition distribution,
conditioned on that the process was at \code{x0} at \code{t} instants ago. The samples are all in \eqn{[\pi,\pi)}.
}
\description{
Simulates from the approximate transition density of the WN diffusion in 2D.
}
\examples{
alpha <- c(3, 2, -1)
sigma <- c(0.5, 1)
mu <- c(pi, pi)
x <- seq(-pi, pi, l = 100)
t <- 0.5
image(x, x, matrix(dTpdWou2D(x = as.matrix(expand.grid(x, x)),
                            x0 = matrix(rep(0, 100 * 2),
                                        nrow = 100 * 100, ncol = 2),
                            t = t, mu = mu, alpha = alpha, sigma = sigma,
                            maxK = 2, expTrc = 30), nrow = 100, ncol = 100),
      zlim = c(0, 0.5))
points(rTpdWn2D(n = 500, x0 = rbind(c(0, 0)), t = t, mu = mu, alpha = alpha,
                sigma = sigma)[, , 1], col = 3)
points(stepAheadWn2D(x0 = rbind(c(0, 0)), delta = t / 500,
                     A = alphaToA(alpha = alpha, sigma = sigma),
                     mu = mu, sigma = sigma, N = 500, M = 500, maxK = 2,
                     expTrc = 30), col = 4)
}
