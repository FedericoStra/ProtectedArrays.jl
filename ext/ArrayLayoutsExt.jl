module ArrayLayoutsExt

using ProtectedArrays

import ArrayLayouts: MemoryLayout

MemoryLayout(::Type{ProtectedArray{T,N,A}}) where {T,N,A} = MemoryLayout(A)

end
