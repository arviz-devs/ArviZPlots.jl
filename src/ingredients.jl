# smaller plot recipes used to make more complicated plot recipes

const DEFAULT_RUG_SIZE = 8

"""
    rugplot(x; kwargs...)
    rugplot!(x; kwargs...)

Make a rugplot.

# Positional Arguments
- `x`: values

# Keyword Arguments
- `rugmarkershape=:auto`: shape of marker, defaulting to perpendicular to the data axis
- `rugsize=$DEFAULT_RUG_SIZE`: size (height) of marker
- `rugcolor=:auto`: color of marker
- `rugalpha=:auto`: alpha value (transparency) of marker
- `rugposition=0`: position of rug on non-data axis
- `kwargs`: Additional attributes understood by Plots.jl
"""
rugplot(x; kwargs...) = RecipesBase.plot(x; seriestype=:rugplot, kwargs...)
rugplot!(x; kwargs...) = RecipesBase.plot!(x; seriestype=:rugplot, kwargs...)

RecipesBase.@recipe function f(
    ::Type{Val{:rugplot}},
    x,
    y,
    z;
    rugmarkershape=:auto,
    rugsize=DEFAULT_RUG_SIZE,
    rugcolor=get(plotattributes, :seriescolor, :auto),
    rugalpha=get(plotattributes, :seriesalpha, :auto),
    rugposition=0,
)
    seriestype := :scatter
    xnew = y
    ynew = fill(rugposition, length(y))
    isrot = isrotated(plotattributes)
    if isrot
        xnew, ynew = ynew, xnew
    end
    x := xnew
    y := ynew
    if rugmarkershape === :auto
        rugmarkershape = isrot ? :hline : :vline
    end
    markershape := rugmarkershape
    markersize := rugsize
    markercolor := rugcolor
    markeralpha := rugalpha
    fill := false  # necessary in case fill=true passed to parent
    label := ""
    return ()
end
