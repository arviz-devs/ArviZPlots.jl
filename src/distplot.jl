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
- `circular=false`: Select input type in `(:radians, :degrees)` for circular histogram or
    KDE plot. If `true`, default input type is `:radians`. Pass `projection=:polar` to also
    plot on a polar axis; however, this will not plot correctly when `circular=:degrees`.
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`kdeplot`](@ref) and `histogram`.
"""
RecipesBase.@shorthands distplot

RecipesBase.@recipe function f(::Type{Val{:distplot}}, x, y, z; kind=:auto, circular=false)
    if kind == :hist || (kind === :auto && all(isinteger, y))
        bins = get(plotattributes, :bins, get_bins(y))
        if circular === false
            seriestype := :barhist
        else
            # barhist does not work correctly for polar projection for GR backend
            # see https://github.com/JuliaPlots/Plots.jl/issues/1952
            seriestype := :stephist
            fill --> true
        end
        bins := bins
        normalize --> :pdf
        orientation := isrotated(plotattributes) ? :horizontal : :vertical
    elseif kind === :kde || kind === :auto
        seriestype := :kdeplot
    elseif kind === :ecdf
        seriestype := :ecdfplot
    end
    y := y
    return ()
end
