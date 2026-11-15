#' Asymptotic Covariance Matrix of the Sample Covariance Matrix Under Normality
#'
#' Returns the asymptotic covariance matrix
#' \eqn{\boldsymbol{\Gamma}_{N}}
#' of the half-vectorization of the sample covariance matrix of `x`,
#' assuming multivariate normality,
#' \deqn{
#'   \boldsymbol{\Gamma}_{N} =
#'   2 \boldsymbol{D}_{k}^{+}
#'   \left(
#'     \boldsymbol{\Sigma} \otimes \boldsymbol{\Sigma}
#'   \right)
#'   \boldsymbol{D}_{k}^{+ \prime},
#' }
#' where
#' \eqn{\boldsymbol{D}_{k}^{+}}
#' is the Moore-Penrose inverse of the duplication matrix
#' and
#' \eqn{\boldsymbol{\Sigma}}
#' is the sample covariance matrix of `x`,
#' multiplied by \eqn{n / (n - 1)} when `consistent = TRUE`.
#'
#' @details
#' The function returns the output of the internal `.GammaN()`
#' with `sigmacap` the (optionally rescaled) sample covariance matrix
#' and `pinv_of_dcap` the Moore-Penrose inverse
#' of the \eqn{k \times k} duplication matrix.
#'
#' @author Ivan Jacob Agaloos Pesigan
#'
#' @param x Numeric vector, matrix, or data frame.
#'   Data, with observations in rows.
#' @param consistent Logical.
#'   If `TRUE`, multiply the sample covariance matrix by \eqn{n / (n - 1)}.
#'
#' @return Returns a \eqn{q \times q} matrix,
#'   where \eqn{q = k (k + 1) / 2} and \eqn{k} is the number of variables.
#'
#' @examples
#' GammaN(x = datasets::mtcars[, c("mpg", "wt")])
#'
#' @family gammaN Functions
#' @keywords gammaN gamma
#' @export
GammaN <- function(x,
                   consistent = TRUE) {
  if (is.vector(x = x)) {
    n <- length(x = x)
  }
  if (is.matrix(x = x) || is.data.frame(x = x)) {
    n <- dim(x = x)[1]
  }
  sigmacap <- stats::var(x = x)
  if (consistent) {
    sigmacap <- sigmacap * (
      n / (
        n - 1
      )
    )
  }
  sigmacap <- as.matrix(x = sigmacap)
  .GammaN(
    sigmacap = sigmacap,
    pinv_of_dcap = .PInvDmat(
      d = .DMat(
        k = dim(x = sigmacap)[1]
      )
    )
  )
}
