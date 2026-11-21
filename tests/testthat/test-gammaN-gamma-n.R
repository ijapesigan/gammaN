## ---- test-gammaN-gamma-n
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    testthat::test_that(
      desc = paste(text, "k = 1"),
      code = {
        x <- c(1, 2, 3, 4)
        sigmasq <- stats::var(x = x)
        testthat::expect_equal(
          object = GammaN(x = x, consistent = FALSE),
          expected = matrix(data = 2 * sigmasq^2)
        )
        testthat::expect_equal(
          object = GammaN(x = x),
          expected = matrix(data = 2 * (sigmasq * 4 / 3)^2)
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "k = 2 closed form"),
      code = {
        x <- cbind(
          a = c(1, 2, 3, 4),
          b = c(2, 1, 4, 3)
        )
        sigmacap <- stats::var(x = x)
        s11 <- sigmacap[1, 1]
        s21 <- sigmacap[2, 1]
        s22 <- sigmacap[2, 2]
        expected <- matrix(
          data = c(
            2 * s11^2, 2 * s11 * s21, 2 * s21^2,
            2 * s11 * s21, s11 * s22 + s21^2, 2 * s21 * s22,
            2 * s21^2, 2 * s21 * s22, 2 * s22^2
          ),
          nrow = 3
        )
        testthat::expect_equal(
          object = GammaN(x = x, consistent = FALSE),
          expected = expected
        )
        testthat::expect_equal(
          object = GammaN(x = x),
          expected = GammaN(x = x, consistent = TRUE)
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "returns the output of the internal function"),
      code = {
        df <- data.frame(
          a = c(1, 2, 3, 4, 7),
          b = c(2, 1, 4, 3, 9),
          c = c(5, 3, 4, 1, 2)
        )
        sigmacap <- stats::var(x = df) * (5 / 4)
        pinv_of_dcap <- .PInvDmat(d = .DMat(k = 3))
        testthat::expect_equal(
          object = GammaN(x = df),
          expected = .GammaN(
            sigmacap = sigmacap,
            pinv_of_dcap = pinv_of_dcap
          )
        )
        testthat::expect_equal(
          object = dim(x = GammaN(x = df)),
          expected = c(6L, 6L)
        )
        testthat::expect_true(
          object = isSymmetric(object = GammaN(x = df))
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "k = 3 matches 2 D+ (S x S) D+' built by hand"),
      code = {
        x <- cbind(
          a = c(1, 2, 3, 4, 7),
          b = c(2, 1, 4, 3, 9),
          c = c(5, 3, 4, 1, 2)
        )
        sigmacap <- stats::var(x = x)
        # Duplication matrix: column j holds vec of the symmetric matrix
        # with a one in the positions of the j-th element of vech.
        k <- 3
        index <- matrix(data = 0, nrow = k, ncol = k)
        index[lower.tri(x = index, diag = TRUE)] <- seq_len(length.out = 6)
        index[upper.tri(x = index)] <- t(x = index)[upper.tri(x = index)]
        dcap <- outer(
          X = as.vector(x = index),
          Y = seq_len(length.out = 6),
          FUN = function(x, y) {
            as.numeric(x = x == y)
          }
        )
        pinv <- solve(a = crossprod(x = dcap)) %*% t(x = dcap)
        expected <- 2 * pinv %*% kronecker(X = sigmacap, Y = sigmacap) %*%
          t(x = pinv)
        testthat::expect_equal(
          object = GammaN(x = x, consistent = FALSE),
          expected = expected,
          ignore_attr = TRUE
        )
      }
    )
  },
  text = "test-gammaN-gamma-n"
)

## ---- test-gammaN-gamma-n-error
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)
    testthat::test_that(
      desc = paste(text, "stops on invalid input"),
      code = {
        testthat::expect_error(
          object = GammaN(x = list(1, 2))
        )
        testthat::expect_error(
          object = GammaN(x = matrix(data = 1:4, nrow = 2), consistent = NA)
        )
      }
    )
  },
  text = "test-gammaN-gamma-n-error"
)
