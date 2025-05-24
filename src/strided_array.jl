# Strided array interface.
#
# See <https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-strided-arrays>.

@inline Base.strides(pa::ProtectedArray) = strides(parent(pa))

# Ideally one would like not to define `stride(pa::ProtectedArray, k::Integer)`
# and let `stride(a::AbstractArray, k::Integer)` handle it. Unfortunately,
# even if `size(pa) == size(parent(pa))` and `strides(pa) == strides(parent(pa))`,
# the method of `stride` for `AbstractArray` messes things up and could return
# `stride(pa, k) != stride(parent(pa), k)` when `k > ndims(pa)`.
#
# See <https://github.com/JuliaLang/julia/issues/58403> for a discussion.
#
# Therefore, for the time being we have to override `stride` ourselves.
#
# See <https://github.com/FedericoStra/NextStride.jl> for a possible alternative.
@inline Base.stride(pa::ProtectedArray, k::Integer) = stride(parent(pa), k)

@inline Base.elsize(::Type{ProtectedArray{T, N, A}}) where {T, N, A} = Base.elsize(A)

@inline function Base.unsafe_convert(::Type{Ptr{T}}, pa::ProtectedArray{T}) where {T}
    return Base.unsafe_convert(Ptr{T}, parent(pa))
end
