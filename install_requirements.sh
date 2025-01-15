#!/bin/bash

# Read each line from requirements.txt
while IFS= read -r package
do
    # Skip empty lines
    if [ ! -z "$package" ]; then
        echo "Installing $package..."
        conda install -y conda-forge::$package
    fi
done < requirements.txt

echo "All packages installed!"
