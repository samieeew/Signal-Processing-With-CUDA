import pandas as pd
import matplotlib.pyplot as plt

input_signal = pd.read_csv("data/input.csv", header=None).squeeze()
output_signal = pd.read_csv("output/result.csv", header=None).squeeze()

plt.figure(figsize=(12, 4))
plt.plot(input_signal, label="Input Signal", alpha=0.6)
plt.plot(output_signal, label="Smoothed + Normalized Output", alpha=0.9)
plt.title("Signal Processing")
plt.xlabel("Index")
plt.ylabel("Amplitude")
plt.legend()
plt.tight_layout()
plt.grid(True)
plt.savefig("output/plot.png")
plt.show()
