# Asymptotic Covariance Matrix of the Sample Covariance Matrix Under Normality

Returns the asymptotic covariance matrix \\(\boldsymbol{\Gamma}\_{N}\\)
of the half-vectorization of the sample covariance matrix of `x`,
assuming multivariate normality, \$\$ \boldsymbol{\Gamma}\_{N} = 2
\boldsymbol{D}\_{k}^{+} \left( \boldsymbol{\Sigma} \otimes
\boldsymbol{\Sigma} \right) \boldsymbol{D}\_{k}^{+ \prime}, \$\$ where
\\(\boldsymbol{D}\_{k}^{+}\\) is the Moore-Penrose inverse of the
duplication matrix and \\(\boldsymbol{\Sigma}\\) is the sample
covariance matrix of `x`, multiplied by \\(n / (n - 1)\\) when
`consistent = TRUE`.

## Usage

``` r
GammaN(x, consistent = TRUE)
```

## Arguments

- x:

  Numeric vector, matrix, or data frame. Data, with observations in
  rows.

- consistent:

  Logical. If `TRUE`, multiply the sample covariance matrix by \\(n /
  (n - 1)\\).

## Value

Returns a \\(q \times q\\) matrix, where \\(q = k (k + 1) / 2\\) and
\\(k\\) is the number of variables.

## Details

The function returns the output of the internal `.GammaN()` with
`sigmacap` the (optionally rescaled) sample covariance matrix and
`pinv_of_dcap` the Moore-Penrose inverse of the \\(k \times k\\)
duplication matrix.

## Author

Ivan Jacob Agaloos Pesigan

## Examples

``` r
GammaN(x = datasets::mtcars[, c("mpg", "wt")])
#>            [,1]       [,2]       [,3]
#> [1,] 2811.87725 -396.08657  55.793534
#> [2,] -396.08657   64.95249 -10.439486
#> [3,]   55.79353  -10.43949   1.953324
```
