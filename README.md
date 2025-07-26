# CUDA Signal Processing - Moving Average + Normalization

## Overview

This project implements a CUDA-accelerated pipeline to process large 1D signal data stored in `.csv` format. It applies:
- A **moving average filter** to smooth the signal.
- A **normalization kernel** to scale values between [0, 1].

Such processing is common in applications like ECG analysis, seismic data filtering, or audio pre-processing.

---

## Features

- Reads large signal files (`1000+` samples) from `.csv`
- CUDA kernel for moving average smoothing
- CUDA kernel for min-max normalization
- Python script for plotting input vs. output
- Output includes smoothed, normalized `.csv` and plot image

---

## How to Run

### 1. Compile the CUDA code
```bash
make
make run
bash run.sh
```
### 3. Output Artifacts
| File                 | Description                                  |
| -------------------- | -------------------------------------------- |
| `data/input.csv`     | Synthetic noisy sine wave                    |
| `output/result.csv`  | Smoothed + normalized signal                 |
| `output/plot.png`    | Visualization of input vs. output            |


## CUDA Kernels
### movingAverageKernel
Each CUDA thread computes a moving average over a fixed window size centered at its index.

### normalizeKernel
Per-thread normalization using precomputed min/max values from the host:

```cpp
output[idx] = (input[idx] - minVal) / (maxVal - minVal);
