local defaultVersion = "17"

return {
    version = defaultVersion,
    resolved = {
        ["17"] = {
            windows = {
                {
                    check = {
                        suffix = "zip",
                        arch = "amd64",
                    },
                    url = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.zip"
                },
                {
                    check = { suffix = "exe" },
                    url = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe"
                },
                {
                    check = { suffix = "msi" },
                    url = "https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.msi"
                }
            },
            linux = {

            },
            darwin = {

            }
        }
    },
    install = function(opt)
    end,
    uninstall = function(opt)
    end
}
