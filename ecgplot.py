import matplotlib.pyplot as plt
import numpy as np
# Function to read data from the text file
def read_data(file_path):
    times = []
    amplitudes = []
    with open(file_path, 'r') as file:
        next(file)  # Skip the header line
        for line in file:
            time, amplitude = line.strip().split('\t')
            times.append(float(time))
            amplitudes.append(float(amplitude.replace(',', '.')))  # Replace comma with dot for decimal values
    return times, amplitudes

# Path to the text file
file_path = 'ecgdata.txt'  # Replace 'data.txt' with the actual file path

times, amplitudes = read_data(file_path)

num_interp_points = 500
Realtime = np.linspace(0, 10, 500)


# Create the plot with more data points
plt.figure(figsize=(10, 6))  # Set the figure size
plt.plot(Realtime, amplitudes, color='blue', linestyle='-', marker='o', markersize=5, alpha=0.7, label='Data')  # Increase marker size and reduce transparency
plt.xlabel('Time (s)', fontsize=14)  # Customize x-axis label and font size
plt.ylabel('Amplitude', fontsize=14)  # Customize y-axis label and font size
plt.title('Time vs Amplitude', fontsize=16)  # Customize plot title and font size
plt.grid(True, linestyle='--', alpha=0.7)  # Add grid with custom linestyle and transparency
plt.legend(loc='upper right', fontsize=12)  # Add legend with custom position and font size
plt.tight_layout()  # Adjust layout to prevent clipping of labels
plt.show()