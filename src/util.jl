isrotated(plotattributes) = get(plotattributes, :rotated, false)

function make_label(var_name, selection)
    label = String(ArviZ.arviz.plots.plot_utils.make_label(var_name, selection))
    return replace(label, '\n' => ' ')
end

get_bins(x) = ArviZ.arviz.stats.density_utils.get_bins(x)
