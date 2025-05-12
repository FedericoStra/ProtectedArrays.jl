# Strided array interface.
#
# See <https://docs.julialang.org/en/v1/manual/interfaces/#man-interface-strided-arrays>.

@inline Base.strides(pa::ProtectedArray) = strides(parent(pa))

@inline Base.elsize(::Type{ProtectedArray{T,N,A}}) where {T,N,A} = Base.elsize(A)

@inline function Base.unsafe_convert(::Type{Ptr{T}}, pa::ProtectedArray{T}) where T
    Base.unsafe_convert(Ptr{T}, parent(pa))
end
