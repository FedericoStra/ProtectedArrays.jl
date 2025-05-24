# Iteration interface.
#
# See <https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-iteration>.

Base.IteratorSize(::Type{ProtectedArray{T, N, A}}) where {T, N, A} = Base.IteratorSize(A)
@inline Base.length(pa::ProtectedArray) = length(parent(pa))
@inline Base.size(pa::ProtectedArray) = size(parent(pa))
# Defining `size(pa::ProtectedArray, d)` is superfluous because there is already
# `size(a::AbstractArray, d)` that does the correct thing.

Base.IteratorEltype(::Type{ProtectedArray{T, N, A}}) where {T, N, A} = Base.IteratorEltype(A)
@inline Base.eltype(::Type{ProtectedArray{T, N, A}}) where {T, N, A} = eltype(A)

@inline Base.isdone(pa::ProtectedArray, state...) = Base.isdone(parent(pa), state...)

@inline Base.iterate(pa::ProtectedArray, state...) = iterate(parent(pa), state...)
