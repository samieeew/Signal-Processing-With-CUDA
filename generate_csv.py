import numpy as np

x = np.linspace(0, 10 * np.pi, 1000)
y = np.sin(x) + 0.2 * np.random.randn(len(x))

for value in y:
    print(value)
