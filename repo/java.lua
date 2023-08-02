local defaultVersion = "17"

return {
    version = defaultVersion,
    resolved = {
        ["17"] = {
            windows = {
                {
                    check = { suffix = "zip", arch = "amd64" },
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
                {
                    check = { suffix = "tar.gz", },
                    url   = "https://download.oracle.com/java/17/latest/jdk-17_linux-aarch64_bin.tar.gz"
                }
            },
            darwin = {
                {
                    check = { suffix = "tar.gz" },
                    url = "https://download.oracle.com/java/17/latest/jdk-17_macos-aarch64_bin.tar.gz"
                }
            }
        }
    },
    install = function(opt)
    end,
    uninstall = function(opt)
    end,
    exist = function(opt)
        local res = sh({ redirect = false }, "java -version")
        if #res > 0 then
            local v = string.match(res[1], [[java version "(.*)"]])
            if v == opt.ver then
                return true
            end
        end
        return false
    end
}
