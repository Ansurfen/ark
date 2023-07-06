-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "sink [software]" },
    run = function(cmd, args)
        if #args == 0 then
            yassert("arguments too little")
        end
        local target = args[1]
        local version = ""
        local software = target
        if strings.Contains(target, "@") then
            local before, after, ok = strings.Cut(target, "@")
            if not ok then
                yassert("err")
            end
            software = before
            version = after
        end
        local wd, err = pwd()
        yassert(err)
        local g_path = path.join(env.yock_path, "yock_modules", software, "boot")
        local module
        if is_exist(g_path .. ".lua") then
            module = import(g_path)
        else
            local todo = jsonfile:open(path.join(wd, "todo.json"))
            ---@diagnostic disable-next-line: undefined-field
            local url = todo.buf[target]
            local file = fetch.script(url)
            module = import(path.join(env.yock_tmp, file))
        end
        -- module.load
        module.ark.sink({
            ver = version,
            name = software
        })
        local ark = import("ark-core@1.0")
    end,
    flags = {}
}
