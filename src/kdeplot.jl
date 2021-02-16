const DEFAULT_RUG_SPACE = 0.05

kde(x; kwargs...) = ArviZ.arviz.stats.density_utils.kde(x; kwargs...)

function kde(x, y; kwargs...)
    density, xmin, xmax, ymin, ymax = ArviZ.arviz.stats.density_utils._fast_kde_2d(
        x, y; kwargs...
    )
    nx, ny = size(density)
    return range(xmin, xmax; length=nx), range(ymin, ymax; length=ny), density
end

"""
    kdeplot(x[, y]; kwargs...)
    kdeplot!(x[, y]; kwargs...)

Plot a 1D or 2D kernel density estimate (KDE) taking into account boundary conditions.

# Positional Arguments
- `x`: Values to plot.
- `y`: Values to plot. If present, a 2D KDE will be estimated. See [`kde2dplot`](@ref).

# Keyword Arguments
- `bw=:default`: If numeric, indicates the bandwidth and must be positive. If `Symbol`,
    indicates the method to estimate the bandwidth and must be one of `:scott`,
    `:silverman`, `:isj` or `:experimental` when `circular=false` and `:taylor` (for now)
    when `circular=true`. `:default` means `:experimental` when variable is not circular
    and `:taylor` when it is.
- `circular=false`: Select input type in `(:radians, :degrees)` for circular KDE plot. If
    `true`, default input type is `:radians`. Pass `projection=:polar` to also plot on a
    polar axis; however, this will not plot correctly when `circular=:degrees`.
- `cumulative=false`: If `true`, plot the estimated cumulative distribution function
- `showrug=false`: If `true`, adds a rugplot
- `rugspace=$DEFAULT_RUG_SPACE`: control the `y` position of the rugplot. The larger this
    number the lower the rugplot
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`kde2dplot`](@ref) and [`rugplot`](@ref).
"""
RecipesBase.@shorthands kdeplot

RecipesBase.@recipe function f(
    ::Type{Val{:kdeplot}},
    x,
    y,
    z;
    bw=:default,
    circular=false,
    cumulative=false,
    showrug=false,
    rugspace=DEFAULT_RUG_SPACE,
)
    if x === eachindex(y) # x was (probably) auto-generated from y
        if bw === :default
            bw = circular === false ? :experimental : :taylor
        end
        xnew, ynew = kde(y; bw=bw, circular=(circular !== false))
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
        else
            # add dummy point to widen density axis to include density of 0
            RecipesBase.@series begin
                seriestype := :path
                primary := false
                seriesalpha := 0
                label := ""
                xpt, ypt = isrotated(plotattributes) ? (0, xnew[1]) : (xnew[1], 0)
                x := [xpt]
                y := [ypt]
                ()
            end
        end
        seriestype := :path
        if isrotated(plotattributes)
            xnew, ynew = ynew, xnew
        end
        x := xnew
        y := ynew
    else
        seriestype := :kde2dplot
        x := x
        y := y
    end
    return ()
end

"""
    kde2dplot(x, y; kwargs...)
    kde2dplot!(x, y; kwargs...)

Plot a 2D kernel density estimate (KDE) taking into account boundary conditions.

# Positional Arguments
- `x`: `x` coordinates of the values
- `y`: `y` coordinates of the values

# Keyword Arguments
- `contour=true`: If `true`, plot the 2D KDE using contours, otherwise plot a heatmap.
- `kwargs`: Additional attributes understood by Plots.jl.
"""
RecipesBase.@shorthands kde2dplot

RecipesBase.@recipe function f(::Type{Val{:kde2dplot}}, x, y, z; contour=true)
    xnew, ynew, density = kde(x, y)
    seriestype := contour ? :contour : :heatmap
    if isrotated(plotattributes)
        xnew, ynew = ynew, xnew
    end
    x := xnew
    y := ynew
    z := RecipesPipeline.Surface(density')
    colorbar --> false
    grid --> false
    return ()
end
