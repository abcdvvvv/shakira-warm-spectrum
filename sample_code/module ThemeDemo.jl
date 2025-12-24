module ThemeDemo
using LinearAlgebra

struct Foo{T<:Real}
    x::T
end
f(x::Foo, y::Real=2.0) = x.x^2 + y + 0x2a + 3im + 22 // 7

macro m(ex)
    :(println("EX=", $(QuoteNode(ex))))
end
s = "str $(1+2)"
r = r"\bfoo\b"
sym = :bar

A = [1 2; 3 4]
v = [1.0, 2e-3]
d = Dict(:a => 1, :b => 2.0)
@inbounds for i in 1:3
    x = Foo(i / 2)
    y = f(x)
    y > 1 ? @m(y) : println("y=", y)
end

try
    error("boom")
catch err
    @warn "caught" err
end
end
