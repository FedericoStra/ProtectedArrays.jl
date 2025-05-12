module ProtectedArrays

export ProtectedArray, ProtectedMatrix, ProtectedVector, protect, unprotect

"""

    ProtectedArray(array)

Wrapper around an array which disables [`setindex!`](@extref Base.setindex!) to prevent modifications.

See also [`protect`](@ref) and [`unprotect`](@ref).
"""
struct ProtectedArray{T,N,A<:AbstractArray{T,N}} <: AbstractArray{T,N}
    parent::A
end

"""
    ProtectedMatrix(matrix)

Type alias and convenience constructor for two-dimensional [`ProtectedArray`](@ref)s.
"""
const ProtectedMatrix{T,A<:AbstractMatrix{T}} = ProtectedArray{T,2,A}

"""
    ProtectedVector(vector)

Type alias and convenience constructor for one-dimensional [`ProtectedArray`](@ref)s.
"""
const ProtectedVector{T,A<:AbstractMatrix{T}} = ProtectedArray{T,1,A}


"""
    protect(array::AbstractArray)

Wrap an array into a [`ProtectedArray`](@ref) to prevent modifications.

See also [`unprotect`](@ref).
"""
protect(array::AbstractArray) = ProtectedArray(array)

"""
    unprotect(::ProtectedArray)

Unwrap a [`ProtectedArray`](@ref) into the underlying array.

This is a synonym of [`parent`](@extref Base.parent).

See also [`protect`](@ref).
"""
unprotect(pa::ProtectedArray) = pa.parent
Base.parent(pa::ProtectedArray) = pa.parent

function Base.showarg(io::IO, @nospecialize(a::ProtectedArray{T,N}), toplevel) where {T,N}
    toplevel || print(io, "::")
    if N == 1
        print(io, "ProtectedVector(")
    elseif N == 2
        print(io, "ProtectedMatrix(")
    else
        print(io, "ProtectedArray(")
    end
    Base.showarg(io, parent(a), false)
    # Base.showindices(io, axes(a)...)
    print(io, ')')
    toplevel && print(io, " with eltype ", eltype(a))
    return nothing
end

include("iteration.jl")
include("indexing.jl")
include("abstract_array.jl")
include("strided_array.jl")

end
