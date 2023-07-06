-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "pull", short = "Pull image into local" },
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
        local wd = path.join(debug.getinfo(1, 'S').source, "../..")

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
        local file = module.ark.pull(import("ark-core/1_0/pull"), {
            ver = version,
            name = software
        })
        ---@type imagelib
        local image = import("../util/image"):new()

        local id = path.filename(file)
        image:safe_store(id, software, version, path.join(env.yock_tmp, file))
        image:save()
        print(id)
    end
}
