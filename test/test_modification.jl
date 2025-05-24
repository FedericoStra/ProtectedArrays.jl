using ProtectedArrays
using OffsetArrays, StaticArrays, RecursiveArrayTools

const err_msg = "`ProtectedArray` does not allow modifying elements with `setindex!`"

function test_modification(a::AbstractArray)
    return @testset "$(a)" begin
        backup = deepcopy(a)
        pa = protect(a)

        @test_throws err_msg pa .= 0
        @test_throws err_msg pa .+= 1
        @test_throws err_msg reverse!(pa)
        @test_throws MethodError push!(pa, 0)
        @test_throws MethodError pushfirst!(pa, 0)
        @test_throws MethodError pop!(pa)
        @test_throws MethodError popat!(pa, 3)
        @test_throws MethodError popfirst!(pa)
        @test_throws MethodError insert!(pa, 3, 0)
        @test_throws MethodError splice!(pa, 3, 0)
        @test_throws MethodError deleteat!(pa, 3)
        @test_throws MethodError resize!(pa, 3)
        @test_throws err_msg fill!(pa, 0)
        if isa(a, AbstractVector)
            @test_throws err_msg filter!(ispow2, pa)
        end

        @test parent(pa) === a
        @test parent(pa) == backup
    end
end

test_modification([1, 2, 3, 4, 5, 6])
test_modification(OffsetArray([1, 2, 3, 4, 5, 6], 10))
test_modification(SArray{Tuple{6}}([1, 2, 3, 4, 5, 6]))
test_modification(MArray{Tuple{6}}([1, 2, 3, 4, 5, 6]))
test_modification(ArrayPartition([1, 2, 3], [4, 5, 6]))

test_modification([1 2 3; 4 5 6])
test_modification(OffsetArray([1 2 3; 4 5 6], (100, 10)))
test_modification(SArray{Tuple{2, 3}}([1 2 3; 4 5 6]))
test_modification(MArray{Tuple{2, 3}}([1 2 3; 4 5 6]))
