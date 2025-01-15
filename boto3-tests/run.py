import subprocess

# Step 1: Run the Lua script to install requirements
subprocess.run(["lua", "install_requirements.lua"], check=True)

# Step 2: Run the Mojo code
subprocess.run(["mojo", "run", "main.mojo"], check=True)
