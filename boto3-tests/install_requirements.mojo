fn main(): None {
    let file = try File.open("requirements.txt", File.OpenMode.read)
    let reader = try file.getLines()

    for line in reader {
        print(line)
    }
}
