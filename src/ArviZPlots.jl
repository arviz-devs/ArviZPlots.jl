module ArviZPlots

using KernelDensity: KernelDensity
using RecipesBase: RecipesBase
using RecipesPipeline: RecipesPipeline

include("util.jl")
include("ingredients.jl")
include("kdeplot.jl")
include("distplot.jl")

end
