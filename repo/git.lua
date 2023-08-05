return {
    version = "2.41.0",
    resolved = {
        ["2.41.0"] = {
            windows = {
                {
                    check = { suffix = "exe", arch = "386" },
                    url =
                    "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-32-bit.exe"
                },
                {
                    check = { suffix = "exe", arch = "amd64" },
                    url =
                    "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-64-bit.exe"
                }
            },
        },
        bad = {
            linux = function(opt)
                local apt_get = import("opencmd/apt-get")
                if apt_get.exist() then
                    sh([[apt-get install git]])
                end
            end,
            darwin = function(opt)
                -- sh([[brew install git]])
            end,
            freebsd = function(opt)

            end
        }
    },
    exist = function()
        local _, err = sh("git")
        if err ~= nil then
            return false
        end
        return true
    end
}
