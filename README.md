# Serif Health Takehome Interview Solution
![Serif-health](https://uploads-ssl.webflow.com/629960d31b962ee85307efd1/6299618d1c0944fec6070f8e_SH-Logo-Black.png)

## Overview

This repository contains solutions for the Serif Health Takehome Engineering Interview, focusing on extracting and processing healthcare pricing data. Key components include a Python script (`parse_anthem_ppo_urls.py`), a Bash script (`run_python_script.sh`) for execution, and a Jupyter Notebook (`explore_anthem_data.ipynb`) for preliminary data exploration.

## Input Data Source

- The data should be downloaded from the following URL and placed in the same directory as the scripts:
  [Data Link](https://antm-pt-prod-dataz-nogbd-nophi-us-east1.s3.amazonaws.com/anthem/2024-01-01_anthem_index.json.gz)

## Components and Rationale

1. **`parse_anthem_ppo_urls.py`**:
   - A Python script that processes a large JSON file to extract machine-readable file URLs for Anthem's PPO network in New York state.
   - Python is chosen for its robustness and widespread use in data processing and analysis.

2. **`run_python_script.sh`**:
   - A bash script that creates a virtual environment, activates it, installs dependencies, and runs `parse_anthem_ppo_urls.py`.
   - This script ensures that the Python script runs in a controlled environment with all required dependencies, avoiding version conflicts and enhancing portability.

3. **`explore_anthem_data.ipynb`**:
   - A Jupyter Notebook used for initial data exploration.
   - Facilitates understanding of the dataset by showing the schema, data types, and record count.
   - Justifies the necessity of exploring the data to inform effective and efficient script development.
   - Can be opened and run in an IPython Notebook environment.

## Choice of PySpark

- **Handling Large Data**: PySpark is specifically chosen for its ability to handle and process large datasets efficiently.
- **Scalability and Performance**: PySpark's distributed computing capabilities make it ideal for tasks that involve large volumes of data, ensuring scalability and high performance.
- **Ease of Integration**: PySpark seamlessly integrates with the Python ecosystem, allowing for the utilization of Python's libraries and tools alongside Spark's powerful data processing framework.

## Python and PySpark Versions

- Developed using Python 3.10.13; compatible with Python versions >= 3.8.0.
- Utilizes PySpark version 3.5.0.
- Compatibility between Python and PySpark versions is crucial for avoiding issues and ensuring seamless functionality.

## Execution Time

- The script `parse_anthem_ppo_urls.py` completed execution in approximately 5.3 minutes on a MacBook Pro.

## Setup and Execution Instructions

- Ensure Python (version >= 3.8.0) and pip are installed.
- Download the data from the provided URL and place it along in one level above the `scripts` directory.
- In your terminal, navigate to the directory containing the scripts and:
   - Make the bash script executable using chmod +x run_python_script.sh
   - Execute the bash script using `./run_python_script.sh`.
- For data exploration, open `explore_anthem_data.ipynb` in an IPython Notebook environment.

## Output

The output is a folder called `anthem_ppo_urls.csv` containing a csv file with distinct URLs for Anthem's PPO network in New York state.

## Additional Notes

- The modular approach with separate script and notebook files promotes clarity and maintainability.
- The virtual environment ensures a controlled execution environment, maintaining dependency consistency.

## Development Time

- The entire solution, including writing the README file and organizing the different scripts and files, took approximately 3.5 hours to develop.

## Solution Runtime

- The `parse_anthem_ppo_urls.py` script has an execution time of approximately 322.9318540096283 seconds (about 5.4 minutes).

## Tradeoffs and Further Considerations

- **Use of PySpark**: While PySpark provides excellent scalability and performance for handling large datasets, it introduces complexity in setup and execution, especially when compared to simpler Python-based solutions.
- **Cloud-Based Execution**: Ideally, for optimal performance and handling even larger datasets, this solution should be run on a cloud-based cluster. Running PySpark on a local machine may not fully leverage its distributed computing capabilities.
- **Cost-Benefit Analysis**: The decision to use PySpark should be weighed against the actual size and complexity of the data. For smaller datasets, simpler and less resource-intensive tools might be more appropriate.
- **Future Enhancements**: Consideration for future enhancements includes implementing logging, and perhaps a more interactive data exploration tool, enhancing the usability for non-technical stakeholders.
- **Portability and Compatibility**: Ensuring compatibility with various operating systems and Python versions is crucial for widespread use. The use of a virtual environment aids in this, but further testing and adjustments may be necessary for different environments.
