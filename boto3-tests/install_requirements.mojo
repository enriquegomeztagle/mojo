import os
import subprocess

fn main() raises:
    file_name = "requirements.txt"
    if os.path.exists(file_name):
        try:
            f = open(file_name, "r")
            lines = f.readlines()
            for line in lines:
                package = line.strip()
                if package != "":
                    command = "conda install -y conda-forge::" + package
                    result = subprocess.run(command, shell=True, capture_output=True, text=True)
                    if result.returncode == 0:
                        print(f"Successfully installed {package}")
                    else:
                        print(f"Error installing {package}: {result.stderr}")
            f.close()
        except:
            print("Error opening file")
    else:
        print("requirements.txt does not exist")
