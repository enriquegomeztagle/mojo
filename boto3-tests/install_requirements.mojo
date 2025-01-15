import os

fn main() raises:
    if os.path.exists("requirements.txt"):
        try:
            var f = open("requirements.txt", "r")
            print(f.read())
            f.close()
        except Exception as e:
            print(f"Error opening file: {e}")
    else:
        print("requirements.txt does not exist")
