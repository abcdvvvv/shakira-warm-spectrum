# 2D Poisson solver: Jacobi iterations on a uniform grid
function jacobi_poisson!(u::Matrix{Float64}, b::Matrix{Float64}, h::Float64;
    maxiter::Int=500, tol::Float64=1e-8)
    nx, ny = size(u)
    @assert size(b) == (nx, ny)
    inv4 = 0.25
    h2 = h * h
    tmp = similar(u)

    for it = 1:maxiter
        @inbounds for j = 2:ny-1
            for i = 2:nx-1
                tmp[i, j] = inv4 * (u[i-1, j] + u[i+1, j] +
                                    u[i, j-1] + u[i, j+1] - h2 * b[i, j])
            end
        end
        err = 0.0
        @inbounds for j = 2:ny-1
            for i = 2:nx-1
                d = abs(tmp[i, j] - u[i, j])
                err = ifelse(d > err, d, err)
                u[i, j] = tmp[i, j]
            end
        end
        err < tol && return it, err
    end

    return maxiter, NaN
end
