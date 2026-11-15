## ---- test-gammaN-gamma-n-dot
lapply(
  X = 1,
  FUN = function(i,
                 text) {
    testthat::skip_on_cran()
    message(text)

    # Moore-Penrose inverse of the duplication matrix, built by hand.
    .PInv <- function(k) {
      sym <- matrix(data = 0, nrow = k, ncol = k)
      q <- seq_len(length.out = k * (k + 1) / 2)
      sym[lower.tri(x = sym, diag = TRUE)] <- q
      sym[upper.tri(x = sym)] <- t(x = sym)[upper.tri(x = sym)]
      d <- outer(
        X = as.vector(x = sym),
        Y = q,
        FUN = function(x, y) {
          as.numeric(x = x == y)
        }
      )
      solve(a = crossprod(x = d)) %*% t(x = d)
    }

    testthat::test_that(
      desc = paste(text, "k = 1: Gamma is 2 * sigma^2"),
      code = {
        sigmacap <- matrix(data = 3, nrow = 1, ncol = 1)
        testthat::expect_equal(
          object = gammaN:::.GammaN(
            sigmacap = sigmacap,
            pinv_of_dcap = .PInv(k = 1)
          ),
          expected = matrix(data = 2 * 9, nrow = 1, ncol = 1)
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "k = 2: known values"),
      code = {
        # Cov(vech S): s_ij,kl = s_ik s_jl + s_il s_jk (n = 1 scaling).
        sigmacap <- matrix(
          data = c(2, 1, 1, 3),
          nrow = 2
        )
        gamma <- gammaN:::.GammaN(
          sigmacap = sigmacap,
          pinv_of_dcap = .PInv(k = 2)
        )
        expected <- matrix(
          data = c(
            2 * 2 * 2, 2 * 2 * 1, 2 * 1 * 1,
            2 * 2 * 1, 2 * 3 + 1 * 1, 2 * 1 * 3,
            2 * 1 * 1, 2 * 1 * 3, 2 * 3 * 3
          ),
          nrow = 3
        )
        testthat::expect_equal(
          object = gamma,
          expected = expected
        )
        testthat::expect_true(
          object = isSymmetric(object = gamma)
        )
      }
    )

    testthat::test_that(
      desc = paste(text, "k = 3: dimension and symmetry"),
      code = {
        sigmacap <- stats::cov(x = datasets::mtcars[, c("mpg", "wt", "hp")])
        gamma <- gammaN:::.GammaN(
          sigmacap = sigmacap,
          pinv_of_dcap = .PInv(k = 3)
        )
        testthat::expect_equal(
          object = dim(x = gamma),
          expected = c(6L, 6L)
        )
        testthat::expect_true(
          object = isSymmetric(object = unname(obj = gamma))
        )
      }
    )
  },
  text = "test-gammaN-gamma-n-dot"
)
