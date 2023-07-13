---@diagnostic disable: undefined-global
local defaultVersion = "0.0.2"

return {
    version = defaultVersion,
    name = "ark",
    load = function(opt)
        local target = "ark"
        local suffix
        if env.platform.OS == "windows" then
            target = target .. ".zip"
            suffix = ".zip"
        else
            target = target .. ".tar.gz"
            suffix = ".tar.gz"
        end
        local file = multi_fetch(suffix, {
            Target = target,
            Version = opt.ver or defaultVersion
        }, {
            github = "https://github.com/ansurfen/ark/releases/download/{{.Version}}/{{.Target}}",
            gitee = "https://gitee.com/ansurfen/ark/releases/download/{{.Version}}/{{.Target}}"
        })
        uncompress(file, pathf(env.yock_path, "yock_modules"))
        cd(pathf(env.yock_modules, "ark"))
        sh("yock mount ark ctl.lua")
    end
}
