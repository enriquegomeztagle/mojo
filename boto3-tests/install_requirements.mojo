fn main(): None {
    let file = File.open("requirements.txt", File.OpenMode.read)
    let contents = file.read()
    print(contents)
    file.close()
}
