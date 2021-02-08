using ArviZPlots
using Documenter

makedocs(;
    modules=[ArviZPlots],
    authors="Seth Axen <seth.axen@gmail.com> and contributors",
    repo="https://github.com/arviz-devs/ArviZPlots.jl/blob/{commit}{path}#L{line}",
    sitename="ArviZPlots.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://arviz-devs.github.io/ArviZPlots.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/arviz-devs/ArviZPlots.jl",
)
