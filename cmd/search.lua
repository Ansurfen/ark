-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "search" },
    run = function(cmd, args)
        local wd = path.join(debug.getinfo(1, 'S').source, "../..")
        local rows = {}

        if #args == 0 then
            path.walk(path.join(wd, "repo"), function(p, info, err)
                if not info:IsDir() then
                    local conf, err = open_conf(p)
                    yassert(err)
                    local author = conf:GetString("default.author")
                    local license = strings.ToUpper(conf:GetString("default.license"))
                    local description = conf:GetString("default.description")
                    local version = conf:GetString("default.version")
                    table.insert(rows, { path.base(path.dir(p)), author, version, license, description })
                end
                return true
            end)
            printf({ "Name", "Supplier", "Version", "License", "Description" }, rows)
        else
            local software = args[1]

            path.walk(path.join(wd, "repo"), function(p, info, err)
                if not info:IsDir() then
                    if strings.Contains(p, software) then
                        local conf, err = open_conf(p)
                        yassert(err)
                        local author = conf:GetString("default.author")
                        local license = strings.ToUpper(conf:GetString("default.license"))
                        local description = conf:GetString("default.description")
                        local version = conf:GetString("default.version")
                        table.insert(rows, { path.base(path.dir(p)), author, version, license, description })
                    end
                end
                return true
            end)
            printf({ "Name", "Supplier", "Version", "License", "Description" }, rows)
            -- local todo = jsonfile:open(path.join(wd, "todo.json"))
            -- for key, _ in pairs(todo.buf) do
            --     if key == software then
            --         local g_path = path.join(env.yock_path, "yock_modules", software, "boot")
            --         local module = import(g_path)
            --         module.ark.sail(import("ark-core/1_0/sail"), {})
            --         break
            --     end
            -- end
        end
    end,
    flags = {}
}
