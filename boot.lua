---@diagnostic disable: undefined-global
local defaultVersion = "0.0.2"

return {
    version = defaultVersion,
    name = "ark",
    load = function(opt)
        local target = "ark"
        if env.platform.OS == "windows" then
            target = target .. ".zip"
        else
            target = target .. ".tar.gz"
        end
        local file = multi_fetch({
            tag = target,
            ver = opt.ver or defaultVersion
        }, {
            github = "https://github.com/ansurfen/ark/releases/download/{{.Version}}/{{.Target}}",
            gitee = "https://gitee.com/ansurfen/ark/releases/download/{{.Version}}/{{.Target}}"
        })
        uncompress(pathf(env.yock_tmp, file), pathf(env.yock_path, "yock_modules"))
        cd(pathf(env.yock_modules, "ark"))
        sh("yock mount ark ctl.lua")
    end
}
