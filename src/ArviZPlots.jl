module ArviZPlots

using ArviZ
using Colors: @colorant_str, RGB
using PlotThemes: PlotThemes
using Printf
using RecipesBase: RecipesBase
using RecipesPipeline: RecipesPipeline
using StatsBase: StatsBase

include("util.jl")
include("themes.jl")
include("ingredients.jl")
include("ecdfplot.jl")
include("kdeplot.jl")
include("distplot.jl")
include("energyplot.jl")
include("pairplot.jl")
include("pipeline.jl")

function __init__()
    # We have to add the themes on initialization for PlotThemes to detect them
    for (s, thm) in THEMES
        PlotThemes.add_theme(s, thm)
    end
end

end
