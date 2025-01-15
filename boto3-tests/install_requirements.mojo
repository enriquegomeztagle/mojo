fn main(): None {
    var file = open("requirements.txt", "r")
    let contents = file.read()
    file.close()

    print(contents)
}
