#!/bin/bash

# Script to install Python packages from requirements.txt using conda
# Exit on any error
set -e

# Check if requirements.txt exists
if [ ! -f "requirements.txt" ]; then
    echo "Error: requirements.txt not found"
    exit 1
fi

# Read each line from requirements.txt
while IFS= read -r package
do
    # Skip empty lines
    if [ ! -z "$package" ]; then
        echo "Installing $package..."
        if ! conda install -y conda-forge::$package; then
            echo "Error: Failed to install $package"
            exit 1
        fi
    fi
done < requirements.txt

echo "All packages installed successfully!"
