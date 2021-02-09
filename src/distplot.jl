"""
    kdeplot(x; kwargs...)
    kdeplot!(x; kwargs...)

Plot distribution as histogram or kernel density estimates.

By default continuous variables are plotted using KDEs and discrete ones using histograms

# Positional Arguments
- `x`: values to plot

# Keyword Arguments
- `kind=:auto`: By default (`:auto`), continuous variables are plotted using KDEs and
    discrete ones using histograms. To override this use `:hist` to plot histograms and `:kde`
    for KDEs
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`kdeplot`](@ref) and `histogram`.
"""
RecipesBase.@shorthands distplot

RecipesBase.@recipe function f(::Type{Val{:distplot}}, x, y, z; kind=:auto)
    if kind == :hist || (kind !== :kde && all(isinteger, y))
        seriestype := :barhist
        normalize --> :pdf
    else
        seriestype := :kdeplot
    end
    return ()
end
