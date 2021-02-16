isrotated(plotattributes) = get(plotattributes, :rotated, false)

function make_label(var_name, selection)
    label = String(ArviZ.arviz.plots.plot_utils.make_label(var_name, selection))
    return replace(label, '\n' => ' ')
end

function update_plot_extra_kwargs!(plotattributes, group, group_extra_kwargs)
    extra_kwargs = Dict{Any,Any}(get(plotattributes, :extra_kwargs, Dict{Any,Any}()))
    group_kwargs = Dict{Any,Any}(get(extra_kwargs, group, Dict{Any,Any}()))
    extra_kwargs[group] = merge(group_extra_kwargs, group_kwargs)
    plotattributes[:extra_kwargs] = extra_kwargs
    return plotattributes
end

get_bins(x) = ArviZ.arviz.stats.density_utils.get_bins(x)

function calculate_point_estimate(point_estimate::Union{String,Symbol}, values; kwargs...)
    return ArviZ.arviz.plots.plot_utils.calculate_point_estimate(point_estimate, values; kwargs...)
end
function calculate_point_estimate(point_estimate, values; kwargs...)
    return calculate_point_estimate("$point_estimate", values; kwargs...)
end

# adapted from Plots
function widen(lmin, lmax, scale=:identity)
    f, invf = RecipesPipeline.scale_func(scale), RecipesPipeline.inverse_scale_func(scale)
    span = f(lmax) - f(lmin)
    eps = max(1e-16, 0.03span)
    return invf(f(lmin) - eps), invf(f(lmax) + eps)
end
