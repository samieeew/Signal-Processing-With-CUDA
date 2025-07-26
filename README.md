# CUDA Signal Processing - Moving Average Filter

## Overview

This project implements a CUDA-accelerated moving average filter for large 1D signal datasets stored in `.csv` format. It simulates the kind of processing commonly used in audio, ECG, or sensor signal smoothing.

## Features

- Reads signal data from CSV
- Applies CUDA-based moving average filter
- Outputs smoothed data to CSV
- Handles large datasets (1000+ points)

## How to Run

### 1. Compile
```bash
make
```
###2. Generate sample signal and run processing
```bash
bash run.sh
```
###3. Output
Input: data/input.csv
Output: output/result.csv
Log: log.txt

Kernel Used
A 1D moving average filter with adjustable window size is implemented using CUDA. Each GPU thread computes the filtered value for one data point.
