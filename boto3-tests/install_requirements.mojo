import os
import subprocess

fn main() raises:
    file_name: String = "requirements.txt"
    if os.path.exists(file_name):
        try:
            f: File = os.open(file_name, os.O_RDONLY)
            lines: List[String] = f.readLines()
            for line in lines:
                package: String = line.strip()
                if package != "":
                    command: String = f"conda install -y conda-forge::{package}"
                    result: subprocess.CompletedProcess = subprocess.run(command, shell=True, capture_output=True, text=True)
                    if result.returncode == 0:
                        print(f"Successfully installed {package}")
                    else:
                        print(f"Error installing {package}: {result.stderr}")
            f.close()
        except:
            print("Error opening file")
    else:
        print("requirements.txt does not exist")
