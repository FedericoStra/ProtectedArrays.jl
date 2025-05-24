using ProtectedArrays

a = [1, 2]
pa = protect(a)
@test unprotect(pa) === a
@test parent(pa) === a
@test isa(pa, ProtectedArray{Int, 1, Vector{Int}})
@test isa(pa, ProtectedArray{Int, 1})
@test isa(pa, ProtectedArray{Int})
@test isa(pa, ProtectedArray)
@test isa(pa, ProtectedVector{Int, Vector{Int}})
@test isa(pa, ProtectedVector{Int})
@test isa(pa, ProtectedVector)

a = [1 2 3; 4 5 6]
pa = protect(a)
@test unprotect(pa) === a
@test parent(pa) === a
@test isa(pa, ProtectedArray{Int, 2, Matrix{Int}})
@test isa(pa, ProtectedArray{Int, 2})
@test isa(pa, ProtectedArray{Int})
@test isa(pa, ProtectedArray)
@test isa(pa, ProtectedMatrix{Int, Matrix{Int}})
@test isa(pa, ProtectedMatrix{Int})
@test isa(pa, ProtectedMatrix)

a = reshape(collect(1:24), (2, 3, 4))
pa = protect(a)
@test unprotect(pa) === a
@test parent(pa) === a
@test isa(pa, ProtectedArray{Int, 3, Array{Int, 3}})
@test isa(pa, ProtectedArray{Int, 3})
@test isa(pa, ProtectedArray{Int})
@test isa(pa, ProtectedArray)
