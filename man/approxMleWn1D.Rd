% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mle.R
\name{approxMleWn1D}
\alias{approxMleWn1D}
\title{Approximate MLE of the WN diffusion in 1D}
\usage{
approxMleWn1D(data, delta, start, alpha = NA, mu = NA, sigma = NA,
  lower = c(0.01, -pi, 0.01), upper = c(25, pi, 25), vmApprox = FALSE,
  maxK = 2, ...)
}
\arguments{
\item{data}{a matrix of dimension \code{c(n, p)}.}

\item{delta}{discretization step.}

\item{start}{starting values, a matrix with \code{p} columns, with each
entry representing a different starting value.}

\item{alpha, mu, sigma}{if their values are provided, the likelihood function
is optimized with respect to the rest of unspecified parameters. The number
of elements in \code{start}, \code{lower} and \code{upper} has to be modified
accordingly (see examples).}

\item{lower, upper}{bound for box constraints as in method \code{"L-BFGS-B"}
of \code{\link[stats]{optim}}.}

\item{vmApprox}{flag to indicate von Mises approximation to wrapped normal.
See\cr \code{\link{momentMatchWnVm}} and \code{\link{scoreMatchWnBvm}}.}

\item{maxK}{maximum absolute winding number used if \code{circular = TRUE}.}

\item{...}{further parameters passed to \code{\link{mleOptimWrapper}}.}
}
\value{
Output from \code{\link{mleOptimWrapper}}.
}
\description{
Approximate Maximum Likelihood Estimation (MLE) for the Wrapped
Normal (WN) in 1D using the wrapped Ornstein--Uhlenbeck diffusion.
}
\details{
See Section 3.3 in García-Portugués et al. (2019) for details.
}
\examples{
alpha <- 0.5
mu <- 0
sigma <- 2
samp <- rTrajWn1D(x0 = 0, alpha = alpha, mu = mu, sigma = sigma, N = 1000,
                    delta = 0.1)
approxMleWn1D(data = samp, delta = 0.1, start = c(alpha, mu, sigma))
approxMleWn1D(data = samp, delta = 0.1, sigma = sigma, start = c(alpha, mu),
                lower = c(0.01, -pi), upper = c(25, pi))
approxMleWn1D(data = samp, delta = 0.1, mu = mu, start = c(alpha, sigma),
                lower = c(0.01, 0.01), upper = c(25, 25))
}
\references{
García-Portugués, E., Sørensen, M., Mardia, K. V. and Hamelryck, T. (2019)
Langevin diffusions on the torus: estimation and applications.
\emph{Statistics and Computing}, 29(2):1--22. \doi{10.1007/s11222-017-9790-2}
}
