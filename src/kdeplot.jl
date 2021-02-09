
# like `density(x)` from StatsPlots, but we keep the density values around to place the rugplot
RecipesBase.@recipe function f(
    ::Type{Val{:kdeplot}}, x, y, z; cumulative=false, showrug=false, rugspace=0.05
)
    kd = KernelDensity.kde(y; boundary=extrema(y))
    ynew = kd.density
    if cumulative
        ynew = cumsum(ynew)
        ynew ./= ynew[end]
    end
    if showrug
        ymax = maximum(ynew)
        if haskey(plotattributes, :rugsize)
            rugspace *= plotattributes[:rugsize] / DEFAULT_RUG_SIZE
        end
        RecipesBase.@series begin
            primary := false
            seriestype := :rugplot
            rugposition := -rugspace * ymax
            y := y
            ()
        end
    else # no need to set ylims if rug already widened axes for us
        ylims --> (0, Inf)
    end
    seriestype := :path
    x := kd.x
    y := ynew
    return ()
end

RecipesBase.@shorthands kdeplot

RecipesBase.@recipe function f(::Type{Val{:kde2dplot}}, x, y, z)
    kd = KernelDensity.kde((x, y); boundary=(extrema(x), extrema(y)))
    seriestype := :contour
    x := kd.x
    y := kd.y
    z := RecipesPipeline.Surface(kd.density)
    fill --> true
    colorbar --> false
    return ()
end

RecipesBase.@shorthands kde2dplot
