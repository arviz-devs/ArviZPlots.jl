# smaller plot recipes used to make more complicated plot recipes

const DEFAULT_RUG_SIZE = 8

"""
    rugplot(x; kwargs...)
    rugplot!(x; kwargs...)

Make a rugplot.

# Positional Arguments
- `x`: values

# Keyword Arguments
- `rugmarkershape=:vline`: shape of marker
- `rugsize=$DEFAULT_RUG_SIZE`: size (height) of marker
- `rugcolor=:auto`: color of marker
- `rugalpha=:auto`: alpha value (transparency) of marker
- `rugposition=0`: `y`-axis position of rug
- `kwargs`: Additional attributes understood by Plots.jl
"""
rugplot(x; kwargs...) = RecipesBase.plot(x; kwargs...)
rugplot!(x; kwargs...) = RecipesBase.plot!(x; kwargs...)

RecipesBase.@recipe function f(
    ::Type{Val{:rugplot}},
    x,
    y,
    z;
    rugmarkershape=:vline,
    rugsize=DEFAULT_RUG_SIZE,
    rugcolor=get(plotattributes, :seriescolor, :auto),
    rugalpha=get(plotattributes, :seriesalpha, :auto),
    rugposition=0,
)
    seriestype := :scatter
    x := y
    y := fill(rugposition, length(y))
    markershape := rugmarkershape
    markersize := rugsize
    markercolor := rugcolor
    markeralpha := rugalpha
    fill := false  # necessary in case fill=true passed to parent
    label := ""
    return ()
end
