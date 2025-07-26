CUDA_PATH ?= /usr/local/cuda
NVCC := $(CUDA_PATH)/bin/nvcc
SRC := Main.cu
OUT := bin/signal_processor

all:
	mkdir -p bin
	$(NVCC) -O2 $(SRC) -o $(OUT)

clean:
	rm -rf bin output/*.csv log.txt
