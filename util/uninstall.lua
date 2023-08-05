return function(k)
    if not strings.Contains(k, "@") then
        yassert("invalid key, correct [software@version]")
    end
    local jf = json.create(pathf(env.yock_path, "ark.json"), "{}")
    local v = jf:rawget(k)
    local software, version, ok = strings.Cut(k, "@")
    if ok then
        local uninstall = import(pathf("#1", "../../repo/", software)).uninstall or function(opt) end
        uninstall({
            ver = version,
            path = v
        })
        rm({ safe = false }, v)
        rm(filepath.Dir(v))
        jf:rawset(k, nil)
        jf:save(true)
    end
end
