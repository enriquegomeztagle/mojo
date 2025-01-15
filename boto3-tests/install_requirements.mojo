import os

fn main() raises:
    file_name = "requirements.txt"
    if os.path.exists(file_name):
        try:
            f = open(file_name, "r")
            print(f.read())
            f.close()
        except:
            print("Error opening file")
    else:
        print("requirements.txt does not exist")
