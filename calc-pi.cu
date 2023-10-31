#include <stdio.h>
#include <curand_kernel.h>

#define THREADS_PER_BLOCK 256

__global__ void monte_carlo_pi(int iterations, curandState *state, unsigned int *result)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    int points_in_circle = 0;

    curand_init(1234, tid, 0, &state[tid]);

    for (int i = 0; i < iterations; i++) {
        float x = curand_uniform(&state[tid]);
        float y = curand_uniform(&state[tid]);

        if (x * x + y * y <= 1.0f) {
            points_in_circle++;
        }
    }

    result[tid] = points_in_circle;
}

int main() {
    monte_carlo_pi(1000000, 1, 1)
}