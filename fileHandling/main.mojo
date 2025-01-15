from python import Python
import os


fn main() raises:
    try:
        var pyos = Python.import_module("os")
        var counter = 0
        var file_name = "requirements.txt"

        if os.path.exists(file_name):
            try:
                var file = open(file_name, "r")
                var content = file.read()
                var lines = content.split("\n")

                for line in lines:
                    var package = String(line[].strip())
                    if len(package) != 0:
                        counter += 1
                        print(
                            "Line "
                            + str(counter)
                            + " -> "
                            + "Found: "
                            + package
                            + " ...."
                        )
                file.close()
            except Exception:
                print("Error opening file")
        else:
            print("requirements.txt does not exist")
    except Exception:
        print("Could not import os module")
