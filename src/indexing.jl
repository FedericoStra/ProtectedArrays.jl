# Indexing interface.
#
# See <https://docs.julialang.org/en/v1/manual/interfaces/#Indexing>.

using Base: @propagate_inbounds

@propagate_inbounds function Base.getindex(pa::ProtectedArray, indices...)
    getindex(parent(pa), indices...)
end

@inline function Base.setindex!(::ProtectedArray, _, _)
    error("""
          `ProtectedArray` does not allow modifying elements with `setindex!`,
                 use `unprotect` if you really know what you're doing.""")
end

@inline firstindex(pa::ProtectedArray) = firstindex(parent(pa))
@inline lastindex(pa::ProtectedArray) = firstindex(parent(pa))
