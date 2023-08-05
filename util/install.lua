local install = function(opt)
    local choice = import("./choice")
    local res, repo = choice(opt)

    if type(repo.exist) == "function" then
        local exist = repo.exist(opt)
        if type(exist) == "boolean" and exist then
            fmt.Printf("%s already exist", opt.software)
            return
        end
    end

    for i, box in ipairs(res) do
        for key, value in pairs(box.value["check"]) do
            local path = pathf("#1", "../..", "plugin", key .. ".lua")
            if find(path) then
                local plugin = import(pathf("#1", "../../plugin", key .. ".lua"))
                local ok = plugin(value)
                if not ok and opt.spec[key] == value then
                    ok = true
                end
                if not ok then
                    table.remove(res, i)
                end
            end
        end
    end

    local box

    if #res == 1 then
        box = res[1].value
    elseif #res > 1 then
        local tmp = {}
        local base = 0
        for _, v in ipairs(res) do
            if v.weight > base then
                base = v.weight
            end
        end
        for _, v in ipairs(res) do
            if v.weight == base then
                table.insert(tmp, v.value)
            end
        end
        res = tmp
        box = res[time.Now():Unix() % #res + 1]
    else
        if repo["resolved"].bad ~= nil then
            local bad = repo["resolved"]["bad"][opt.os or env.platform.OS]
            if type(bad) == "function" then
                return bad(opt)
            end
            return repo
        end
    end

    local file = fetch.file(box.url, "." .. box.check.suffix or filepath.Ext(box.url))
    for _, value in ipairs(json.open(pathf("#1", "../filter.json")).buf) do
        if strings.HasSuffix(file, value) then
            fmt.Printf("%s try install by hand\n", file)
            return
        end
    end
    local bin_path = pathf(env.yock_bin, opt.software, opt.ver)
    if not find(bin_path) then
        local root, err = uncompress(file, bin_path)
        yassert(err)
        if type(repo.install) == "function" then
            repo.install({
                path = pathf(bin_path, root),
                meta = opt
            })
        end
        local target = pathf(bin_path, root)
        print(target)
        local jf = json.create(pathf(env.yock_path, "ark.json"), "{}")
        jf:rawset(strf("%s@%s", opt.software, opt.ver), target)
        jf:save(true)
    else
        local jf = json.create(pathf(env.yock_path, "ark.json"), "{}")
        print(jf:rawget(strf("%s@%s", opt.software, opt.ver)))
    end
end

return {
    standard = function(meta, spec)
        if strings.Contains(meta, "@") then
            local software, version, ok = strings.Cut(meta, "@")
            if ok then
                return install({
                    software = software,
                    ver = version,
                    spec = spec,
                    cfg = {}
                })
            end
        else
            return install({
                software = meta,
                spec = spec,
                cfg = {}
            })
        end
    end,
    config = function(spec, cmd)
        local cmdparse = import("opencmd/util/cmdparse")
        local c = cmdparse(cmd, {
            ["-p"] = flag_type.str,
            ["--name"] = flag_type.str,
            ["-e"] = flag_type.arr,
            ["-d"] = flag_type.str
        })
        if c["-p"] ~= nil and strings.Contains(c["-p"], ":") then
            _, c["-p"], _ = strings.Cut(c["-p"], ":")
        end
        local software, version, ok = strings.Cut(c["-d"], ":")
        if ok then
            return install({
                software = software,
                ver = version,
                spec = spec,
                cfg = c
            })
        end
    end
}
