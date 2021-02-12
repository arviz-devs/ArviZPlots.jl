"""
    energyplot(data; kwargs...)
    energyplot!(data; kwargs...)

Plot energy transition distribution and marginal energy distribution in HMC algorithms.

This may help to diagnose poor exploration by gradient-based algorithms like HMC or NUTS.

# Positional Arguments
- `data`: any object that can be converted to an `ArviZ.Dataset` representing a
    `sample_stats` group with an `energy` variable.

# Keyword Arguments
- `kwargs`: Additional attributes understood by Plots.jl. In particular, see keyword
    arguments for [`distplot`](@ref).
"""
RecipesBase.@userplot EnergyPlot

RecipesBase.@recipe function f(p::EnergyPlot; showbfmi=true)
    data = only(p.args)
    energy = ArviZ.convert_to_dataset(data; group=:sample_stats).energy.values
    energy_marginal = vec(energy .- StatsBase.mean(energy))
    energy_trans = vec(diff(energy; dims=2))
    seriestype := distplot
    label := ["Marginal energy" "Energy transition"]
    legend --> :best
    fill --> true
    fillalpha --> [1 0.75]
    grid --> false
    ticks --> nothing
    return [energy_marginal, energy_trans]
end
