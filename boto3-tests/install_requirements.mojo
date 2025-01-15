import os

fn main() raises:
    if os.path.exists("requirements.txt"):
        try:
            var f = open("requirements.txt", "r")
            print(f.read())
            f.close()
        except:
            print("Error opening file")
    else:
        print("requirements.txt does not exist")
