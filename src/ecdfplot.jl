# adapted from https://github.com/JuliaPlots/StatsPlots.jl/blob/master/src/ecdf.jl
# to avoid dependency and to make it a series plot instead of a user plot
# not exported to avoid clashing with StatsPlots.ecdfplot

"""
    ecdfplot(x; kwargs...)
    ecdfplot!(x; kwargs...)

Plot the empirical cumulative distribution function (ECDF) of the data `x`.

# Positional Arguments
- `x`: Values to plot

# Keyword Arguments
- `weights=nothing`: Vector of weights to be used for a weighted ECDF
- `kwargs`: Additional attributes understood by Plots.jl
"""
ecdfplot(x; kwargs...) = RecipesBase.plot(x; seriestype=:ecdfplot, kwargs...)
ecdfplot!(x; kwargs...) = RecipesBase.plot!(x; seriestype=:ecdfplot, kwargs...)

RecipesBase.@recipe function f(::Type{Val{:ecdfplot}}, x, y, z; weights=nothing)
    ecdf = weights === nothing ? StatsBase.ecdf(y) : StatsBase.ecdf(y; weights=weights)
    xnew, ynew = _ecdf_points(ecdf)
    if isrotated(plotattributes)
        xnew, ynew = ynew, xnew
    end
    seriestype := :steppost
    x := xnew
    y := ynew
    legend --> :topleft
    return ()
end

function _ecdf_points(ecdf::StatsBase.ECDF)
    x = [ecdf.sorted_values[1]; ecdf.sorted_values]
    if hasproperty(ecdf, :weights) && !isempty(ecdf.weights)
        y = cumsum(ecdf.weights)
        y ./= y[end]
        prepend!(y, [zero(eltype(y))])
    else
        T = float(eltype(ecdf.sorted_values))
        y = range(zero(T), one(T); length=length(x))
    end
    return x, y
end
