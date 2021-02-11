# Adapted from arviz's arviz-darkgrid, arviz-whitegrid, and arviz-white styles, which are in
# turn based on Seaborn styles
const ARVIZ_BASE_THEME = PlotThemes.PlotTheme(;
    size=(720, 480),
    dpi=100,
    widen=true,
    ## Background
    background_color=:white,
    ## Legend
    legend=false,
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
    ## Marker
    markerstrokewidth=0,
    markersize=7,
)

const THEMES = Dict{Symbol,PlotThemes.PlotTheme}(
    :arviz_darkgrid => PlotThemes.PlotTheme(
        ARVIZ_BASE_THEME;
        ## Background
        background_color_inside=colorant"#eeeeee",
        ## Axes / Ticks
        showaxis=true,
        minorticks=false,
        foreground_color_axis=:white,
        foreground_color_border=:white,
        tick_direction=:out,
        ## Grid
        grid=:true,
        gridstyle=:solid,
        gridalpha=1,
        foreground_color_grid=:white,
    ),
    :arviz_whitegrid => PlotThemes.PlotTheme(
        ARVIZ_BASE_THEME;
        ## Background
        background_color_inside=:white,
        ## Axes / Ticks
        framestyle=:box,
        showaxis=true,
        minorticks=false,
        foreground_color_axis=RGB(0.8, 0.8, 0.8),
        foreground_color_border=RGB(0.8, 0.8, 0.8),
        tick_direction=:out,
        ## Grid
        grid=:true,
        gridstyle=:solid,
        gridalpha=1,
        foreground_color_grid=RGB(0.8, 0.8, 0.8),
    ),
    :arviz_white => PlotThemes.PlotTheme(
        ARVIZ_BASE_THEME;
        ## Background
        background_color_inside=:white,
        ## Axes / Ticks
        showaxis=true,
        minorticks=false,
        foreground_color_axis=:white,
        foreground_color_border=:black,
        tick_direction=:out,
        ## Grid
        grid=:false,
        gridalpha=1,
        foreground_color_grid=:black,
    ),
)
