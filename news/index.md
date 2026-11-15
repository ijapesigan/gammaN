# Changelog

## gammaN 0.0.2

### Bug fix

- [`GammaN()`](https://ijapesigan.github.io/gammaN/reference/GammaN.md)
  returned the sample covariance matrix, not the asymptotic covariance
  matrix under normality that its documentation and 0.0.1 NEWS
  described. It now returns `.GammaN()` of the (optionally `n / (n - 1)`
  scaled) sample covariance matrix, with the Moore-Penrose inverse of
  the duplication matrix built from `.DMat()` and `.PInvDmat()`.
- Complete roxygen for
  [`GammaN()`](https://ijapesigan.github.io/gammaN/reference/GammaN.md)
  and `.GammaN()`, with argument names in every call.
- Tests: values checked against the closed forms for `k = 1` and
  `k = 2`, and against a hand-built `2 D+ (S x S) D+'` for `k = 3`.

## gammaN 0.0.1

### Initial release

- The rProject template; private `jeksterslab-psu/gammaN`, public
  `ijapesigan/gammaN`.
- Complete roxygen for every function; the internal function uses
  `@noRd`.
- [`GammaN()`](https://ijapesigan.github.io/gammaN/reference/GammaN.md)
  returns the asymptotic covariance matrix of the half-vectorized sample
  covariance matrix under normality (the output of `.GammaN()`;
  `consistent = TRUE` scales the covariance matrix by `n / (n - 1)`
  first). It uses locked copies of linearAlgebra’s `.DMat()`,
  `.PInvDmat()`, and `.Vec()`.
- A test file for every function.
