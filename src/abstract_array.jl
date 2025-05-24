# Abstract array interface.
#
# See <https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-array>.

Base.IndexStyle(::Type{ProtectedArray{T, N, A}}) where {T, N, A} = Base.IndexStyle(A)

@inline Base.axes(pa::ProtectedArray) = axes(parent(pa))
# Defining `axes(pa::ProtectedArray, d)` is superfluous because there is already
# `axes(a::AbstractArray, d)` that does the correct thing.

"""
    similar(pa::ProtectedArray, eltype=eltype(pa), dims=size(pa))

Create an uninitialized mutable array based on the underlying array `parent(pa)`
wrapped by [`ProtectedArray`](@ref).
"""
function Base.similar(pa::ProtectedArray, ::Type{T}, dims::Dims) where {T}
    return similar(parent(pa), T, dims)
end
