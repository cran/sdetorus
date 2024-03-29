# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' @title WN density in 1D
#'
#' @description Computation of the WN density in 1D.
#'
#' @param x a vector of length \code{n} containing angles. They all must be in \eqn{[\pi,\pi)} so that the truncated wrapping by \code{maxK} windings is able to capture periodicity.
#' @param mu mean parameter. Must be in \eqn{[\pi,\pi)}.
#' @param sigma diffusion coefficient.
#' @param maxK maximum absolute value of the windings considered in the computation of the WN.
#' @inheritParams safeSoftMax
#' @param vmApprox whether to use the von Mises approximation to a wrapped normal (\code{1}) or not (\code{0}, default).
#' @param kt concentration for the von Mises, a suitable output from \code{\link{momentMatchWnVm}} (see examples).
#' @param logConstKt the logarithm of the von Mises normalizing constant associated to the concentration \code{kt} (see examples)
#' @return A vector of size \code{n} containing the density evaluated at \code{x}.
#' @examples
#' mu <- 0
#' sigma <- 1
#' dWn1D(x = seq(-pi, pi, l = 10), mu = mu, sigma = sigma, vmApprox = 0)
#'
#' # von Mises approximation
#' kt <- scoreMatchWnVm(sigma2 = sigma^2)
#' dWn1D(x = seq(-pi, pi, l = 10), mu = mu, sigma = sigma, vmApprox = 1, kt = kt,
#'       logConstKt = -log(2 * pi * besselI(x = kt, nu = 0, expon.scaled = TRUE)))
#' @export
dWn1D <- function(x, mu, sigma, maxK = 2L, expTrc = 30, vmApprox = 0L, kt = 0, logConstKt = 0) {
    .Call('_sdetorus_dWn1D', PACKAGE = 'sdetorus', x, mu, sigma, maxK, expTrc, vmApprox, kt, logConstKt)
}

#' @title Approximation of the transition probability density of the WN diffusion in 1D
#'
#' @description Computation of the transition probability density (tpd) for a WN diffusion.
#'
#' @inheritParams dWn1D
#' @param x0 a vector of length \code{n} containing the starting angles. They all must be in \eqn{[\pi,\pi)}.
#' @param t a scalar containing the times separating \code{x} and \code{x0}.
#' @param alpha drift parameter.
#' @param sigma diffusion coefficient.
#' @inheritParams safeSoftMax
#' @return A vector of size \code{n} containing the tpd evaluated at \code{x}.
#' @details See Section 3.3 in García-Portugués et al. (2019) for details. See \code{\link{dTpdWou}} for the general case (less efficient for 2D).
#' @references
#' García-Portugués, E., Sørensen, M., Mardia, K. V. and Hamelryck, T. (2019) Langevin diffusions on the torus: estimation and applications. \emph{Statistics and Computing}, 29(2):1--22. \doi{10.1007/s11222-017-9790-2}
#' @examples
#' t <- 0.5
#' alpha <- 1
#' mu <- 0
#' sigma <- 1
#' x0 <- 0.1
#' dTpdWou1D(x = seq(-pi, pi, l = 10), x0 = rep(x0, 10), t = t, alpha = alpha,
#'           mu = mu, sigma = sigma, vmApprox = 0)
#'
#' # von Mises approximation
#' kt <- scoreMatchWnVm(sigma2 = sigma^2 * (1 - exp(-2 * alpha * t)) / (2 * alpha))
#' dTpdWou1D(x = seq(-pi, pi, l = 10), x0 = rep(x0, 10), t = t, alpha = alpha,
#'           mu = mu, sigma = sigma, vmApprox = 1, kt = kt,
#'           logConstKt = -log(2 * pi * besselI(x = kt, nu = 0,
#'                                              expon.scaled = TRUE)))
#' @export
dTpdWou1D <- function(x, x0, t, alpha, mu, sigma, maxK = 2L, expTrc = 30, vmApprox = 0L, kt = 0, logConstKt = 0) {
    .Call('_sdetorus_dTpdWou1D', PACKAGE = 'sdetorus', x, x0, t, alpha, mu, sigma, maxK, expTrc, vmApprox, kt, logConstKt)
}

#' @title Approximation of the transition probability density of the WN diffusion in 2D
#'
#' @description Computation of the transition probability density (tpd) for a WN diffusion (with diagonal diffusion matrix)
#'
#' @param x a matrix of dimension \code{c(n, 2)} containing angles. They all must be in \eqn{[\pi,\pi)} so that the truncated wrapping by \code{maxK} windings is able to capture periodicity.
#' @param x0 a matrix of dimension \code{c(n, 2)} containing the starting angles. They all must be in \eqn{[\pi,\pi)}. If all \code{x0} are the same, a matrix of dimension \code{c(1, 2)} can be passed for better performance.
#' @param alpha vector of length \code{3} parametrizing the \code{A} matrix as in \code{\link{alphaToA}}.
#' @param mu a vector of length \code{2} giving the mean.
#' @param sigma vector of length \code{2} containing the \strong{square root} of the diagonal of \eqn{\Sigma}, the diffusion matrix.
#' @param rho correlation coefficient of \eqn{\Sigma}.
#' @inheritParams dTpdWou1D
#' @inheritParams safeSoftMax
#' @return A vector of size \code{n} containing the tpd evaluated at \code{x}.
#' @details The function checks for positive definiteness. If violated, it resets \code{A} such that \code{solve(A) \%*\% Sigma} is positive definite.
#' @details See Section 3.3 in García-Portugués et al. (2019) for details. See \code{\link{dTpdWou}} for the general case (less efficient for 1D).
#' @references
#' García-Portugués, E., Sørensen, M., Mardia, K. V. and Hamelryck, T. (2019) Langevin diffusions on the torus: estimation and applications. \emph{Statistics and Computing}, 29(2):1--22. \doi{10.1007/s11222-017-9790-2}
#' @examples
#' set.seed(3455267)
#' alpha <- c(2, 1, -1)
#' sigma <- c(1.5, 2)
#' rho <- 0.9
#' Sigma <- diag(sigma^2)
#' Sigma[1, 2] <- Sigma[2, 1] <- rho * prod(sigma)
#' A <- alphaToA(alpha = alpha, sigma = sigma, rho = rho)
#' solve(A) %*% Sigma
#' mu <- c(pi, 0)
#' x <- t(euler2D(x0 = matrix(c(0, 0), nrow = 1), A = A, mu = mu,
#'                sigma = sigma, N = 500, delta = 0.1)[1, , ])
#' \donttest{
#' sum(sapply(1:49, function(i) log(dTpdWou(x = matrix(x[i + 1, ], ncol = 2),
#'                                          x0 = x[i, ], t = 1.5, A = A,
#'                                          Sigma = Sigma, mu = mu))))
#' }
#' sum(log(dTpdWou2D(x = matrix(x[2:50, ], ncol = 2),
#'                   x0 = matrix(x[1:49, ], ncol = 2), t = 1.5, alpha = alpha,
#'                   mu = mu, sigma = sigma, rho = rho)))
#' \donttest{
#' lgrid <- 56
#' grid <- seq(-pi, pi, l = lgrid + 1)[-(lgrid + 1)]
#' image(grid, grid, matrix(dTpdWou(x = as.matrix(expand.grid(grid, grid)),
#'                                  x0 = c(0, 0), t = 0.5, A = A,
#'                                  Sigma = Sigma, mu = mu),
#'                          nrow = 56, ncol = 56), zlim = c(0, 0.25),
#'       main = "dTpdWou")
#' image(grid, grid, matrix(dTpdWou2D(x = as.matrix(expand.grid(grid, grid)),
#'                                    x0 = matrix(0, nrow = 56^2, ncol = 2),
#'                                    t = 0.5, alpha = alpha, sigma = sigma,
#'                                    mu = mu),
#'                          nrow = 56, ncol = 56), zlim = c(0, 0.25),
#'       main = "dTpdWou2D")
#'
#' x <- seq(-pi, pi, l = 100)
#' t <- 1
#' image(x, x, matrix(dTpdWou2D(x = as.matrix(expand.grid(x, x)),
#'                              x0 = matrix(rep(0, 100 * 2), nrow = 100 * 100,
#'                                          ncol = 2),
#'                              t = t, alpha = alpha, mu = mu, sigma = sigma,
#'                              maxK = 2, expTrc = 30),
#'                              nrow = 100, ncol = 100),
#'       zlim = c(0, 0.25))
#' points(stepAheadWn2D(x0 = rbind(c(0, 0)), delta = t / 500,
#'                      A = alphaToA(alpha = alpha, sigma = sigma), mu = mu,
#'                      sigma = sigma, N = 500, M = 1000, maxK = 2,
#'                      expTrc = 30))
#' }
#' @export
dTpdWou2D <- function(x, x0, t, alpha, mu, sigma, rho = 0, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_dTpdWou2D', PACKAGE = 'sdetorus', x, x0, t, alpha, mu, sigma, rho, maxK, expTrc)
}

#' @title Simulation from the approximated transition distribution of a WN diffusion in 2D
#'
#' @description Simulates from the approximate transition density of the WN diffusion in 2D.
#'
#' @param n sample size.
#' @param x0 a matrix of dimension \code{c(nx0, 2)} giving the starting values.
#' @param t vector of length \code{nx0} containing the times between observations.
#' @inheritParams dTpdWou2D
#' @inheritParams safeSoftMax
#' @return An array of dimension \code{c(n, 2, nx0)} containing the \code{n} samples of the transition distribution,
#' conditioned on that the process was at \code{x0} at \code{t} instants ago. The samples are all in \eqn{[\pi,\pi)}.
#' @examples
#' alpha <- c(3, 2, -1)
#' sigma <- c(0.5, 1)
#' mu <- c(pi, pi)
#' x <- seq(-pi, pi, l = 100)
#' t <- 0.5
#' image(x, x, matrix(dTpdWou2D(x = as.matrix(expand.grid(x, x)),
#'                             x0 = matrix(rep(0, 100 * 2),
#'                                         nrow = 100 * 100, ncol = 2),
#'                             t = t, mu = mu, alpha = alpha, sigma = sigma,
#'                             maxK = 2, expTrc = 30), nrow = 100, ncol = 100),
#'       zlim = c(0, 0.5))
#' points(rTpdWn2D(n = 500, x0 = rbind(c(0, 0)), t = t, mu = mu, alpha = alpha,
#'                 sigma = sigma)[, , 1], col = 3)
#' points(stepAheadWn2D(x0 = rbind(c(0, 0)), delta = t / 500,
#'                      A = alphaToA(alpha = alpha, sigma = sigma),
#'                      mu = mu, sigma = sigma, N = 500, M = 500, maxK = 2,
#'                      expTrc = 30), col = 4)
#' @export
rTpdWn2D <- function(n, x0, t, mu, alpha, sigma, rho = 0, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_rTpdWn2D', PACKAGE = 'sdetorus', n, x0, t, mu, alpha, sigma, rho, maxK, expTrc)
}

#' @title Stationary density of a WN diffusion (with diagonal diffusion matrix) in 2D
#'
#' @description Stationary density of the WN diffusion.
#'
#' @inheritParams dTpdWou2D
#' @inheritParams safeSoftMax
#' @return A vector of size \code{n} containing the stationary density evaluated at \code{x}.
#' @examples
#' set.seed(345567)
#' alpha <- c(2, 1, -1)
#' sigma <- c(1.5, 2)
#' Sigma <- diag(sigma^2)
#' A <- alphaToA(alpha = alpha, sigma = sigma)
#' mu <- c(pi, pi)
#' dStatWn2D(x = toPiInt(matrix(1:20, nrow = 10, ncol = 2)), mu = mu,
#'           alpha = alpha, sigma = sigma)
#' dTpdWou(t = 10, x = toPiInt(matrix(1:20, nrow = 10, ncol = 2)), A = A,
#'          mu = mu, Sigma = Sigma, x0 = mu)
#' xth <- seq(-pi, pi, l = 100)
#' contour(xth, xth, matrix(dStatWn2D(x = as.matrix(expand.grid(xth, xth)),
#'                                    alpha = alpha, sigma = sigma, mu = mu),
#'                          nrow = length(xth), ncol = length(xth)), nlevels = 50)
#' points(rStatWn2D(n = 1000, mu = mu, alpha = alpha, sigma = sigma), col = 2)
#' @export
dStatWn2D <- function(x, alpha, mu, sigma, rho = 0, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_dStatWn2D', PACKAGE = 'sdetorus', x, alpha, mu, sigma, rho, maxK, expTrc)
}

#' @title Simulation from the stationary density of a WN diffusion in 2D
#'
#' @description Simulates from the stationary density of the WN diffusion in 2D.
#'
#' @param n sample size.
#' @inheritParams dTpdWou2D
#' @return A matrix of dimension \code{c(n, 2)} containing the samples from the stationary distribution.
#' @examples
#' set.seed(345567)
#' alpha <- c(2, 1, -1)
#' sigma <- c(1.5, 2)
#' Sigma <- diag(sigma^2)
#' A <- alphaToA(alpha = alpha, sigma = sigma)
#' mu <- c(pi, pi)
#' plot(rStatWn2D(n = 1000, mu = mu, alpha = alpha, sigma = sigma))
#' points(toPiInt(mvtnorm::rmvnorm(n = 1000, mean = mu,
#'                                 sigma = solve(A) %*% Sigma / 2,
#'                                 method = "chol")), col = 2)
#' @export
rStatWn2D <- function(n, mu, alpha, sigma, rho = 0) {
    .Call('_sdetorus_rStatWn2D', PACKAGE = 'sdetorus', n, mu, alpha, sigma, rho)
}

#' @title Safe softmax function for computing weights
#'
#' @description Computes the weights \eqn{w_i = \frac{e^{p_i}}{\sum_{j=1}^k e^{p_j}}} from \eqn{p_i}, \eqn{i=1,\ldots,k}
#' in a safe way to avoid overflows and to truncate automatically to zero low values of \eqn{w_i}.
#'
#' @param logs matrix of logarithms where each row contains a set of \eqn{p_1,\ldots,p_k} to compute the weights from.
#' @param expTrc truncation for exponential: \code{exp(x)} with \code{x <= -expTrc} is set to zero. Defaults to \code{30}.
#' @return A matrix of the size as \code{logs} containing the weights for each row.
#' @details The \code{logs} argument must be always a matrix.
#' @examples
#' # A matrix
#' safeSoftMax(rbind(1:10, 20:11))
#' rbind(exp(1:10) / sum(exp(1:10)), exp(20:11) / sum(exp(20:11)))
#'
#' # A row-matrix
#' safeSoftMax(rbind(-100:100), expTrc = 30)
#' exp(-100:100) / sum(exp(-100:100))
#' @export
safeSoftMax <- function(logs, expTrc = 30) {
    .Call('_sdetorus_safeSoftMax', PACKAGE = 'sdetorus', logs, expTrc)
}

#' @title Thomas algorithm for solving tridiagonal matrix systems, with optional presaving of LU decomposition
#'
#' @description Implementation of the Thomas algorithm to solve efficiently the tridiagonal matrix system
#' \deqn{b_1 x_1 + c_1 x_2 + a_1x_n = d_1}{b[1] x[1] + c[1] x[2] + a[1]x[n] = d[1]}
#' \deqn{a_2 x_1 + b_2 x_2 + c_2x_3 = d_2}{a[2] x[1] + b[2] x[2] + c[2]x[3] = d[2]}
#' \deqn{\vdots \vdots \vdots}{...}
#' \deqn{a_{n-1} x_{n-2} + b_{n-1} x_{n-1} + c_{n-1}x_{n} = d_{n-1}}{a[n-1] x[n-2] + b[n-1] x[n-1] + c[n-1]x[n] = d[n-1]}
#' \deqn{c_n x_1 + a_{n} x_{n-1} + b_nx_n = d_n}{c[n] x[1] + a[n] x[n-1] + b[n]x[n] = d[n]}
#' with \eqn{a_1=c_n=0}{a[1]=c[n]=0} (usual tridiagonal matrix). If \eqn{a_1\neq0}{a[1]/=0} or \eqn{c_n\neq0}{c[n]/=0} (circulant tridiagonal matrix), then the Sherman--Morrison formula is employed.
#'
#' @param a,b,c subdiagonal (below main diagonal), diagonal and superdiagonal (above main diagonal), respectively. They all are vectors of length \code{n}.
#' @param d vector of constant terms, of length \code{n}. For \code{solveTridiagMatConsts}, it can be a matrix with \code{n} rows.
#' @param LU flag denoting if the forward sweep encoding the LU decomposition is supplied in vectors \code{b} and \code{c}. See details and examples.
#' @return
#' \itemize{
#' \item \code{solve*} functions: the solution, a vector of length \code{n} and a matrix with \code{n} rows for\cr \code{solveTridiagMatConsts}.
#' \item \code{forward*} functions: the matrix \code{cbind(b, c)} creating the suitable \code{b} and \code{c} arguments for calling \code{solve*} when \code{LU} is \code{TRUE}.
#' }
#' @details The Thomas algorithm is stable if the matrix is diagonally dominant.
#'
#' For the periodic case, two non-periodic tridiagonal systems with different constant terms (but same coefficients) are solved using \code{solveTridiagMatConsts}. These two solutions are combined by the Sherman--Morrison formula to obtain the solution to the periodic system.
#'
#' Note that the output of \code{solveTridiag} and \code{solveTridiagMatConsts} are independent from the values of \code{a[1]} and \code{c[n]}, but \code{solvePeriodicTridiag} is not.
#'
#' If \code{LU} is \code{TRUE}, then \code{b} and \code{c} must be precomputed with \code{forwardSweepTridiag} or\cr \code{forwardSweepPeriodicTridiag} for its use in the call of the appropriate solver, which will be slightly faster.
#' @references
#' Thomas, J. W. (1995). \emph{Numerical Partial Differential Equations: Finite Difference Methods}. Springer, New York. \doi{10.1007/978-1-4899-7278-1}
#'
#' Conte, S. D. and de Boor, C. (1980). \emph{Elementary Numerical Analysis: An Algorithmic Approach}. Third edition. McGraw-Hill, New York. \doi{10.1137/1.9781611975208}
#' @examples
#' # Tridiagonal matrix
#' n <- 10
#' a <- rnorm(n, 3, 1)
#' b <- rnorm(n, 10, 1)
#' c <- rnorm(n, 0, 1)
#' d <- rnorm(n, 0, 1)
#' A <- matrix(0, nrow = n, ncol = n)
#' diag(A) <- b
#' for (i in 1:(n - 1)) {
#'   A[i + 1, i] <- a[i + 1]
#'   A[i, i + 1] <- c[i]
#' }
#' A
#'
#' # Same solutions
#' drop(solveTridiag(a = a, b = b, c = c, d = d))
#' solve(a = A, b = d)
#'
#' # Presaving the forward sweep (encodes the LU factorization)
#' LU <- forwardSweepTridiag(a = a, b = b, c = c)
#' drop(solveTridiag(a = a, b = LU[, 1], c = LU[, 2], d = d, LU = 1))
#'
#' # With equal coefficient matrix
#' solveTridiagMatConsts(a = a, b = b, c = c, d = cbind(d, d + 1))
#' cbind(solve(a = A, b = d), solve(a = A, b = d + 1))
#' LU <- forwardSweepTridiag(a = a, b = b, c = c)
#' solveTridiagMatConsts(a = a, b = LU[, 1], c = LU[, 2], d = cbind(d, d + 1), LU = 1)
#'
#' # Periodic matrix
#' A[1, n] <- a[1]
#' A[n, 1] <- c[n]
#' A
#'
#' # Same solutions
#' drop(solvePeriodicTridiag(a = a, b = b, c = c, d = d))
#' solve(a = A, b = d)
#'
#' # Presaving the forward sweep (encodes the LU factorization)
#' LU <- forwardSweepPeriodicTridiag(a = a, b = b, c = c)
#' drop(solvePeriodicTridiag(a = a, b = LU[, 1], c = LU[, 2], d = d, LU = 1))
#' @export
solveTridiag <- function(a, b, c, d, LU = 0L) {
    .Call('_sdetorus_solveTridiag', PACKAGE = 'sdetorus', a, b, c, d, LU)
}

#' @rdname solveTridiag
#' @export
solveTridiagMatConsts <- function(a, b, c, d, LU = 0L) {
    .Call('_sdetorus_solveTridiagMatConsts', PACKAGE = 'sdetorus', a, b, c, d, LU)
}

#' @rdname solveTridiag
#' @export
solvePeriodicTridiag <- function(a, b, c, d, LU = 0L) {
    .Call('_sdetorus_solvePeriodicTridiag', PACKAGE = 'sdetorus', a, b, c, d, LU)
}

#' @rdname solveTridiag
#' @export
forwardSweepTridiag <- function(a, b, c) {
    .Call('_sdetorus_forwardSweepTridiag', PACKAGE = 'sdetorus', a, b, c)
}

#' @rdname solveTridiag
#' @export
forwardSweepPeriodicTridiag <- function(a, b, c) {
    .Call('_sdetorus_forwardSweepPeriodicTridiag', PACKAGE = 'sdetorus', a, b, c)
}

#' @title Crank--Nicolson finite difference scheme for the 1D Fokker--Planck equation with periodic boundaries
#'
#' @description Implementation of the Crank--Nicolson scheme for solving the Fokker--Planck equation
#' \deqn{p(x, t)_t = -(p(x, t) b(x))_x + \frac{1}{2}(\sigma^2(x) p(x, t))_{xx},}{p(x, t)_t = -(p(x, t) * b(x))_x + 1/2 * (\sigma^2(x) p(x, t))_{xx},}
#' where \eqn{p(x, t)} is the transition probability density of the circular diffusion
#' \deqn{dX_t=b(X_t)dt+\sigma(X_t)dW_t}{dX_t=b(X_t)dt+\sigma(X_t)dW_t}.
#'
#' @param u0 matrix of size \code{c(Mx, 1)} giving the initial condition. Typically, the evaluation of a density highly concentrated at a given point. If \code{nt == 1}, then \code{u0} can be a matrix \code{c(Mx, nu0)} containing different starting values in the columns.
#' @param b vector of length \code{Mx} containing the evaluation of the drift.
#' @param sigma2 vector of length \code{Mx} containing the evaluation of the squared diffusion coefficient.
#' @param N increasing integer vector of length \code{nt} giving the indexes of the times at which the solution is desired. The times of the solution are \code{delta * c(0:max(N))[N + 1]}.
#' @param deltat time step.
#' @param Mx size of the equispaced spatial grid in \eqn{[-\pi,\pi)}.
#' @param deltax space grid discretization.
#' @param imposePositive flag to indicate whether the solution should be transformed in order to be always larger than a given tolerance. This prevents spurious negative values. The tolerance will be taken as \code{imposePositiveTol} if this is different from \code{FALSE} or \code{0}.
#' @return
#' \itemize{
#' \item If \code{nt > 1}, a matrix of size \code{c(Mx, nt)} containing the discretized solution at the required times.
#' \item If \code{nt == 1}, a matrix of size \code{c(Mx, nu0)} containing the discretized solution at a fixed time for different starting values.
#' }
#' @details The function makes use of \code{\link{solvePeriodicTridiag}} for obtaining implicitly the next step in time of the solution.
#'
#' If \code{imposePositive = TRUE}, the code implicitly assumes that the solution integrates to one at any step. This might b unrealistic if the initial condition is not properly represented in the grid (for example, highly concentrated density in a sparse grid).
#' @references
#' Thomas, J. W. (1995). \emph{Numerical Partial Differential Equations: Finite Difference Methods}. Springer, New York. \doi{10.1007/978-1-4899-7278-1}
#' @examples
#' # Parameters
#' Mx <- 200
#' N <- 200
#' x <- seq(-pi, pi, l = Mx + 1)[-c(Mx + 1)]
#' times <- seq(0, 1, l = N + 1)
#' u0 <- dWn1D(x, pi/2, 0.05)
#' b <- driftWn1D(x, alpha = 1, mu = pi, sigma = 1)
#' sigma2 <- rep(1, Mx)
#'
#' # Full trajectory of the solution (including initial condition)
#' u <- crankNicolson1D(u0 = cbind(u0), b = b, sigma2 = sigma2, N = 0:N,
#'                      deltat = 1 / N, Mx = Mx, deltax = 2 * pi / Mx)
#'
#' # Mass conservation
#' colMeans(u) * 2 * pi
#'
#' # Visualization of tpd
#' plotSurface2D(times, x, z = t(u), levels = seq(0, 3, l = 50))
#'
#' # Only final time
#' v <- crankNicolson1D(u0 = cbind(u0), b = b, sigma2 = sigma2, N = N,
#'                      deltat = 1 / N, Mx = Mx, deltax = 2 * pi / Mx)
#' sum(abs(u[, N + 1] - v))
#' @export
crankNicolson1D <- function(u0, b, sigma2, N, deltat, Mx, deltax, imposePositive = 0L) {
    .Call('_sdetorus_crankNicolson1D', PACKAGE = 'sdetorus', u0, b, sigma2, N, deltat, Mx, deltax, imposePositive)
}

#' @title Crank--Nicolson finite difference scheme for the 2D Fokker--Planck equation with periodic boundaries
#'
#' @description Implementation of the Crank--Nicolson scheme for solving the Fokker--Planck equation
#' \deqn{p(x, y, t)_t = -(p(x, y, t) b_1(x, y))_x -(p(x, y, t) b_2(x, y))_y+}
#' \deqn{+ \frac{1}{2}(\sigma_1^2(x, y) p(x, y, t))_{xx} + \frac{1}{2}(\sigma_2^2(x, y) p(x, y, t))_{yy} + (\sigma_{12}(x, y) p(x, y, t))_{xy},}{p(x, y, t)_t = -(p(x, y, t) * b_1(x, y))_x -(p(x, y, t) * b_2(x, y))_y + 1/2 * (\sigma_1^2(x, y) *p(x, y, t))_{xx} + 1/2 * (\sigma_2^2(x, y) p(x, y, t))_{yy} + (\sigma_{12}(x, y) p(x, y, t))_{xy},}
#' where \eqn{p(x, y, t)} is the transition probability density of the toroidal diffusion
#' \deqn{dX_t=b_1(X_t,Y_t)dt+\sigma_1(X_t,Y_t)dW^1_t+\sigma_{12}(X_t,Y_t)dW^2_t,}{dX_t=b_1(X_t,Y_t)dt+\sigma_1(X_t,Y_t)dW^1_t+\sigma_{12}(X_t,Y_t)dW^2_t,}
#' \deqn{dY_t=b_2(X_t,Y_t)dt+\sigma_{12}(X_t,Y_t)dW^1_t+\sigma_2(X_t,Y_t)dW^2_t.}{dY_t=b_2(X_t,Y_t)dt+\sigma_{12}(X_t,Y_t)dW^1_t+\sigma_2(X_t,Y_t)dW^2_t.}
#'
#' @param u0 matrix of size \code{c(Mx * My, 1)} giving the initial condition matrix column-wise stored. Typically, the evaluation of a density highly concentrated at a given point. If \code{nt == 1}, then \code{u0} can be a matrix \code{c(Mx * My, nu0)} containing different starting values in the columns.
#' @param bx,by matrices of size \code{c(Mx, My)} containing the evaluation of the drift in the first and second space coordinates, respectively.
#' @param sigma2x,sigma2y,sigmaxy matrices of size \code{c(Mx, My)} containing the evaluation of the entries of the diffusion matrix (it has to be positive definite)\cr
#' \code{rbind(c(sigma2x, sigmaxy),
#'             c(sigmaxy, sigma2y))}.
#' @inheritParams crankNicolson1D
#' @param Mx,My sizes of the equispaced spatial grids in \eqn{[-\pi,\pi)} for each component.
#' @param deltax,deltay space grid discretizations for each component.
#' @param imposePositive flag to indicate whether the solution should be transformed in order to be always larger than a given tolerance. This prevents spurious negative values. The tolerance will be taken as \code{imposePositiveTol} if this is different from \code{FALSE} or \code{0}.
#' @return
#' \itemize{
#' \item If \code{nt > 1}, a matrix of size \code{c(Mx * My, nt)} containing the discretized solution at the required times with the \code{c(Mx, My)} matrix stored column-wise.
#' \item If \code{nt == 1}, a matrix of size \code{c(Mx * My, nu0)} containing the discretized solution at a fixed time for different starting values.
#' }
#' @details The function makes use of \code{\link{solvePeriodicTridiag}} for obtaining implicitly the next step in time of the solution.
#'
#' If \code{imposePositive = TRUE}, the code implicitly assumes that the solution integrates to one at any step. This might b unrealistic if the initial condition is not properly represented in the grid (for example, highly concentrated density in a sparse grid).
#' @references
#' Thomas, J. W. (1995). \emph{Numerical Partial Differential Equations: Finite Difference Methods}. Springer, New York. \doi{10.1007/978-1-4899-7278-1}
#' @examples
#' # Parameters
#' Mx <- 100
#' My <- 100
#' N <- 200
#' x <- seq(-pi, pi, l = Mx + 1)[-c(Mx + 1)]
#' y <- seq(-pi, pi, l = My + 1)[-c(My + 1)]
#' m <- c(pi / 2, pi)
#' p <- c(0, 1)
#' u0 <- c(outer(dWn1D(x, p[1], 0.5), dWn1D(y, p[2], 0.5)))
#' bx <- outer(x, y, function(x, y) 5 * sin(m[1] - x))
#' by <- outer(x, y, function(x, y) 5 * sin(m[2] - y))
#' sigma2 <- matrix(1, nrow = Mx, ncol = My)
#' sigmaxy <- matrix(0.5, nrow = Mx, ncol = My)
#'
#' # Full trajectory of the solution (including initial condition)
#' u <- crankNicolson2D(u0 = cbind(u0), bx = bx, by = by, sigma2x = sigma2,
#'                      sigma2y = sigma2, sigmaxy = sigmaxy,
#'                      N = 0:N, deltat = 1 / N, Mx = Mx, deltax = 2 * pi / Mx,
#'                      My = My, deltay = 2 * pi / My)
#'
#' # Mass conservation
#' colMeans(u) * 4 * pi^2
#'
#' # Only final time
#' v <- crankNicolson2D(u0 = cbind(u0), bx = bx, by = by, sigma2x = sigma2,
#'                      sigma2y = sigma2, sigmaxy = sigmaxy,
#'                      N = N, deltat = 1 / N, Mx = Mx, deltax = 2 * pi / Mx,
#'                      My = My, deltay = 2 * pi / My)
#' sum(abs(u[, N + 1] - v))
#'
#' \dontrun{
#' # Visualization of tpd
#' library(manipulate)
#' manipulate({
#'   plotSurface2D(x, y, z = matrix(u[, j + 1], Mx, My),
#'                 main = round(mean(u[, j + 1]) * 4 * pi^2, 4),
#'                 levels = seq(0, 2, l = 21))
#'   points(p[1], p[2], pch = 16)
#'   points(m[1], m[2], pch = 16)
#' }, j = slider(0, N))
#' }
#' @export
crankNicolson2D <- function(u0, bx, by, sigma2x, sigma2y, sigmaxy, N, deltat, Mx, deltax, My, deltay, imposePositive = 0L) {
    .Call('_sdetorus_crankNicolson2D', PACKAGE = 'sdetorus', u0, bx, by, sigma2x, sigma2y, sigmaxy, N, deltat, Mx, deltax, My, deltay, imposePositive)
}

#' @title Drift of the WN diffusion in 1D
#'
#' @description Computes the drift of the WN diffusion in 1D in a vectorized way.
#'
#' @inheritParams dWn1D
#' @inheritParams dTpdWou1D
#' @inheritParams safeSoftMax
#' @return A vector of length \code{n} containing the drift evaluated at \code{x}.
#' @examples
#' driftWn1D(x = seq(0, pi, l = 10), alpha = 1, mu = 0, sigma = 1, maxK = 2,
#'           expTrc = 30)
#' @export
driftWn1D <- function(x, alpha, mu, sigma, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_driftWn1D', PACKAGE = 'sdetorus', x, alpha, mu, sigma, maxK, expTrc)
}

#' @title Drift of the WN diffusion in 2D
#'
#' @description Computes the drift of the WN diffusion in 2D in a vectorized way.
#'
#' @param A drift matrix of size \code{c(2, 2)}.
#' @inheritParams dTpdWou2D
#' @inheritParams dWn1D
#' @inheritParams safeSoftMax
#' @return A matrix of size \code{c(n, 2)} containing the drift evaluated at \code{x}.
#' @examples
#' alpha <- 3:1
#' mu <- c(0, 0)
#' sigma <- 1:2
#' rho <- 0.5
#' Sigma <- diag(sigma^2)
#' Sigma[1, 2] <- Sigma[2, 1] <- rho * prod(sigma)
#' A <- alphaToA(alpha = alpha, sigma = sigma, rho = rho)
#' x <- rbind(c(0, 1), c(1, 0.1), c(pi, pi), c(-pi, -pi), c(pi / 2, 0))
#' driftWn2D(x = x, A = A, mu = mu, sigma = sigma, rho = rho)
#' driftWn(x = x, A = A, mu = c(0, 0), Sigma = Sigma)
#' @export
driftWn2D <- function(x, A, mu, sigma, rho = 0, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_driftWn2D', PACKAGE = 'sdetorus', x, A, mu, sigma, rho, maxK, expTrc)
}

#' @title Simulation of trajectories of the WN or vM diffusion in 1D
#'
#' @description Simulation of the Wrapped Normal (WN) diffusion or von Mises (vM) diffusion by the Euler method in 1D, for several starting values.
#'
#' @param x0 vector of length \code{nx0} giving the initial points.
#' @inheritParams driftWn1D
#' @inheritParams dTpdWou1D
#' @param N number of discretization steps.
#' @param delta discretization step.
#' @param type integer giving the type of diffusion. Currently, only \code{1} for WN and \code{2} for vM are supported.
#' @return A matrix of size \code{c(nx0, N + 1)} containing the \code{nx0} discretized trajectories. The first column corresponds to the vector \code{x0}.
#' @examples
#' N <- 100
#' nx0 <- 20
#' x0 <- seq(-pi, pi, l = nx0 + 1)[-(nx0 + 1)]
#' set.seed(12345678)
#' samp <- euler1D(x0 = x0, mu = 0, alpha = 3, sigma = 1, N = N,
#'                 delta = 0.01, type = 2)
#' tt <- seq(0, 1, l = N + 1)
#' plot(rep(0, nx0), x0, pch = 16, col = rainbow(nx0), xlim = c(0, 1))
#' for (i in 1:nx0) linesCirc(tt, samp[i, ], col = rainbow(nx0)[i])
#' @export
euler1D <- function(x0, alpha, mu, sigma, N = 100L, delta = 0.01, type = 1L, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_euler1D', PACKAGE = 'sdetorus', x0, alpha, mu, sigma, N, delta, type, maxK, expTrc)
}

#' @title Simulation of trajectories of the WN or MvM diffusion in 2D
#'
#' @description Simulation of the Wrapped Normal (WN) diffusion or Multivariate von Mises (MvM) diffusion by the Euler method in 2D, for several starting values.
#'
#' @param x0 matrix of size \code{c(nx0, 2)} giving the initial points.
#' @inheritParams driftWn2D
#' @inheritParams euler1D
#' @inheritParams safeSoftMax
#' @return An array of size \code{c(nx0, 2, N + 1)} containing the \code{nx0} discretized trajectories. The first slice corresponds to the matrix \code{x0}.
#' @examples
#' N <- 100
#' nx0 <- 5
#' x0 <- seq(-pi, pi, l = nx0 + 1)[-(nx0 + 1)]
#' x0 <- as.matrix(expand.grid(x0, x0))
#' nx0 <- nx0^2
#' set.seed(12345678)
#' samp <- euler2D(x0 = x0, mu = c(0, 0), A = rbind(c(3, 1), 1:2),
#'                 sigma = c(1, 1), N = N, delta = 0.01, type = 2)
#' plot(x0[, 1], x0[, 2], xlim = c(-pi, pi), ylim = c(-pi, pi), pch = 16,
#'      col = rainbow(nx0))
#' for (i in 1:nx0) linesTorus(samp[i, 1, ], samp[i, 2, ],
#'                            col = rainbow(nx0, alpha = 0.5)[i])
#' @export
euler2D <- function(x0, A, mu, sigma, rho = 0, N = 100L, delta = 0.01, type = 1L, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_euler2D', PACKAGE = 'sdetorus', x0, A, mu, sigma, rho, N, delta, type, maxK, expTrc)
}

#' @title Multiple simulation of trajectory ends of the WN or vM diffusion in 1D
#'
#' @description Simulates \code{M} trajectories starting from different initial values \code{x0} of the WN or vM diffusion in 1D, by the Euler method, and returns their ends.
#'
#' @inheritParams euler1D
#' @inheritParams dTpdWou1D
#' @param M number of Monte Carlo replicates.
#' @return A matrix of size \code{c(nx0, M)} containing the \code{M} trajectory ends for each starting value \code{x0}.
#' @examples
#' N <- 100
#' nx0 <- 20
#' x0 <- seq(-pi, pi, l = nx0 + 1)[-(nx0 + 1)]
#' set.seed(12345678)
#' samp1 <- euler1D(x0 = x0, mu = 0, alpha = 3, sigma = 1, N = N,
#'                  delta = 0.01, type = 2)
#' tt <- seq(0, 1, l = N + 1)
#' plot(rep(0, nx0), x0, pch = 16, col = rainbow(nx0), xlim = c(0, 1))
#' for (i in 1:nx0) linesCirc(tt, samp1[i, ], col = rainbow(nx0)[i])
#' set.seed(12345678)
#' samp2 <- stepAheadWn1D(x0 = x0, mu = 0, alpha = 3, sigma = 1, M = 1,
#'                        N = N, delta = 0.01, type = 2)
#' points(rep(1, nx0), samp2[, 1], pch = 16, col = rainbow(nx0))
#' samp1[, N + 1]
#' samp2[, 1]
#' @export
stepAheadWn1D <- function(x0, alpha, mu, sigma, M, N = 100L, delta = 0.01, type = 1L, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_stepAheadWn1D', PACKAGE = 'sdetorus', x0, alpha, mu, sigma, M, N, delta, type, maxK, expTrc)
}

#' @title Multiple simulation of trajectory ends of the WN or MvM diffusion in 2D
#'
#' @description Simulates \code{M} trajectories starting from different initial values \code{x0} of the WN or MvM diffusion in 2D, by the Euler method, and returns their ends.
#'
#' @inheritParams euler2D
#' @inheritParams dTpdWou2D
#' @inheritParams stepAheadWn1D
#' @return An array of size \code{c(nx0, 2, M)} containing the \code{M} trajectory ends for each starting value \code{x0}.
#' @examples
#' N <- 100
#' nx0 <- 3
#' x0 <- seq(-pi, pi, l = nx0 + 1)[-(nx0 + 1)]
#' x0 <- as.matrix(expand.grid(x0, x0))
#' nx0 <- nx0^2
#' set.seed(12345678)
#' samp1 <- euler2D(x0 = x0, mu = c(0, 0), A = rbind(c(3, 1), 1:2),
#'                  sigma = c(1, 1), N = N, delta = 0.01, type = 2)
#' plot(x0[, 1], x0[, 2], xlim = c(-pi, pi), ylim = c(-pi, pi), pch = 16,
#'      col = rainbow(nx0))
#' for (i in 1:nx0) linesTorus(samp1[i, 1, ], samp1[i, 2, ],
#'                            col = rainbow(nx0, alpha = 0.75)[i])
#' set.seed(12345678)
#' samp2 <- stepAheadWn2D(x0 = x0, mu = c(0, 0), A = rbind(c(3, 1), 1:2),
#'                        sigma = c(1, 1), M = 2, N = N, delta = 0.01,
#'                        type = 2)
#' points(samp2[, 1, 1], samp2[, 2, 1], pch = 16, col = rainbow(nx0))
#' samp1[, , N + 1]
#' samp2[, , 1]
#' @export
stepAheadWn2D <- function(x0, mu, A, sigma, rho = 0, M = 100L, N = 100L, delta = 0.01, type = 1L, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_stepAheadWn2D', PACKAGE = 'sdetorus', x0, mu, A, sigma, rho, M, N, delta, type, maxK, expTrc)
}

#' @title Loglikelihood of WN in 2D when only the initial and final points are observed
#'
#' @description Computation of the loglikelihood for a WN diffusion (with diagonal diffusion matrix) from a sample of initial and final pairs of angles.
#'
#' @param x a matrix of dimension \code{c(n, 4)} of initial and final pairs of angles. Each row is an observation containing \eqn{(\phi_0, \psi_0, \phi_t, \psi_t)}.
#' They all must be in \eqn{[\pi,\pi)} so that the truncated wrapping by \code{maxK} windings is able to capture periodicity.
#' @param t either a scalar or a vector of length \code{n} containing the times the initial and final dihedrals. If \code{t} is a scalar, a common time is assumed.
#' @inheritParams dTpdWou2D
#' @inheritParams safeSoftMax
#' @inheritParams dWn1D
#' @return A scalar giving the final loglikelihood, defined as the sum of the loglikelihood of the initial angles according to the stationary density
#' and the loglikelihood of the transitions from initial to final angles.
#' @details A negative penalty is added if positive definiteness is violated. If the output value is Inf, -100 * N is returned instead.
#' @examples
#' set.seed(345567)
#' x <- toPiInt(matrix(rnorm(200, mean = pi), ncol = 4, nrow = 50))
#' alpha <- c(2, 1, -0.5)
#' mu <- c(0, pi)
#' sigma <- sqrt(c(2, 1))
#'
#' # The same
#' logLikWouPairs(x = x, t = 0.5, alpha = alpha, mu = mu, sigma = sigma)
#' sum(
#'   log(dStatWn2D(x = x[, 1:2], alpha = alpha, mu = mu, sigma = sigma)) +
#'   log(dTpdWou2D(x = x[, 3:4], x0 = x[, 1:2], t = 0.5, alpha = alpha, mu = mu,
#'                  sigma = sigma))
#' )
#'
#' # Different times
#' logLikWouPairs(x = x, t = (1:50) / 50, alpha = alpha, mu = mu, sigma = sigma)
#' @export
logLikWouPairs <- function(x, t, alpha, mu, sigma, rho = 0, maxK = 2L, expTrc = 30) {
    .Call('_sdetorus_logLikWouPairs', PACKAGE = 'sdetorus', x, t, alpha, mu, sigma, rho, maxK, expTrc)
}

.linInterp <- function(x, xGrid, yGrid, equalSpaces = FALSE) {
    .Call('_sdetorus_linInterp', PACKAGE = 'sdetorus', x, xGrid, yGrid, equalSpaces)
}

.besselIExponScaled <- function(x, nu = 0L, maxK = 10L, equalSpaces = FALSE) {
    .Call('_sdetorus_besselIExponScaled', PACKAGE = 'sdetorus', x, nu, maxK, equalSpaces)
}

.dTvmCpp <- function(x, K, M, alpha, besselInterp = FALSE, l2pi = 0) {
    .Call('_sdetorus_dTvmCpp', PACKAGE = 'sdetorus', x, K, M, alpha, besselInterp, l2pi)
}

.clusterProbsTvm <- function(cosData, sinData, M, K, alpha, l2pi, besselInterp = TRUE) {
    .Call('_sdetorus_clusterProbsTvm', PACKAGE = 'sdetorus', cosData, sinData, M, K, alpha, l2pi, besselInterp)
}

.weightedMuKappa <- function(cosData, sinData, weights, kappaMax = 250, isotropic = FALSE) {
    .Call('_sdetorus_weightedMuKappa', PACKAGE = 'sdetorus', cosData, sinData, weights, kappaMax, isotropic)
}

