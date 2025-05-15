```@meta
CurrentModule = ProtectedArrays
```

# ProtectedArrays

Documentation for [ProtectedArrays](https://github.com/FedericoStra/ProtectedArrays.jl).

```jldoctest
julia> using ProtectedArrays

julia> a = zeros(2, 5)
2×5 Matrix{Float64}:
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0

julia> pa = protect(a)
2×5 ProtectedMatrix(::Matrix{Float64}) with eltype Float64:
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0

julia> pa[1] = 1.
ERROR: `ProtectedArray` does not allow modifying elements with `setindex!`,
       use `unprotect` if you really know what you're doing.
[...]

julia> pa[1, 1] = 1.
ERROR: `ProtectedArray` does not allow modifying elements with `setindex!`,
       use `unprotect` if you really know what you're doing.
[...]

julia> pa[:, 1] .= 1.
ERROR: `ProtectedArray` does not allow modifying elements with `setindex!`,
       use `unprotect` if you really know what you're doing.
[...]

julia> fill!(pa, 1.)
ERROR: `ProtectedArray` does not allow modifying elements with `setindex!`,
       use `unprotect` if you really know what you're doing.
[...]

julia> a # unmodified
2×5 Matrix{Float64}:
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0
```

## API

```@index
```

```@autodocs
Modules = [ProtectedArrays]
```
