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

