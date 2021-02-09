RecipesBase.@recipe function f(::Type{Val{:distplot}}, x, y, z; kind = :auto)
    if kind == :hist || all(isinteger, y)
        seriestype := :barhist
        normalize --> :pdf
    else
        seriestype := :kdeplot
    end
    ()
end

RecipesBase.@shorthands distplot
