set -e

echo "Compiling CUDA project..."
make

echo "Generating synthetic input..."
python3 generate_csv.py > data/input.csv

echo "Running CUDA signal processor..."
./bin/signal_processor data/input.csv output/result.csv 5 | tee log.txt
