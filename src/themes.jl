# Adapted from arviz's arviz-darkgrid, which in turn is based on Seaborn-darkgrid
const THEMES = Dict{Symbol,PlotThemes.PlotTheme}(
    :arviz_darkgrid => PlotThemes.PlotTheme(;
        size=(720, 480),
        dpi=100,
        widen=true,
        ## Background
        background_color=:white,
        background_color_inside=colorant"#eeeeee",
        background_color_legend=false,
        foreground_color_legend=false,
        ## Font styles
        ## these font sizes are technically part of the theme, but they look terrible here
        # legendfontsize=15,
        # titlefontsize=16,
        # guidefontsize=15,
        # tickfontsize=14,
        plot_titlefontcolor=RGB(0.15, 0.15, 0.15),
        legendfontcolor=RGB(0.15, 0.15, 0.15),
        legendtitlefontcolor=RGB(0.15, 0.15, 0.15),
        titlefontcolor=RGB(0.15, 0.15, 0.15),
        foreground_color_text=RGB(0.15, 0.15, 0.15),
        guidefontcolor=RGB(0.15, 0.15, 0.15),
        tickfontcolor=RGB(0.15, 0.15, 0.15),
        ## Colors
        color_palette=[
            colorant"#2a2eec",
            colorant"#fa7c17",
            colorant"#328c06",
            colorant"#c10c90",
            colorant"#933708",
            colorant"#65e5f3",
            colorant"#e6e135",
            colorant"#1ccd6a",
            colorant"#bd8ad5",
            colorant"#b16b57",
        ],
        colorgradient=:viridis,
        ## Axes / Ticks
        showaxis=false,
        minorticks=false,
        foreground_color_axis=:white,
        foreground_color_border=:white,
        tick_direction=:out,
        ## Grid
        grid=:true,
        gridstyle=:solid,
        gridalpha=1,
        foreground_color_grid=:white,
        ## Marker
        markerstrokewidth=0,
        markerstrokecolor=:match,
        markersize=7,
    ),
)
