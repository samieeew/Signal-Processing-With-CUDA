#include <iostream>
#include <fstream>
#include <vector>
#include <cuda_runtime.h>

#define BLOCK_SIZE 256

__global__ void movingAverageKernel(float* input, float* output, int N, int windowSize) {
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < N) {
        float sum = 0;
        int count = 0;
        for (int i = idx - windowSize / 2; i <= idx + windowSize / 2; ++i) {
            if (i >= 0 && i < N) {
                sum += input[i];
                count++;
            }
        }
        output[idx] = sum / count;
    }
}

std::vector<float> readCSV(const std::string& filename) {
    std::ifstream file(filename);
    std::vector<float> data;
    std::string line;
    while (std::getline(file, line)) {
        data.push_back(std::stof(line));
    }
    return data;
}

void writeCSV(const std::string& filename, const std::vector<float>& data) {
    std::ofstream file(filename);
    for (const auto& val : data) {
        file << val << "\n";
    }
}

int main(int argc, char* argv[]) {
    if (argc != 4) {
        std::cerr << "Usage: ./main <input.csv> <output.csv> <window_size>\n";
        return 1;
    }

    std::string inputFile = argv[1];
    std::string outputFile = argv[2];
    int windowSize = std::stoi(argv[3]);

    std::vector<float> input = readCSV(inputFile);
    int N = input.size();

    float *d_input, *d_output;
    cudaMalloc(&d_input, N * sizeof(float));
    cudaMalloc(&d_output, N * sizeof(float));

    cudaMemcpy(d_input, input.data(), N * sizeof(float), cudaMemcpyHostToDevice);

    int numBlocks = (N + BLOCK_SIZE - 1) / BLOCK_SIZE;
    movingAverageKernel<<<numBlocks, BLOCK_SIZE>>>(d_input, d_output, N, windowSize);
    cudaDeviceSynchronize();

    std::vector<float> output(N);
    cudaMemcpy(output.data(), d_output, N * sizeof(float), cudaMemcpyDeviceToHost);

    writeCSV(outputFile, output);

    cudaFree(d_input);
    cudaFree(d_output);

    std::cout << "Processed " << N << " signal points with window size " << windowSize << ".\n";
    return 0;
}
