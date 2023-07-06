-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "load", short = "Load image to run" },
    run = function(cmd, args)
        if #args == 0 then
            yassert("arguments too little")
        end
        local id = args[1]
        ---@type imagelib
        local image = import("../util/image"):new()
        local software
        local version

        for key, value in pairs(image:list()) do
            if strings.HasPrefix(key, id) then
                software = value["software"]
                version = value["version"]
                id = key
                break
            end
        end

        if software == nil then
            yassert("invalid id")
        end

        local g_path = path.join(env.yock_path, "yock_modules", software, "boot")
        local module = import(g_path)
        local dst = path.join(env.yock_bin, software, version)
        module.ark.load(import("ark-core/1_0/load"), {
            id = id,
            path = dst
        })
        local con = import("../util/container"):new()
        id = con:add(dst, id, software, version)
        con:save()
        image:save()
        print(id)
    end,
    flags = {
        {
            type = flag_type.str,
            name = "volume",
            shorthand = "v",
            default = "",
            usage = ""
        }
    }
}
