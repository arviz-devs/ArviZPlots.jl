var documenterSearchIndex = {"docs":
[{"location":"examples/#examples","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"examples/#Basic-plotting","page":"Examples","title":"Basic plotting","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Individual variables from InferenceData and ArviZ.Dataset can be plotted using any series type that can operate on the underlying draws.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot histogram (Note that the histogram recipe is defined generally in Plots.jl).","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZ, ArviZPlots, Plots\n\ndata = load_arviz_data(\"centered_eight\")\nhistogram(data; legend=false, bins=20, titlefontsize=8)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot estimated density of posterior and then prior.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"distplot(data; fill=true, alpha=0.5, var_names=[\"mu\"], label=\"posterior\")\ndistplot!(data; fill=true, alpha=0.5, var_names=[\"mu\"], groupname=:prior, label=\"prior\")","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot using the custom :arviz-darkgrid theme (see Themes).","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"theme(:arviz_darkgrid)\ndistplot(data; fill=true, var_names=[\"mu\"])","category":"page"},{"location":"examples/#Dist-Plot","page":"Examples","title":"Dist Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot an integer distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZPlots, Distributions, Plots\ntheme(:arviz_darkgrid)\n\na = rand(Poisson(4), 1000)\ndistplot(a)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot a continuous distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"b = randn(1000)\ndistplot(b)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Add a rug under the Gaussian distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"distplot(b; showrug=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot as the cumulative distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"distplot(b; showrug=true, cumulative=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Compare with the empirical cumulative distribution function","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"c = randn(100)\ndistplot(c; cumulative=true, label=\"KDE CDF\")\ndistplot!(c; kind=:ecdf, label=\"ECDF\", legend=:topleft)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"See distplot","category":"page"},{"location":"examples/#Energy-Plot","page":"Examples","title":"Energy Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot a default energy plot","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZ, ArviZPlots, Plots\ntheme(:arviz_darkgrid)\n\ndata = load_arviz_data(\"centered_eight\")\nenergyplot(data)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Represent energy plot via histograms","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"energyplot(data; kind=:hist, strokewidth=0)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"See energyplot","category":"page"},{"location":"examples/#KDE-Plot","page":"Examples","title":"KDE Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot default KDE","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZ, ArviZPlots, Plots\ntheme(:arviz_darkgrid)\n\nnon_centered = load_arviz_data(\"non_centered_eight\")\nmu_posterior = vec(non_centered.posterior[\"mu\"].values)\ntau_posterior = vec(non_centered.posterior[\"tau\"].values)\nkdeplot(mu_posterior)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot KDE with rugplot","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kdeplot(mu_posterior; showrug=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot the estimated cumulative distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kdeplot(mu_posterior; cumulative=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Rotate plot 90 degrees and fill","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kdeplot(mu_posterior; rotated=true, fill=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"See kdeplot","category":"page"},{"location":"examples/#d-KDE-Plot","page":"Examples","title":"2d KDE Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d contour KDE","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZ, ArviZPlots, Plots\ntheme(:arviz_darkgrid)\n\nnon_centered = load_arviz_data(\"non_centered_eight\")\nmu_posterior = vec(non_centered.posterior[\"mu\"].values)\ntau_posterior = vec(non_centered.posterior[\"tau\"].values)\nkde2dplot(mu_posterior, tau_posterior)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d contour KDE, with filling.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kde2dplot(mu_posterior, tau_posterior; fill=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d contour KDE, set the number of levels to 3.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kde2dplot(mu_posterior, tau_posterior; levels=3)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d smooth KDE","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kde2dplot(mu_posterior, tau_posterior; contour=false)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"See kde2dplot","category":"page"},{"location":"examples/#Pair-Plot","page":"Examples","title":"Pair Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"KDE Pair Plot","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZ, ArviZPlots, Plots\n\ncentered = load_arviz_data(\"centered_eight\")\ncoords = Dict(\"school\"=> [\"Choate\", \"Deerfield\"])\npairplot(\n    centered;\n    var_names=[\"theta\", \"mu\", \"tau\"],\n    kind=:kde,\n    coords=coords,\n    showdivergences=true,\n)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Histogram pair plot","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"pairplot(centered; var_names=[\"theta\", \"mu\"], kind=:hist, coords=coords)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Pair plot showing divergences and select variables with regular expressions","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"pairplot(\n    centered;\n    var_names=[\"^t\", \"mu\"],\n    filter_vars=\"regex\",\n    coords=coords,\n    showdivergences=true,\n)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Pair plot showing layered KDE and scatter with marginal density plots and a point estimate","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"pairplot(\n    centered;\n    var_names=[\"mu\", \"theta\"],\n    kind=[:scatter, :kde],\n    showmarginals=true,\n    coords=coords,\n    point_estimate=:median,\n    linecolor=:black,\n    size=(1000, 800),\n)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"See pairplot","category":"page"},{"location":"examples/#Themes","page":"Examples","title":"Themes","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"ArviZPlots comes with the following themes, which can be activated e.g. using","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZPlots, Plots\n\ntheme(:arviz_darkgrid)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"The available themes are demoed below.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using ArviZPlots, Plots\n\nshowtheme(:arviz_darkgrid)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"showtheme(:arviz_whitegrid)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"showtheme(:arviz_white)","category":"page"},{"location":"reference/#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"","category":"page"},{"location":"reference/#API","page":"Reference","title":"API","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [ArviZPlots]\nPublic = true\nPrivate = false","category":"page"},{"location":"reference/#ArviZPlots.distplot!-Tuple","page":"Reference","title":"ArviZPlots.distplot!","text":"distplot(x; kwargs...)\ndistplot!(x; kwargs...)\n\nPlot distribution as histogram, KDE, or ECDF.\n\nBy default continuous variables are plotted using KDEs and discrete ones using histograms\n\nPositional Arguments\n\nx: values to plot\n\nKeyword Arguments\n\nkind=:auto: By default (:auto), continuous variables are plotted using KDEs and   discrete ones using histograms. The following values can override this behavior:\nkind=:kde: Plot using a kernel density estimate (see kdeplot)\nkind=:hist: Plot using a histogram (see [Plots.histogram]\nkind=:ecdf: Plot using an empirical cumulative distribution function   (see ecdfplot)\ncircular=false: Select input type in (:radians, :degrees) for circular histogram or   KDE plot. If true, default input type is :radians. Pass projection=:polar to also   plot on a polar axis; however, this will not plot correctly when circular=:degrees.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for kdeplot and histogram.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.distplot-Tuple","page":"Reference","title":"ArviZPlots.distplot","text":"distplot(x; kwargs...)\ndistplot!(x; kwargs...)\n\nPlot distribution as histogram, KDE, or ECDF.\n\nBy default continuous variables are plotted using KDEs and discrete ones using histograms\n\nPositional Arguments\n\nx: values to plot\n\nKeyword Arguments\n\nkind=:auto: By default (:auto), continuous variables are plotted using KDEs and   discrete ones using histograms. The following values can override this behavior:\nkind=:kde: Plot using a kernel density estimate (see kdeplot)\nkind=:hist: Plot using a histogram (see [Plots.histogram]\nkind=:ecdf: Plot using an empirical cumulative distribution function   (see ecdfplot)\ncircular=false: Select input type in (:radians, :degrees) for circular histogram or   KDE plot. If true, default input type is :radians. Pass projection=:polar to also   plot on a polar axis; however, this will not plot correctly when circular=:degrees.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for kdeplot and histogram.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.energyplot!-Tuple","page":"Reference","title":"ArviZPlots.energyplot!","text":"energyplot(data; kwargs...)\nenergyplot!(data; kwargs...)\n\nPlot energy transition distribution and marginal energy distribution in HMC algorithms.\n\nThis may help to diagnose poor exploration by gradient-based algorithms like HMC or NUTS.\n\nPositional Arguments\n\ndata: any object that can be converted to an ArviZ.Dataset representing a   sample_stats group with an energy variable.\n\nKeyword Arguments\n\nshowbfmi=true: If true add to the plot the value of the estimated Bayesian fraction of   missing information.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for distplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.energyplot!-Tuple{AbstractPlot,Vararg{Any,N} where N}","page":"Reference","title":"ArviZPlots.energyplot!","text":"energyplot(data; kwargs...)\nenergyplot!(data; kwargs...)\n\nPlot energy transition distribution and marginal energy distribution in HMC algorithms.\n\nThis may help to diagnose poor exploration by gradient-based algorithms like HMC or NUTS.\n\nPositional Arguments\n\ndata: any object that can be converted to an ArviZ.Dataset representing a   sample_stats group with an energy variable.\n\nKeyword Arguments\n\nshowbfmi=true: If true add to the plot the value of the estimated Bayesian fraction of   missing information.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for distplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.energyplot-Tuple","page":"Reference","title":"ArviZPlots.energyplot","text":"energyplot(data; kwargs...)\nenergyplot!(data; kwargs...)\n\nPlot energy transition distribution and marginal energy distribution in HMC algorithms.\n\nThis may help to diagnose poor exploration by gradient-based algorithms like HMC or NUTS.\n\nPositional Arguments\n\ndata: any object that can be converted to an ArviZ.Dataset representing a   sample_stats group with an energy variable.\n\nKeyword Arguments\n\nshowbfmi=true: If true add to the plot the value of the estimated Bayesian fraction of   missing information.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for distplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kde2dplot!-Tuple","page":"Reference","title":"ArviZPlots.kde2dplot!","text":"kde2dplot(x, y; kwargs...)\nkde2dplot!(x, y; kwargs...)\n\nPlot a 2D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: x coordinates of the values\ny: y coordinates of the values\n\nKeyword Arguments\n\ncontour=true: If true, plot the 2D KDE using contours, otherwise plot a heatmap.\nkwargs: Additional attributes understood by Plots.jl.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kde2dplot-Tuple","page":"Reference","title":"ArviZPlots.kde2dplot","text":"kde2dplot(x, y; kwargs...)\nkde2dplot!(x, y; kwargs...)\n\nPlot a 2D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: x coordinates of the values\ny: y coordinates of the values\n\nKeyword Arguments\n\ncontour=true: If true, plot the 2D KDE using contours, otherwise plot a heatmap.\nkwargs: Additional attributes understood by Plots.jl.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kdeplot!-Tuple","page":"Reference","title":"ArviZPlots.kdeplot!","text":"kdeplot(x[, y]; kwargs...)\nkdeplot!(x[, y]; kwargs...)\n\nPlot a 1D or 2D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: Values to plot.\ny: Values to plot. If present, a 2D KDE will be estimated. See kde2dplot.\n\nKeyword Arguments\n\nbw=:default: If numeric, indicates the bandwidth and must be positive. If Symbol,   indicates the method to estimate the bandwidth and must be one of :scott,   :silverman, :isj or :experimental when circular=false and :taylor (for now)   when circular=true. :default means :experimental when variable is not circular   and :taylor when it is.\ncircular=false: Select input type in (:radians, :degrees) for circular KDE plot. If   true, default input type is :radians. Pass projection=:polar to also plot on a   polar axis; however, this will not plot correctly when circular=:degrees.\ncumulative=false: If true, plot the estimated cumulative distribution function\nshowrug=false: If true, adds a rugplot\nrugspace=0.05: control the y position of the rugplot. The larger this   number the lower the rugplot\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for kde2dplot and rugplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kdeplot-Tuple","page":"Reference","title":"ArviZPlots.kdeplot","text":"kdeplot(x[, y]; kwargs...)\nkdeplot!(x[, y]; kwargs...)\n\nPlot a 1D or 2D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: Values to plot.\ny: Values to plot. If present, a 2D KDE will be estimated. See kde2dplot.\n\nKeyword Arguments\n\nbw=:default: If numeric, indicates the bandwidth and must be positive. If Symbol,   indicates the method to estimate the bandwidth and must be one of :scott,   :silverman, :isj or :experimental when circular=false and :taylor (for now)   when circular=true. :default means :experimental when variable is not circular   and :taylor when it is.\ncircular=false: Select input type in (:radians, :degrees) for circular KDE plot. If   true, default input type is :radians. Pass projection=:polar to also plot on a   polar axis; however, this will not plot correctly when circular=:degrees.\ncumulative=false: If true, plot the estimated cumulative distribution function\nshowrug=false: If true, adds a rugplot\nrugspace=0.05: control the y position of the rugplot. The larger this   number the lower the rugplot\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for kde2dplot and rugplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.pairplot!-Tuple","page":"Reference","title":"ArviZPlots.pairplot!","text":"pairplot(data)\npairplot!(data)\n\nPlot a scatter, kde and/or hexbin matrix with (optional) marginals on the diagonal.\n\nPositional Arguments\n\ndata: Any object that can be converted to an ArviZ.InferenceData object.   See ArviZ.convert_to_inference_data for details.\n\nKeyword Arguments\n\ngroup=:posterior: Specifies which InferenceData group should be plotted.\nvar_names=nothing: Variables to be plotted. Prefix the variables by ~   to exclude them from the plot. Behavior modified by filter_vars.\nfilter_vars=nothing: interpret var_names as\nfilter_vars=nothing: real variables names\nfilter_vars=\"like\": substrings of the real variables names\nfilter_vars=\"regex\": regular expressions on the real variables names\ncoords=Dict(): Specific coordinates of var_names to be plotted\nshowmarginals=false: If true, pairplot will include marginal distributions for every   variable\nkind=:scatter: Type of plot to display or list of types. Supported types are:\nscatter\nkde/kdeplot/kde2dplot\nhist/histogram2d\nhexbin (Note that most backends do not support this series type)\nshowdivergences=false: If true, divergences will be plotted in a different color, only   if group is either :prior or :posterior.\ndivergencescolor: Color of divergences markers.\npoint_estimate=nothing: Select point estimate from :mean, :mode or :median. The   point estimate will be plotted using a scatter marker and vertical/horizontal lines.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for distplot, kdeplot, and kde2dplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.pairplot!-Tuple{AbstractPlot,Vararg{Any,N} where N}","page":"Reference","title":"ArviZPlots.pairplot!","text":"pairplot(data)\npairplot!(data)\n\nPlot a scatter, kde and/or hexbin matrix with (optional) marginals on the diagonal.\n\nPositional Arguments\n\ndata: Any object that can be converted to an ArviZ.InferenceData object.   See ArviZ.convert_to_inference_data for details.\n\nKeyword Arguments\n\ngroup=:posterior: Specifies which InferenceData group should be plotted.\nvar_names=nothing: Variables to be plotted. Prefix the variables by ~   to exclude them from the plot. Behavior modified by filter_vars.\nfilter_vars=nothing: interpret var_names as\nfilter_vars=nothing: real variables names\nfilter_vars=\"like\": substrings of the real variables names\nfilter_vars=\"regex\": regular expressions on the real variables names\ncoords=Dict(): Specific coordinates of var_names to be plotted\nshowmarginals=false: If true, pairplot will include marginal distributions for every   variable\nkind=:scatter: Type of plot to display or list of types. Supported types are:\nscatter\nkde/kdeplot/kde2dplot\nhist/histogram2d\nhexbin (Note that most backends do not support this series type)\nshowdivergences=false: If true, divergences will be plotted in a different color, only   if group is either :prior or :posterior.\ndivergencescolor: Color of divergences markers.\npoint_estimate=nothing: Select point estimate from :mean, :mode or :median. The   point estimate will be plotted using a scatter marker and vertical/horizontal lines.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for distplot, kdeplot, and kde2dplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.pairplot-Tuple","page":"Reference","title":"ArviZPlots.pairplot","text":"pairplot(data)\npairplot!(data)\n\nPlot a scatter, kde and/or hexbin matrix with (optional) marginals on the diagonal.\n\nPositional Arguments\n\ndata: Any object that can be converted to an ArviZ.InferenceData object.   See ArviZ.convert_to_inference_data for details.\n\nKeyword Arguments\n\ngroup=:posterior: Specifies which InferenceData group should be plotted.\nvar_names=nothing: Variables to be plotted. Prefix the variables by ~   to exclude them from the plot. Behavior modified by filter_vars.\nfilter_vars=nothing: interpret var_names as\nfilter_vars=nothing: real variables names\nfilter_vars=\"like\": substrings of the real variables names\nfilter_vars=\"regex\": regular expressions on the real variables names\ncoords=Dict(): Specific coordinates of var_names to be plotted\nshowmarginals=false: If true, pairplot will include marginal distributions for every   variable\nkind=:scatter: Type of plot to display or list of types. Supported types are:\nscatter\nkde/kdeplot/kde2dplot\nhist/histogram2d\nhexbin (Note that most backends do not support this series type)\nshowdivergences=false: If true, divergences will be plotted in a different color, only   if group is either :prior or :posterior.\ndivergencescolor: Color of divergences markers.\npoint_estimate=nothing: Select point estimate from :mean, :mode or :median. The   point estimate will be plotted using a scatter marker and vertical/horizontal lines.\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for distplot, kdeplot, and kde2dplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Miscellaneous","page":"Reference","title":"Miscellaneous","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [ArviZPlots]\nPublic = false\nPrivate = true","category":"page"},{"location":"reference/#ArviZPlots.ecdfplot-Tuple{Any}","page":"Reference","title":"ArviZPlots.ecdfplot","text":"ecdfplot(x; kwargs...)\necdfplot!(x; kwargs...)\n\nPlot the empirical cumulative distribution function (ECDF) of the data x.\n\nPositional Arguments\n\nx: Values to plot\n\nKeyword Arguments\n\nweights=nothing: Vector of weights to be used for a weighted ECDF\nkwargs: Additional attributes understood by Plots.jl\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.rugplot-Tuple{Any}","page":"Reference","title":"ArviZPlots.rugplot","text":"rugplot(x; kwargs...)\nrugplot!(x; kwargs...)\n\nMake a rugplot.\n\nPositional Arguments\n\nx: values\n\nKeyword Arguments\n\nrugmarkershape=:auto: shape of marker, defaulting to perpendicular to the data axis\nrugsize=8: size (height) of marker\nrugcolor=:auto: color of marker\nrugalpha=:auto: alpha value (transparency) of marker\nrugposition=0: position of rug on non-data axis\nkwargs: Additional attributes understood by Plots.jl\n\n\n\n\n\n","category":"method"},{"location":"reference/#RecipesBase.plot-Tuple{ArviZ.Dataset}","page":"Reference","title":"RecipesBase.plot","text":"plot(data::ArviZ.Dataset; kwargs...)\nplot!(data::ArviZ.Dataset; kwargs...)\n\nPlot the specified group of data using kwargs attributes recognized by Plots.\n\ndata is split into individual subplots based on the provided keyword arguments. Chain number for each draw is stored in the plot attribute chain and can be used by series recipes.\n\nPositional Arguments\n\ndata: an ArviZ.Dataset object.\n\nKeyword Arguments\n\nvar_names=nothing: Variables to be plotted. Prefix the variables by ~   to exclude them from the plot. Behavior modified by filter_vars.\nfilter_vars=nothing: interpret var_names as\nfilter_vars=nothing: real variables names\nfilter_vars=\"like\": substrings of the real variables names\nfilter_vars=\"regex\": regular expressions on the real variables names\ncoords=Dict(): Specific coordinates of var_names to be plotted\nkwargs: Additional attributes understood by Plots.jl\n\n\n\n\n\n","category":"method"},{"location":"reference/#RecipesBase.plot-Tuple{InferenceData}","page":"Reference","title":"RecipesBase.plot","text":"plot(data::InferenceData; groupname=:posterior, kwargs...)\nplot!(data::InferenceData; groupname=:posterior, kwargs...)\n\nPlot the specified group of data using kwargs attributes recognized by Plots.\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = ArviZPlots","category":"page"},{"location":"#ArviZPlots","page":"Home","title":"ArviZPlots","text":"","category":"section"},{"location":"","page":"Home","title":"Home","text":"ArviZPlots provides experimental Plots.jl integration to ArviZ.jl. ","category":"page"},{"location":"","page":"Home","title":"Home","text":"See Examples for currently supported plots.","category":"page"}]
}
