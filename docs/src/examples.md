# Examples

## Dist Plot

Plot an integer distribution

```@example distplot
using Distributions, Plots, ArviZPlots
a = rand(Poisson(4), 1000)
distplot(a)
```

Plot a continuous distribution

```@example distplot
b = randn(1000)
distplot(b)
```

Add a rug under the Gaussian distribution

```@example distplot
distplot(b; showrug=true)
```

Plot as the cumulative distribution

```@example distplot
distplot(b; showrug=true, cumulative=true)
```

## KDE Plot

Plot default KDE

```@example kdeplot
using Plots, ArviZ, ArviZPlots
non_centered = load_arviz_data("non_centered_eight")
mu_posterior = vec(non_centered.posterior["mu"].values)
tau_posterior = vec(non_centered.posterior["tau"].values)
kdeplot(mu_posterior)
```

Plot KDE with rugplot

```@example kdeplot
kdeplot(mu_posterior; showrug=true)
```

Plot the estimated cumulative distribution

```@example kdeplot
kdeplot(mu_posterior; cumulative=true)
```

See [`kdeplot`](@ref)

## 2d KDE Plot

Plot 2d contour KDE

```@example kde2dplot
using Plots, ArviZ, ArviZPlots
non_centered = load_arviz_data("non_centered_eight")
mu_posterior = vec(non_centered.posterior["mu"].values)
tau_posterior = vec(non_centered.posterior["tau"].values)
kde2dplot(mu_posterior, tau_posterior)
```

Plot 2d contour KDE, with filling and contour lines using viridis cmap

```@example kde2dplot
kde2dplot(mu_posterior, tau_posterior; fill=true, color=:viridis)
```

Plot 2d contour KDE, set the number of levels to 3.

```@example kde2dplot
kde2dplot(mu_posterior, tau_posterior; levels=3)
```

Plot 2d smooth KDE

```@example kde2dplot
kde2dplot(mu_posterior, tau_posterior; contour=false)
```
