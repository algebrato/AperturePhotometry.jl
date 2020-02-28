```@meta
DocTestSetup = quote
    using AperturePhotometry
end
```

# AperturePhotometry User's Manual

An interface to reduce astronomical images and perform differential Aperture
Photometry of variable stars. `Aperturephotometry` can also be used to calibrate, align and stack an images stream in order to do also imaging and not only photometry reduction. The code was written from scratch in `Julia`, and it is compatible with `Julia1.0` or newest version.

To install `AperturePhotometry`, start Julia and type the following command:
```julia
using Pkg
Pkg.add("https://github.com/algebrato/AperturePhotometry.jl")
```

To run the test suite, type the following command:
```julia
using Pkg; Pkg.test("AperturePhotometry")
```

In order to save time and avoid possible mistype, I would like to suggest to import the `AperturePhotometry` module as

```julia
import AperturePhotmetry
const Ap = AperturePhotometry
```

In this way you can call all his functions using `Ap.function(**kwargs)`

## Documentation

The documentation was built using
[Documenter.jl](https://github.com/JuliaDocs).

```@example
import Dates: now #hide
println("Documentation built $(now()) with Julia $(VERSION).") # hide
```

## Index

```@index
```
