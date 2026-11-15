# gammaN: Asymptotic Covariance Matrix Under Normality

## Description

Helpers in R (R Core Team, 2026) for the asymptotic covariance matrix of
the sample covariance matrix under the multivariate normal distribution,
and for the sample covariance matrix of the data. Each function has an
internal version without input checks that other projects can copy.

## Installation

You can install the development version of `gammaN` from
[GitHub](https://github.com/ijapesigan/gammaN) with:

\
`if`` ``(``!`[`require`](https://rdrr.io/r/base/library.html)`(`[`"pak"`](https://pak.r-lib.org/)`)``)`` `[`install.packages`](https://rdrr.io/r/utils/install.packages.html)`(``"pak"``)`\
`pak``::`[`pkg_install`](https://pak.r-lib.org/reference/pkg_install.html)`(``"ijapesigan/gammaN"``)`

## Example

\
[`library`](https://rdrr.io/r/base/library.html)`(``package ``=`` ``"gammaN"``)`

The asymptotic covariance matrix of the half-vectorized sample
covariance matrix of two variables under normality.

\
`x`` ``<-`` ``datasets``::`[`mtcars`](https://rdrr.io/r/datasets/mtcars.html)`[``, `[`c`](https://rdrr.io/r/base/c.html)`(``"mpg"``, ``"wt"``)``]`\
[`GammaN`](https://ijapesigan.github.io/gammaN/reference/GammaN.md)`(``x ``=`` ``x``)`\
`#>            [,1]       [,2]       [,3]`\
`#> [1,] 2811.87725 -396.08657  55.793534`\
`#> [2,] -396.08657   64.95249 -10.439486`\
`#> [3,]   55.79353  -10.43949   1.953324`\
[`GammaN`](https://ijapesigan.github.io/gammaN/reference/GammaN.md)`(``x ``=`` ``x``, consistent ``=`` ``FALSE``)`\
`#>            [,1]        [,2]      [,3]`\
`#> [1,] 2638.88089 -371.717961 52.360924`\
`#> [2,] -371.71796   60.956394 -9.797213`\
`#> [3,]   52.36092   -9.797213  1.833149`

## Documentation

See [GitHub Pages](https://ijapesigan.github.io/gammaN) for package
documentation.

## References

R Core Team. (2026). *R: A language and environment for statistical
computing*. R Foundation for Statistical Computing.
<https://www.R-project.org/>
