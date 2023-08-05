return function(...)
    local todo = { ... }
    local fn = function(opt, repo)
        return ""
    end
    if #todo > 0 then
        if type(todo[1]) == "function" then
            fn = todo[1]
            table.remove(todo, 1)
        end
    end
    local install = import("../util/install")
    local zip = env.platform:Zip()
    for _, v in ipairs(todo) do
        local res = install.standard(v, {
            suffix = string.sub(zip, 2, #zip),
            arch = env.platform.Arch
        })
        if type(res) == "table" then
            local software, version
            if strings.Contains(v, "@") then
                software, version = strings.Cut(v, "@")
            else
                software = v
            end
            local file = fn({
                software = software,
                ver = version
            }, res)
            if #file > 0 then
                local jf = json.create(pathf(env.yock_path, "ark.json"), "{}")
                jf:set(v, file)
                jf:save(true)
            end
        end
    end
end
