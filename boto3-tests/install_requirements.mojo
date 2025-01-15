fn main() {
    let file = try File.open("requirements.txt", File.OpenMode.read)
    let reader = try file.getLines()

    for line in reader {
        if line != "" {
            print("Installing {line}...")
            let command = "conda install -y conda-forge::{line}"
            let result = try Process.run(command)
            if result.exitCode != 0 {
                print("Error: Failed to install {line}")
                return
            }
        }
    }

    print("All packages installed!")
}
