using ProtectedArrays
using Test, TestSetExtensions, SafeTestsets
using TimerOutputs

macro timed_testset(name::String, body)
    return quote
        @timeit $name @testset $name $body
    end
end
macro timed_safetestset(name::String, body)
    return quote
        @timeit $name @safetestset $name $body
    end
end

@timeit "All tests" @testset ExtendedTestSet "All tests" begin

    @timed_safetestset "Aqua tests" include("Aqua.jl")

    @timed_testset "ProtectedArrays.jl" begin

        @timed_safetestset "Constructors" include("test_constructors.jl")
        @timed_safetestset "Printing" include("test_printing.jl")

        @timed_testset "Interfaces" begin
            @timed_safetestset "Iteration" include("test_iteration.jl")
            @timed_safetestset "Indexing" include("test_indexing.jl")
            @timed_safetestset "Abstract array" include("test_abstract_array.jl")
            @timed_safetestset "Strided array" include("test_strided_array.jl")
        end

        @timed_safetestset "Modification" include("test_modification.jl")

    end # ProtectedArrays.jl
end # All tests

print_timer(title = "Test run")
