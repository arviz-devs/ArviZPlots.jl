# Examples

## Basic plotting

Individual variables from `InferenceData` and `ArviZ.Dataset` can be plotted using any series type that can operate on the underlying draws.

Plot histogram (Note that the histogram recipe is defined generally in Plots.jl).

```@example basic
using ArviZ, ArviZPlots, Plots

data = load_arviz_data("centered_eight")
histogram(data; legend=false, bins=20)
```

Plot estimated density of posterior and then prior.

```@example basic
distplot(data; fill=true, alpha=0.5, var_names=["mu"], label="posterior")
distplot!(data; fill=true, alpha=0.5, var_names=["mu"], groupname=:prior, label="prior")
```

Plot using the custom `:arviz-darkgrid` theme.

```@example basic
theme(:arviz_darkgrid)
distplot(data; fill=true, var_names=["mu"])
```

## Dist Plot

Plot an integer distribution

```@example distplot
using ArviZPlots, Distributions, Plots
theme(:arviz_darkgrid)

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

See [`distplot`](@ref)

## KDE Plot

Plot default KDE

```@example kdeplot
using ArviZ, ArviZPlots, Plots
theme(:arviz_darkgrid)

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

Rotate plot 90 degrees

```@example kdeplot
kdeplot(mu_posterior; rotated=true)
```

See [`kdeplot`](@ref)

## 2d KDE Plot

Plot 2d contour KDE

```@example kde2dplot
using ArviZ, ArviZPlots, Plots
theme(:arviz_darkgrid)

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

See [`kde2dplot`](@ref)
