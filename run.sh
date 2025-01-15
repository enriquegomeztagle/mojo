#!/bin/bash

# Step 1: Run the Lua script to install requirements
lua boto3-tests/install_requirements.lua

# Check if the Lua script executed successfully
if [ $? -ne 0 ]; then
  echo "Error: Lua script failed to execute."
  exit 1
fi

# Step 2: Run the Mojo code
mojo run boto3-tests/main.mojo

# Check if the Mojo code executed successfully
if [ $? -ne 0 ]; then
  echo "Error: Mojo code failed to execute."
  exit 1
fi

echo "All tasks completed successfully."
