return {
    version = "1.20",
    resolved = {
        ["1.20"] = {
            windows = {
                {
                    check = { suffix = "zip", arch = "amd64" },
                    url = "https://golang.google.cn/dl/go1.20.7.windows-amd64.zip"
                },
                {
                    check = { suffix = "zip", arch = "386" },
                    url = "https://golang.google.cn/dl/go1.20.7.windows-386.zip"
                }
            },
            linux = {
                {
                    check = { suffix = "tar.gz", arch = "386" },
                    url = "https://golang.google.cn/dl/go1.20.7.linux-386.tar.gz"
                },
                {
                    check = { suffix = "tar.gz", arch = "amd64" },
                    url = "https://golang.google.cn/dl/go1.20.7.linux-amd64.tar.gz"
                }
            },
            darwin = {
                {
                    check = { arch = "arm64" },
                    url = "https://golang.google.cn/dl/go1.20.7.darwin-arm64.tar.gz"
                },
                {
                    check = { arch = "amd64" },
                    url = "https://golang.google.cn/dl/go1.20.7.darwin-amd64.tar.gz"
                }
            }
        }
    },
}
