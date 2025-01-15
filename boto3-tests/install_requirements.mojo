fn main(): None {
    with open("requirements.txt", "r") as file {
        let contents = file.read()
        print(contents)
    }
}
