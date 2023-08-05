local choice = function(opt, repo)
    local got = opt["spec"]
    local res = {}
    for _, v in ipairs(repo.resolved[opt.ver or repo.version][opt.os or env.platform.OS]) do
        local pass = true
        local w = 0
        for key, vv in pairs(v["check"]) do
            if got[key] ~= nil then
                if got[key] == vv then
                    w = w + 1
                else
                    pass = false
                    break
                end
            end
        end
        if pass then
            table.insert(res, { value = v, weight = w })
        end
    end
    return res, repo
end

---@param opt table
return function(opt, repo)
    if repo == nil then
        return choice(opt, import(pathf("#1", "../..", "repo", opt["software"] .. ".lua")))
    end
    return choice(opt, repo)
end
