CUDA_PATH ?= /usr/local/cuda
NVCC := $(CUDA_PATH)/bin/nvcc
SRC := Main.cu
OUT := bin/signal_processor

all:
	mkdir -p bin
	$(NVCC) -O2 $(SRC) -o $(OUT)

run: all
	python3 plot_signals.py

clean:
	rm -rf bin output/*.csv output/*.png log.txt
