# smaller plot recipes used to make more complicated plot recipes

const DEFAULT_RUG_SIZE = 8

RecipesBase.@recipe function f(
    ::Type{Val{:rugplot}},
    x,
    y,
    z;
    rugmarkershape=:vline,
    rugsize=DEFAULT_RUG_SIZE,
    rugcolor=get(plotattributes, :seriescolor, :auto),
    rugalpha=get(plotattributes, :seriesalpha, :auto),
    rugposition = 0,
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
