module ArviZPlots

using ArviZ
using RecipesBase: RecipesBase
using RecipesPipeline: RecipesPipeline

include("util.jl")
include("ingredients.jl")
include("kdeplot.jl")
include("distplot.jl")
include("pipeline.jl")

end
