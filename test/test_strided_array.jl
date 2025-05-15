using ProtectedArrays
using OffsetArrays, StaticArrays, RecursiveArrayTools

function test_strided_array(a::AbstractArray)
    @testset "$(a)" begin
        backup = deepcopy(a)
        pa = protect(a)

        @test Base.elsize(pa) == Base.elsize(a)
        @test strides(pa) == strides(a)
        for d in 1:ndims(a)+2
            @test stride(pa, d) == stride(a, d)
        end

        @test parent(pa) === a
        @test parent(pa) == backup
    end
end

test_strided_array([1,2,3,4,5,6])
test_strided_array(OffsetArray([1,2,3,4,5,6], 10))
# test_strided_array(SArray{Tuple{6}}([1,2,3,4,5,6]))
test_strided_array(MArray{Tuple{6}}([1,2,3,4,5,6]))
# test_strided_array(ArrayPartition([1,2,3], [4,5,6]))

test_strided_array([1 2 3; 4 5 6])
test_strided_array(OffsetArray([1 2 3; 4 5 6], (100, 10)))
# test_strided_array(SArray{Tuple{2,3}}([1 2 3; 4 5 6]))
test_strided_array(MArray{Tuple{2,3}}([1 2 3; 4 5 6]))

test_strided_array(transpose([1 2 3; 4 5 6]))
test_strided_array(transpose(OffsetArray([1 2 3; 4 5 6], (100, 10))))
# test_strided_array(transpose(SArray{Tuple{2,3}}([1 2 3; 4 5 6])))
test_strided_array(transpose(MArray{Tuple{2,3}}([1 2 3; 4 5 6])))

test_strided_array(
    PermutedDimsArray(
        reshape(Vector(1:3*5*7), (3,5,7)),
        (2,1,3)
    )
)
test_strided_array(
    @view PermutedDimsArray(
        reshape(Vector(1:3*5*7), (3,5,7)),
        (2,1,3)
    )[begin:2:end, end:-1:begin, end:-2:begin]
)
test_strided_array(
    PermutedDimsArray(
        (@view reshape(Vector(1:3*5*7), (3,5,7))[begin:2:end, end:-1:begin, end:-2:begin]),
        (2,1,3)
    )
)

test_strided_array(reinterpret(Int32, reshape(Vector(1:6), (2,3))))
test_strided_array(reinterpret(reshape, Int32, reshape(Vector(1:6), (2,3))))

test_strided_array(reshape(view(randn(40,40), 1:36, 1:20), (6,6,5,4)))
# test_strided_array(reshape(view(randn(40,40), 1:36, 1:20), (6,3,10,4))) # not strided!
