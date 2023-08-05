return function()
    local res = {}
    path.walk(pathf("#1", "../..", "repo"), function(p, info, err)
        if err ~= nil then
            return false
        end
        if filepath.Ext(p) == ".lua" then
            local meta = import(p)
            if type(meta) == "table" and meta.resolved ~= nil then
                table.insert(res, {
                    software = path.filename(p),
                    ver = meta.version or ""
                })
            end
        end
        return true
    end)
    return res
end
