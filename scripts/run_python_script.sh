#!/bin/bash

# Define the required Python version
REQUIRED_PYTHON_VERSION="Python 3.10.13" # I am using Python 3.10.13 but you can use any version after 3.8.0.
                                         # You can remove lines 10-19 if you are using Python 3.8.0 or higher but not 3.10.13.

# Define the Python script and requirements file
PYTHON_SCRIPT="parse_anthem_ppo_urls.py" # Python script that we want to run
REQUIREMENTS_FILE="../requirements.txt" # Requirements file that contains the dependencies
VENV_NAME="env" # Name of the virtual environment

# Function to create and activate virtual environment
create_activate_venv() {
    echo "Creating virtual environment..."
    python -m venv $VENV_NAME
    source $VENV_NAME/bin/activate
    echo "Virtual environment activated."
}

# Function to check Python version
check_python_version() {
    PYTHON_VERSION=$(python --version 2>&1 | awk '{print $2}')
    REQUIRED_PYTHON_VERSION="3.10.0"
    
    # Compare versions
    if [[ "$(printf '%s\n' "$REQUIRED_PYTHON_VERSION" "$PYTHON_VERSION" | sort -V | head -n1)" = "$REQUIRED_PYTHON_VERSION" ]]; then
        echo "Correct Python version found: $PYTHON_VERSION"
    else
        echo "Python version must be $REQUIRED_PYTHON_VERSION or newer. Found: $PYTHON_VERSION"
        exit 1
    fi
}

# Install dependencies from requirements.txt
install_dependencies() {
    echo "Installing dependencies..."
    pip install --upgrade pip
    pip install -r $REQUIREMENTS_FILE
    if [ $? -ne 0 ]; then
        echo "Failed to install dependencies from $REQUIREMENTS_FILE."
        exit 1
    fi
}

# Run the Python script
run_python_script() {
    echo "Running Python script..."
    python $PYTHON_SCRIPT
    if [ $? -ne 0 ]; then
        echo "Python script execution failed."
        exit 1
    fi
}

# Check Python version
check_python_version

# Create and activate virtual environment
create_activate_venv

# Install dependencies
install_dependencies

# Run the script
run_python_script

# Deactivate virtual environment
deactivate

echo "Script executed successfully."
