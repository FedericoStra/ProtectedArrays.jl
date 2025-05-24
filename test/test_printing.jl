using ProtectedArrays

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
