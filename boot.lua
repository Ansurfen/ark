---@diagnostic disable: undefined-global
local defaultTarget = function(ver)
    local tmpl = "https://github.com/ansurfen/ark/releases/download/{{.Ver}}/{{.Target}}"
    local target = "ark"
    if env.platform.OS == "windows" then
        target = target .. ".zip"
    else
        target = target .. ".tar.gz"
    end
    return strf(tmpl, {
        ver = ver,
        target = target,
    })
end

local defaultVersion = "0.0.1.1"

return {
    version = defaultVersion,
    name = "ark",
    load = function(opt)
        local file = fetch.zip(opt.url or defaultTarget(opt.ver or defaultVersion))
        uncompress(file, pathf(env.yock_path, "test/yock_modules/ark"))
    end
}
