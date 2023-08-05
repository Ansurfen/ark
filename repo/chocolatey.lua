return {
    version = "2.2.0.0",
    resolved = {
        ["2.2.0.0"] = {
            windows = {
                {
                    check = { suffix = "msi" },
                    url = "https://github.com/chocolatey/choco/releases/download/2.2.0/chocolatey-2.2.0.0.msi"
                }
            },
            linux = {
                {
                    check = { suffix = "tar.gz" },
                    url = "https://github.com/chocolatey/choco/releases/download/2.2.0/chocolatey.v2.2.0.tar.gz"
                }
            },
            darwin = {
                {
                    check = { suffix = "tar.gz" },
                    url = "https://github.com/chocolatey/choco/releases/download/2.2.0/chocolatey.v2.2.0.tar.gz"
                }
            }
        }
    },
    exist = function()
        local _, err = sh("choco")
        if err ~= nil then
            return false
        end
        return true
    end
}
