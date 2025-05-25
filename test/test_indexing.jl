using ProtectedArrays
using OffsetArrays, StaticArrays, RecursiveArrayTools

const err_msg = "`ProtectedArray` does not allow modifying elements with `setindex!`"

function test_indexing(a::AbstractArray)
    return @testset "$(a)" begin
        backup = deepcopy(a)
        pa = protect(a)

        @test firstindex(pa) == firstindex(a)
        @test lastindex(pa) == lastindex(a)
        @test eachindex(pa) == eachindex(a)

        @test pa[begin] == a[begin]
        @test pa[end] == a[end]
        @test pa[begin:end] == a[begin:end]

        for i in eachindex(a, pa)
            @test pa[i] == a[i]
            @test_throws err_msg pa[i] = 0
        end

        @test_throws err_msg pa .= 0
        @test_throws err_msg reverse!(pa)

        @test parent(pa) === a
        @test parent(pa) == backup
    end
end

test_indexing([1, 2, 3, 4, 5, 6])
test_indexing(OffsetArray([1, 2, 3, 4, 5, 6], 10))
test_indexing(SArray{Tuple{6}}([1, 2, 3, 4, 5, 6]))
test_indexing(MArray{Tuple{6}}([1, 2, 3, 4, 5, 6]))
test_indexing(ArrayPartition([1, 2, 3], [4, 5, 6]))

test_indexing([1 2 3; 4 5 6])
test_indexing(OffsetArray([1 2 3; 4 5 6], (100, 10)))
test_indexing(SArray{Tuple{2, 3}}([1 2 3; 4 5 6]))
test_indexing(MArray{Tuple{2, 3}}([1 2 3; 4 5 6]))

test_indexing(transpose([1 2 3; 4 5 6]))
test_indexing(transpose(OffsetArray([1 2 3; 4 5 6], (100, 10))))
test_indexing(transpose(SArray{Tuple{2, 3}}([1 2 3; 4 5 6])))
test_indexing(transpose(MArray{Tuple{2, 3}}([1 2 3; 4 5 6])))

test_indexing(
    PermutedDimsArray(
        reshape(Vector(1:(3 * 5 * 7)), (3, 5, 7)),
        (2, 1, 3)
    )
)
test_indexing(
    @view PermutedDimsArray(
        reshape(Vector(1:(3 * 5 * 7)), (3, 5, 7)),
        (2, 1, 3)
    )[begin:2:end, end:-1:begin, end:-2:begin]
)
test_indexing(
    PermutedDimsArray(
        (@view reshape(Vector(1:(3 * 5 * 7)), (3, 5, 7))[begin:2:end, end:-1:begin, end:-2:begin]),
        (2, 1, 3)
    )
)

test_indexing(reinterpret(Int32, reshape(Vector(1:6), (2, 3))))
test_indexing(reinterpret(reshape, Int32, reshape(Vector(1:6), (2, 3))))

test_indexing(reshape(view(randn(40, 40), 1:36, 1:20), (6, 6, 5, 4)))
test_indexing(reshape(view(randn(40, 40), 1:36, 1:20), (6, 3, 10, 4)))
