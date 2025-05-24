using ProtectedArrays
using OffsetArrays, StaticArrays, RecursiveArrayTools

function test_printing(show_f::Function, a::AbstractArray, s::String)
    backup = deepcopy(a)
    pa = protect(a)

    io = IOBuffer()
    show_f(io, pa)
    seekstart(io)
    @test read(io, String) == s

    @test parent(pa) === a
    @test parent(pa) == backup
    return nothing
end

a = [1, 2]
test_printing(show, a, "[1, 2]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    2-element ProtectedVector(::Vector{Int64}) with eltype Int64:
     1
     2"""
)

a = [1 2 3; 4 5 6]
test_printing(show, a, "[1 2 3; 4 5 6]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    2×3 ProtectedMatrix(::Matrix{Int64}) with eltype Int64:
     1  2  3
     4  5  6"""
)

a = reshape(collect(1:24), (2, 3, 4))
test_printing(show, a, "[1 3 5; 2 4 6;;; 7 9 11; 8 10 12;;; 13 15 17; 14 16 18;;; 19 21 23; 20 22 24]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    2×3×4 ProtectedArray(::Array{Int64, 3}) with eltype Int64:
    [:, :, 1] =
     1  3  5
     2  4  6

    [:, :, 2] =
     7   9  11
     8  10  12

    [:, :, 3] =
     13  15  17
     14  16  18

    [:, :, 4] =
     19  21  23
     20  22  24"""
)

a = OffsetArray([1 3 5; 2 4 6], (100, 10))
test_printing(show, a, "[1 3 5; 2 4 6]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    2×3 ProtectedMatrix(OffsetArray(::Matrix{Int64}, 101:102, 11:13)) with eltype Int64 with indices 101:102×11:13:
     1  3  5
     2  4  6"""
)

a = SArray{Tuple{2, 3}}([1 3 5; 2 4 6])
test_printing(show, a, "[1 3 5; 2 4 6]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    2×3 ProtectedMatrix(::StaticArraysCore.SMatrix{2, 3, Int64, 6}) with eltype Int64 with indices SOneTo(2)×SOneTo(3):
     1  3  5
     2  4  6"""
)

a = ArrayPartition([1, 2, 3], [4, 5])
test_printing(show, a, "[1, 2, 3, 4, 5]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    5-element ProtectedVector(::RecursiveArrayTools.ArrayPartition{Int64, Tuple{Vector{Int64}, Vector{Int64}}}) with eltype Int64:
     1
     2
     3
     4
     5"""
)

a = OffsetArray(SA[1 3 5; 2 4 6], (100, 10))
test_printing(show, a, "[1 3 5; 2 4 6]")
test_printing(
    (io, x) -> show(io, MIME"text/plain"(), x), a,
    """
    2×3 ProtectedMatrix(OffsetArray(::StaticArraysCore.SMatrix{2, 3, Int64, 6}, 101:102, 11:13)) with eltype Int64 with indices 101:102×11:13:
     1  3  5
     2  4  6"""
)
pa = protect(a)
io = IOBuffer()
show(io, [pa])
seekstart(io)
@test read(io, String) == "ProtectedMatrix{Int64, OffsetArrays.OffsetMatrix{Int64, StaticArraysCore.SMatrix{2, 3, Int64, 6}}}[[1 3 5; 2 4 6]]"
truncate(io, 0)
show(io, MIME"text/plain"(), [pa])
seekstart(io)
@test read(io, String) == """
    1-element Vector{ProtectedMatrix{Int64, OffsetArrays.OffsetMatrix{Int64, StaticArraysCore.SMatrix{2, 3, Int64, 6}}}}:
     [1 3 5; 2 4 6]"""
