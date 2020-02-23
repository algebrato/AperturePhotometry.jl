using Documenter, AperturePhotometry

makedocs(;
    modules=[AperturePhotometry],
    format=Documenter.HTML(),
    pages=[
        "Home" => "index.md",
    ],
    repo="https://github.com/algebrato/AperturePhotometry.jl/blob/{commit}{path}#L{line}",
    sitename="AperturePhotometry.jl",
    authors="Stefano Mandelli",
    assets=String[],
)

deploydocs(;
    repo="github.com/algebrato/AperturePhotometry.jl",
)
