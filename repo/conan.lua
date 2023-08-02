return {
    resolved = {
        ["2.0.9"] = {
            windows = {
                {
                    check = { suffix = "exe" },
                    url = "https://github.com/conan-io/conan/releases/download/2.0.9/conan-win-32.exe"
                },
                {
                    check = { suffix = "zip" },
                    url = "https://github.com/conan-io/conan/releases/download/2.0.9/conan-win-32.zip"
                }
            },
            linux = {
                {
                    check = { suffix = "tar.gz" },
                    url = "https://github.com/conan-io/conan/releases/download/2.0.9/conan-linux-64.tar.gz"
                }
            },
            darwin = {
                {
                    check = { suffix = "tar.gz" },
                    url = "https://github.com/conan-io/conan/releases/download/2.0.9/conan-macos-arm64.tar.gz"
                }
            }
        }
    }
}
