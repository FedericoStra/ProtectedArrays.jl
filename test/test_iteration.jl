using ProtectedArrays
using OffsetArrays, StaticArrays, RecursiveArrayTools

function test_iteration(a::AbstractArray)
    @testset "$(a)" begin
        backup = deepcopy(a)
        pa = protect(a)

        @test Base.IteratorSize(pa) == Base.IteratorSize(a)
        @test length(pa) == length(a)
        @test size(pa) == size(a)
        for d in 1:ndims(a)
            @test size(pa, d) == size(a, d)
        end

        @test Base.IteratorEltype(pa) == Base.IteratorEltype(a)
        @test eltype(pa) == eltype(a)

        @test collect(pa) == collect(a)
        @test iterate(pa) == iterate(a)

        @test parent(pa) === a
        @test parent(pa) == backup
    end
end

test_iteration([1,2,3,4,5,6])
test_iteration(OffsetArray([1,2,3,4,5,6], 10))
test_iteration(SArray{Tuple{6}}([1,2,3,4,5,6]))
test_iteration(MArray{Tuple{6}}([1,2,3,4,5,6]))
test_iteration(ArrayPartition([1,2,3], [4,5,6]))

test_iteration([1 2 3; 4 5 6])
test_iteration(OffsetArray([1 2 3; 4 5 6], (100, 10)))
test_iteration(SArray{Tuple{2,3}}([1 2 3; 4 5 6]))
test_iteration(MArray{Tuple{2,3}}([1 2 3; 4 5 6]))

test_iteration(transpose([1 2 3; 4 5 6]))
test_iteration(transpose(OffsetArray([1 2 3; 4 5 6], (100, 10))))
test_iteration(transpose(SArray{Tuple{2,3}}([1 2 3; 4 5 6])))
test_iteration(transpose(MArray{Tuple{2,3}}([1 2 3; 4 5 6])))

test_iteration(
    PermutedDimsArray(
        reshape(Vector(1:3*5*7), (3,5,7)),
        (2,1,3)
    )
)
test_iteration(
    @view PermutedDimsArray(
        reshape(Vector(1:3*5*7), (3,5,7)),
        (2,1,3)
    )[begin:2:end, end:-1:begin, end:-2:begin]
)
test_iteration(
    PermutedDimsArray(
        (@view reshape(Vector(1:3*5*7), (3,5,7))[begin:2:end, end:-1:begin, end:-2:begin]),
        (2,1,3)
    )
)

test_iteration(reinterpret(Int32, reshape(1:6, (2,3))))
test_iteration(reinterpret(Int32, reshape(Vector(1:6), (2,3))))
test_iteration(reinterpret(reshape, Int32, reshape(1:6, (2,3))))
test_iteration(reinterpret(reshape, Int32, reshape(Vector(1:6), (2,3))))

test_iteration(reshape(view(randn(40,40), 1:36, 1:20), (6,6,5,4)))
test_iteration(reshape(view(randn(40,40), 1:36, 1:20), (6,3,10,4)))
