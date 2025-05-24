using ProtectedArrays
using Documenter
using DocumenterInterLinks

DocMeta.setdocmeta!(ProtectedArrays, :DocTestSetup, :(using ProtectedArrays); recursive = true)

makedocs(;
    modules = [ProtectedArrays],
    authors = "Federico Stra <stra.federico@gmail.com> and contributors",
    sitename = "ProtectedArrays.jl",
    format = Documenter.HTML(;
        canonical = "https://FedericoStra.github.io/ProtectedArrays.jl",
        edit_link = "master",
        assets = String[],
    ),
    pages = [
        "Home" => "index.md",
    ],
    plugins = [
        InterLinks(
            "Julia" => "https://docs.julialang.org/en/v1/"
        ),
    ]
)

deploydocs(;
    repo = "github.com/FedericoStra/ProtectedArrays.jl",
    devbranch = "master",
)
