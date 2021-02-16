"""
    plot(data::InferenceData; groupname=:posterior, kwargs...)
    plot!(data::InferenceData; groupname=:posterior, kwargs...)

Plot the specified group of `data` using `kwargs` attributes recognized by Plots.
"""
RecipesBase.plot(::ArviZ.InferenceData; kwargs...)

RecipesBase.@recipe function f(
    ::Type{T}, data::T; groupname=:posterior
) where {T<:InferenceData}
    return tuple(ArviZ.convert_to_dataset(data; group=groupname))
end

"""
    plot(data::ArviZ.Dataset; kwargs...)
    plot!(data::ArviZ.Dataset; kwargs...)

Plot the specified group of `data` using `kwargs` attributes recognized by Plots.

`data` is split into individual subplots based on the provided keyword arguments.
Chain number for each draw is stored in the plot attribute `chain` and can be used by series
recipes.

# Positional Arguments
- `data`: an `ArviZ.Dataset` object.

# Keyword Arguments
- `var_names=nothing`: Variables to be plotted. Prefix the variables by `~`
    to exclude them from the plot. Behavior modified by `filter_vars`.
- `filter_vars=nothing`: interpret `var_names` as
    + `filter_vars=nothing`: real variables names
    + `filter_vars="like"`: substrings of the real variables names
    + `filter_vars="regex"`: regular expressions on the real variables names
- `coords=Dict()`: Specific coordinates of `var_names` to be plotted
- `kwargs`: Additional attributes understood by Plots.jl
"""
RecipesBase.plot(::ArviZ.Dataset; kwargs...)

RecipesBase.@recipe function f(
    ::Type{T}, data::T; var_names=nothing, coords=Dict(), filter_vars=nothing
) where {T<:ArviZ.Dataset}
    var_names = ArviZ.arviz.utils._var_names(var_names, data, filter_vars)
    plotters = collect(
        ArviZ.arviz.plots.plot_utils.xarray_var_iter(
            ArviZ.arviz.utils.get_coords(data, coords); var_names=var_names, combined=true
        ),
    )
    titles = String[]
    series_values = Vector{<:Real}[]
    chains = Vector{Int}[]
    for (var_name, selection, values) in plotters
        label = make_label(var_name, selection)
        push!(titles, label)
        push!(series_values, vec(values))
        sz = size(values)
        push!(chains, repeat(1:sz[1], prod(sz[2:end])))
    end
    layout := length(plotters)
    title --> permutedims(titles)
    # TODO: find a way to split chains across subplots.
    chain := permutedims(chains)
    return tuple(series_values)
end
