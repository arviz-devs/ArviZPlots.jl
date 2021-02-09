module ArviZPlots

using KernelDensity: KernelDensity
using RecipesBase: RecipesBase
using RecipesPipeline: RecipesPipeline

include("ingredients.jl")
include("kdeplot.jl")
include("distplot.jl")

end
