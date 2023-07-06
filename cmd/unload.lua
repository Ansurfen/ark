-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "unload", short = "Remove container to be specified" },
    run = function(cmd, args)
        if #args == 0 then
            yassert("invalid id")
        end

        local id = args[1]
        ---@type containerlib
        local con = import("../util/container"):new()

        for k, _ in pairs(con:list()) do
            if strings.HasPrefix(k, id) then
                id = k
                break
            end
        end
        local meta = con:query(id)
        if meta == nil then
            yassert("id not found")
        else
            rm({ safe = false }, meta.path)
            con:rm(id)
            con:save()
        end
    end
}
