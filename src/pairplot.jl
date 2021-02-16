"""
    pairplot(data)
    pairplot!(data)

Plot a scatter, kde and/or hexbin matrix with (optional) marginals on the diagonal.

# Positional Arguments
- `data`: Any object that can be converted to an `ArviZ.InferenceData` object.
    See `ArviZ.convert_to_inference_data` for details.

# Keyword Arguments
- `group=:posterior`: Specifies which `InferenceData` group should be plotted.
- `var_names=nothing`: Variables to be plotted. Prefix the variables by `~`
    to exclude them from the plot. Behavior modified by `filter_vars`.
- `filter_vars=nothing`: interpret `var_names` as
    + `filter_vars=nothing`: real variables names
    + `filter_vars="like"`: substrings of the real variables names
    + `filter_vars="regex"`: regular expressions on the real variables names
- `coords=Dict()`: Specific coordinates of `var_names` to be plotted
- `showmarginals=false`: If `true`, pairplot will include marginal distributions for every
    variable
- `kind=:scatter`: Type of plot to display or list of types. Supported types are:
    + `scatter`
    + `kde`/`kdeplot`/`kde2dplot`
    + `hist`/`histogram2d`
    + `hexbin` (Note that most backends do not support this series type)
- `showdivergences=false`: If `true`, divergences will be plotted in a different color, only
    if group is either `:prior` or `:posterior`.
- `divergencescolor`: Color of divergences markers.
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`distplot`](@ref), [`kdeplot`](@ref), and [`kde2dplot`](@ref).
"""
RecipesBase.@userplot PairPlot

RecipesBase.@recipe function f(
    plt::PairPlot;
    group=:posterior,
    var_names=nothing,
    filter_vars=nothing,
    coords=Dict(),
    showmarginals=false,
    kind=:scatter,
    showdivergences=false,
    divergencescolor=2,
)
    data = convert(InferenceData, only(plt.args))
    dataset = ArviZ.convert_to_dataset(data; group=group)

    if showdivergences
        samplestats_group = group === :prior ? :sample_stats_prior : :sample_stats
        divergent = vec(
            ArviZ.convert_to_dataset(data; group=samplestats_group).diverging.values
        )
    end

    # standardize seriestype names
    pair_seriestypes = kind isa Symbol ? [kind] : kind
    pair_seriestypes[pair_seriestypes .∈ Ref((:kde, :kdeplot))] .= Ref(:kde2dplot)
    pair_seriestypes[pair_seriestypes .=== :hist] .= Ref(:histogram2d)

    # ensure sensible layering
    ordered_pair_seriestypes = [:histogram2d, :hexbin]
    if (
        get(plotattributes, :fillrange, nothing) !== nothing ||
        !get(plotattributes, :contour, true)
    )
        append!(ordered_pair_seriestypes, [:kde2dplot, :scatter])
    else
        append!(ordered_pair_seriestypes, [:scatter, :kde2dplot])
    end
    pair_seriestypes = filter(in(pair_seriestypes), ordered_pair_seriestypes)

    var_names = ArviZ.arviz.utils._var_names(var_names, dataset, filter_vars)
    plotters = collect(
        ArviZ.arviz.plots.plot_utils.xarray_var_iter(
            ArviZ.arviz.utils.get_coords(dataset, coords);
            var_names=var_names,
            combined=true,
        ),
    )
    flat_var_names = [make_label(var_name, selection) for (var_name, selection) in plotters]
    num_vars = length(flat_var_names)
    if num_vars < 2
        throw(ArgumentError("Number of variables to be plotted must be 2 or greater"))
    end

    num_subplot_cols = num_vars - 1 + showmarginals
    max_plots = if ArviZ.rcParams["plot.max_subplots"] === nothing
        num_subplot_cols^2
    else
        ArviZ.rcParams["plot.max_subplots"]
    end
    cols_to_plot = count(≤(max_plots), cumsum(1:num_subplot_cols))
    if cols_to_plot < num_subplot_cols
        vars_to_plot = cols_to_plot
        @warn """ArviZ.rcParams["plot.max_subplots"] ($max_plots) is smaller than the """ *
              "number of resulting pair plots with these variables, generating only a " *
              "$vars_to_plot×$vars_to_plot grid"
    else
        vars_to_plot = num_vars - 1 + showmarginals
    end

    layout := (vars_to_plot, vars_to_plot)
    if showmarginals
        # can't link y-axes because distplot uses a different scale, so we at least link
        # the columns
        link := :x
    else
        link := :both
    end
    grid --> false
    margin --> 0mm
    left_margin --> 1mm
    bottom_margin --> 1mm

    subplot_indices = reshape(1:(vars_to_plot^2), vars_to_plot, vars_to_plot)'
    for j in 1:vars_to_plot
        xvar = vec(plotters[j][end])
        xmin, xmax = extrema(xvar)
        for i in 1:vars_to_plot
            if i ≥ j + showmarginals
                yvar = vec(plotters[i + 1 - showmarginals][end])
                ymin, ymax = extrema(yvar)
                for pair_seriestype in pair_seriestypes
                    isprimary =
                        length(pair_seriestypes) == 1 || pair_seriestype === :scatter
                    RecipesBase.@series begin # pair distribution
                        seriestype := pair_seriestype
                        primary := isprimary
                        subplot := subplot_indices[i, j]
                        x := xvar
                        y := yvar
                        if showmarginals
                            xlims := widen(xmin, xmax)
                            ylims := widen(ymin, ymax)
                        end
                        if pair_seriestype === :scatter
                            markersize --> 1.5
                            # allow using fill=true to fill contour without filling scatter
                            fill := false
                        end
                        bins --> round.(Int, length.((xvar, yvar)) .^ 0.35)
                        if pair_seriestype === :hexbin
                            # PyPlot-specific arguments, see https://github.com/JuliaPlots/Plots.jl/pull/3302
                            update_plot_extra_kwargs!(
                                plotattributes,
                                :series,
                                Dict(:mincnt => 1, :edgecolors => :face),
                            )
                        end
                        label := ""
                        ()
                    end
                end
                # plot divergences
                showdivergences && RecipesBase.@series begin
                    seriestype := :scatter
                    subplot := subplot_indices[i, j]
                    x := view(xvar, divergent)
                    y := view(yvar, divergent)
                    xlims := widen(xmin, xmax)
                    markercolor := divergencescolor
                    markersize --> 3
                    markerstrokewidth --> 1
                    fill := false
                    label := "divergent"
                    ()
                end
            elseif showmarginals && i == j
                # plot marginal
                # TODO: special-case for vars_to_plot==2
                RecipesBase.@series begin
                    seriestype := :distplot
                    subplot := subplot_indices[j, j]
                    label := ""
                    tuple(xvar)
                end
            else
                # make empty plot
                RecipesBase.@series begin
                    seriestype := :_emptyplot
                    subplot := subplot_indices[i, j]
                    ()
                end
                continue
            end
            # reset guides, ticks, and legends
            RecipesBase.@series begin
                primary := false
                subplot := subplot_indices[i, j]
                xguide := i === vars_to_plot ? flat_var_names[j] : ""
                yguide := j === 1 ? flat_var_names[i + 1 - showmarginals] : ""
                xticks := i === vars_to_plot ? :auto : nothing
                yticks := j === 1 ? :auto : nothing
                legend --> false
                ()
            end
        end
    end
    # this user plot's data should not populate any of the subplots
    x := nothing
    y := nothing
    return nothing
end

# reset all unused panes to be completely empty
# NOTE: tested with our packaged themes and several themes in RecipesBase
RecipesBase.@recipe function f(::Type{Val{:_emptyplot}}, x, y, z)
    seriestype := :path
    primary := false  # don't show up in legend or increment color cycle
    showaxis := false  # hide axes and guides
    ticks := false  # hide ticks
    background_color_inside := :match  # reset to match pane color
    x := nothing
    y := nothing
    return ()
end
