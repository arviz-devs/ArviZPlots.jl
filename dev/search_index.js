var documenterSearchIndex = {"docs":
[{"location":"examples/#Examples","page":"Examples","title":"Examples","text":"","category":"section"},{"location":"examples/#Dist-Plot","page":"Examples","title":"Dist Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot an integer distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using Distributions, Plots, ArviZPlots\na = rand(Poisson(4), 1000)\ndistplot(a)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot a continuous distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"b = randn(1000)\ndistplot(b)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Add a rug under the Gaussian distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"distplot(b; showrug=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot as the cumulative distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"distplot(b; showrug=true, cumulative=true)","category":"page"},{"location":"examples/#KDE-Plot","page":"Examples","title":"KDE Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot default KDE","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using Plots, ArviZ, ArviZPlots\nnon_centered = load_arviz_data(\"non_centered_eight\")\nmu_posterior = vec(non_centered.posterior[\"mu\"].values)\ntau_posterior = vec(non_centered.posterior[\"tau\"].values)\nkdeplot(mu_posterior)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot KDE with rugplot","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kdeplot(mu_posterior; showrug=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot the estimated cumulative distribution","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kdeplot(mu_posterior; cumulative=true)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"See kdeplot","category":"page"},{"location":"examples/#d-KDE-Plot","page":"Examples","title":"2d KDE Plot","text":"","category":"section"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d contour KDE","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"using Plots, ArviZ, ArviZPlots\nnon_centered = load_arviz_data(\"non_centered_eight\")\nmu_posterior = vec(non_centered.posterior[\"mu\"].values)\ntau_posterior = vec(non_centered.posterior[\"tau\"].values)\nkde2dplot(mu_posterior, tau_posterior)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d contour KDE, with filling and contour lines using viridis cmap","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kde2dplot(mu_posterior, tau_posterior; fill=true, color=:viridis)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d contour KDE, set the number of levels to 3.","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kde2dplot(mu_posterior, tau_posterior; levels=3)","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"Plot 2d smooth KDE","category":"page"},{"location":"examples/","page":"Examples","title":"Examples","text":"kde2dplot(mu_posterior, tau_posterior; contour=false)","category":"page"},{"location":"reference/#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"","category":"page"},{"location":"reference/#API","page":"Reference","title":"API","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [ArviZPlots]\nPublic = true\nPrivate = false","category":"page"},{"location":"reference/#ArviZPlots.distplot!-Tuple","page":"Reference","title":"ArviZPlots.distplot!","text":"kdeplot(x; kwargs...)\nkdeplot!(x; kwargs...)\n\nPlot distribution as histogram or kernel density estimates.\n\nBy default continuous variables are plotted using KDEs and discrete ones using histograms\n\nPositional Arguments\n\nx: values to plot\n\nKeyword Arguments\n\nkind=:auto: By default (:auto), continuous variables are plotted using KDEs and   discrete ones using histograms. To override this use :hist to plot histograms and :kde   for KDEs\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for kdeplot and histogram.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.distplot-Tuple","page":"Reference","title":"ArviZPlots.distplot","text":"kdeplot(x; kwargs...)\nkdeplot!(x; kwargs...)\n\nPlot distribution as histogram or kernel density estimates.\n\nBy default continuous variables are plotted using KDEs and discrete ones using histograms\n\nPositional Arguments\n\nx: values to plot\n\nKeyword Arguments\n\nkind=:auto: By default (:auto), continuous variables are plotted using KDEs and   discrete ones using histograms. To override this use :hist to plot histograms and :kde   for KDEs\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for kdeplot and histogram.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kde2dplot!-Tuple","page":"Reference","title":"ArviZPlots.kde2dplot!","text":"kde2dplot(x, y; kwargs...)\nkde2dplot!(x, y; kwargs...)\n\nPlot a 2D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: x coordinates of the values\ny: y coordinates of the values\n\nKeyword Arguments\n\ncumulative=true: If true, plot the 2D KDE using contours, otherwise plot a heatmap.\nkwargs: Additional attributes understood by Plots.jl.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kde2dplot-Tuple","page":"Reference","title":"ArviZPlots.kde2dplot","text":"kde2dplot(x, y; kwargs...)\nkde2dplot!(x, y; kwargs...)\n\nPlot a 2D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: x coordinates of the values\ny: y coordinates of the values\n\nKeyword Arguments\n\ncumulative=true: If true, plot the 2D KDE using contours, otherwise plot a heatmap.\nkwargs: Additional attributes understood by Plots.jl.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kdeplot!-Tuple","page":"Reference","title":"ArviZPlots.kdeplot!","text":"kdeplot(x; kwargs...)\nkdeplot!(x; kwargs...)\n\nPlot a 1D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: values\n\nKeyword Arguments\n\ncumulative=false: If true, plot the estimated cumulative distribution function\nshowrug=false: If true, adds a rugplot\nrugspace=0.05: control the y position of the rugplot. The larger this   number the lower the rugplot\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for rugplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#ArviZPlots.kdeplot-Tuple","page":"Reference","title":"ArviZPlots.kdeplot","text":"kdeplot(x; kwargs...)\nkdeplot!(x; kwargs...)\n\nPlot a 1D kernel density estimate (KDE) taking into account boundary conditions.\n\nPositional Arguments\n\nx: values\n\nKeyword Arguments\n\ncumulative=false: If true, plot the estimated cumulative distribution function\nshowrug=false: If true, adds a rugplot\nrugspace=0.05: control the y position of the rugplot. The larger this   number the lower the rugplot\nkwargs: Additional attributes understood by Plots.jl. In particular, see keyword   arguments for rugplot.\n\n\n\n\n\n","category":"method"},{"location":"reference/#Miscellaneous","page":"Reference","title":"Miscellaneous","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [ArviZPlots]\nPublic = false\nPrivate = true","category":"page"},{"location":"reference/#ArviZPlots.rugplot-Tuple{Any}","page":"Reference","title":"ArviZPlots.rugplot","text":"rugplot(x; kwargs...)\nrugplot!(x; kwargs...)\n\nMake a rugplot.\n\nPositional Arguments\n\nx: values\n\nKeyword Arguments\n\nrugmarkershape=:vline: shape of marker\nrugsize=8: size (height) of marker\nrugcolor=:auto: color of marker\nrugalpha=:auto: alpha value (transparency) of marker\nrugposition=0: y-axis position of rug\nkwargs: Additional attributes understood by Plots.jl\n\n\n\n\n\n","category":"method"},{"location":"","page":"Home","title":"Home","text":"CurrentModule = ArviZPlots","category":"page"},{"location":"#ArviZPlots","page":"Home","title":"ArviZPlots","text":"","category":"section"}]
}
