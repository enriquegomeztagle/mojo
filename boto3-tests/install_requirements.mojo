fn main():
    var file = try File.open("requirements.txt", File.OpenMode.read)
    var reader = try file.getLines()

    for line in reader {
        if line != "" {
            print("Installing {line}...")
            var command = "conda install -y conda-forge::{line}"
            var result = try Process.run(command)
            if result.exitCode != 0 {
                print("Error: Failed to install {line}")
                return
            }
        }
    }

    print("All packages installed!")
}
