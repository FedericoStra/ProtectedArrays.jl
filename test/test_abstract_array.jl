using ProtectedArrays
using OffsetArrays, StaticArrays, RecursiveArrayTools

function test_abstract_array(a::AbstractArray)
    return @testset "$(a)" begin
        backup = deepcopy(a)
        pa = protect(a)

        @test ndims(pa) == ndims(a)

        @test IndexStyle(pa) == IndexStyle(a)
        @test axes(pa) == axes(a)
        for d in 1:(ndims(a) + 2)
            @test axes(pa, d) == axes(a, d)
        end

        sa = similar(a)
        spa = similar(pa)
        @test typeof(spa) == typeof(sa)
        @test axes(spa) == axes(sa)

        @test parent(pa) === a
        @test parent(pa) == backup
    end
end

test_abstract_array([1, 2, 3, 4, 5, 6])
test_abstract_array(OffsetArray([1, 2, 3, 4, 5, 6], 10))
test_abstract_array(SArray{Tuple{6}}([1, 2, 3, 4, 5, 6]))
test_abstract_array(MArray{Tuple{6}}([1, 2, 3, 4, 5, 6]))
test_abstract_array(ArrayPartition([1, 2, 3], [4, 5, 6]))

test_abstract_array([1 2 3; 4 5 6])
test_abstract_array(OffsetArray([1 2 3; 4 5 6], (100, 10)))
test_abstract_array(SArray{Tuple{2, 3}}([1 2 3; 4 5 6]))
test_abstract_array(MArray{Tuple{2, 3}}([1 2 3; 4 5 6]))

test_abstract_array(transpose([1 2 3; 4 5 6]))
test_abstract_array(transpose(OffsetArray([1 2 3; 4 5 6], (100, 10))))
test_abstract_array(transpose(SArray{Tuple{2, 3}}([1 2 3; 4 5 6])))
test_abstract_array(transpose(MArray{Tuple{2, 3}}([1 2 3; 4 5 6])))

test_abstract_array(
    PermutedDimsArray(
        reshape(Vector(1:(3 * 5 * 7)), (3, 5, 7)),
        (2, 1, 3)
    )
)
test_abstract_array(
    @view PermutedDimsArray(
        reshape(Vector(1:(3 * 5 * 7)), (3, 5, 7)),
        (2, 1, 3)
    )[begin:2:end, end:-1:begin, end:-2:begin]
)
test_abstract_array(
    PermutedDimsArray(
        (@view reshape(Vector(1:(3 * 5 * 7)), (3, 5, 7))[begin:2:end, end:-1:begin, end:-2:begin]),
        (2, 1, 3)
    )
)

test_abstract_array(reinterpret(Int32, reshape(1:6, (2, 3))))
test_abstract_array(reinterpret(Int32, reshape(Vector(1:6), (2, 3))))
test_abstract_array(reinterpret(reshape, Int32, reshape(1:6, (2, 3))))
test_abstract_array(reinterpret(reshape, Int32, reshape(Vector(1:6), (2, 3))))

test_abstract_array(reshape(view(randn(40, 40), 1:36, 1:20), (6, 6, 5, 4)))
test_abstract_array(reshape(view(randn(40, 40), 1:36, 1:20), (6, 3, 10, 4)))
