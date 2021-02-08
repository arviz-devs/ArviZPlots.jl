RecipesBase.@recipe function f(
    ::Type{Val{:rugplot}}, x, y, z; rugmarkershape=:vline, rugsize=8, rugposition=0
)
    seriestype := :scatter
    x := y
    y := fill(rugposition, length(y))
    markershape := rugmarkershape
    markersize := rugsize
    label := ""
    return ()
end
