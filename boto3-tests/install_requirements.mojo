fn main() raises:
    try:
        let file = File.open("requirements.txt", File.OpenMode.read)
        let contents = file.read()
        print(contents)
        file.close()
    catch e:
        print("Error opening file: {e}")
