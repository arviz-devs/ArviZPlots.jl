"""
    energyplot(data; kwargs...)
    energyplot!(data; kwargs...)

Plot energy transition distribution and marginal energy distribution in HMC algorithms.

This may help to diagnose poor exploration by gradient-based algorithms like HMC or NUTS.

# Positional Arguments
- `data`: any object that can be converted to an `ArviZ.Dataset` representing a
    `sample_stats` group with an `energy` variable.

# Keyword Arguments
- `showbfmi=true`: If `true` add to the plot the value of the estimated Bayesian fraction of
    missing information.
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`distplot`](@ref).
"""
RecipesBase.@userplot EnergyPlot

RecipesBase.@recipe function f(p::EnergyPlot; showbfmi=true)
    data = only(p.args)
    energy = ArviZ.convert_to_dataset(data; group=:sample_stats).energy.values

    if showbfmi
        bfmi = ArviZ.bfmi(energy)
        nchains = length(bfmi)
        labels = ["Chain $i BFMI = $(@sprintf("%.2f",bfmi[i]))" for i in 1:nchains]
        # hack to just add legend entries
        # TODO: work out how to do this without incrementing color cycle. Ideally would
        # use `primary=false`, but this removes the series from the legend
        RecipesBase.@series begin
            seriestype := :path
            label := permutedims(labels)
            seriesalpha := false
            seriescolor := :white
            [[0] for _ in 1:nchains], [[0] for _ in 1:nchains]
        end
    end

    energy_marginal = vec(energy .- StatsBase.mean(energy))
    energy_trans = vec(diff(energy; dims=2))
    seriestype := distplot
    label := ["Marginal energy" "Energy transition"]
    legend --> :best
    fill --> get(plotattributes, :kind, :default) !== :ecdf
    fillalpha --> [1 0.75]
    # use first 2 colors in color cycle
    seriescolor --> [1 2]
    grid --> false
    ticks --> nothing
    return [energy_marginal, energy_trans]
end
