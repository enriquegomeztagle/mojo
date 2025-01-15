fn main() raises:
    try:
        var file = File.open("requirements.txt", File.OpenMode.read)
        var contents = file.read()
        print(contents)
        file.close()
    catch e:
        print("Error opening file: {e}")
