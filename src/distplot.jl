"""
    distplot(x; kwargs...)
    distplot!(x; kwargs...)

Plot distribution as histogram, KDE, or ECDF.

By default continuous variables are plotted using KDEs and discrete ones using histograms

# Positional Arguments
- `x`: values to plot

# Keyword Arguments
- `kind=:auto`: By default (`:auto`), continuous variables are plotted using KDEs and
    discrete ones using histograms. The following values can override this behavior:
    + `kind=:kde`: Plot using a kernel density estimate (see [`kdeplot`](@ref))
    + `kind=:hist`: Plot using a histogram (see [`Plots.histogram`]
    + `kind=:ecdf`: Plot using an empirical cumulative distribution function
        (see [`ecdfplot`](@ref))
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`kdeplot`](@ref) and `histogram`.
"""
RecipesBase.@shorthands distplot

RecipesBase.@recipe function f(::Type{Val{:distplot}}, x, y, z; kind=:auto)
    if kind == :hist || (kind === :auto && all(isinteger, y))
        seriestype := :barhist
        normalize --> :pdf
        orientation := isrotated(plotattributes) ? :horizontal : :vertical
    elseif kind === :kde || kind === :auto
        seriestype := :kdeplot
    elseif kind === :ecdf
        seriestype := :ecdfplot
    end
    return ()
end
