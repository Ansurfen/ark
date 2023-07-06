-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

---@diagnostic disable: undefined-global

return {
    desc = { use = "images" },
    run = function(cmd, args)
        ---@type imagelib
        local image = import("../util/image"):new()

        local rows = {}
        for key, value in pairs(image:list()) do
            local ts, err = strconv.Atoi(value["createAt"])
            yassert(err)
            table.insert(rows, { value["software"], value["version"], key, time.Unix(ts, 0):String() })
        end
        printf({ "Image", "Version", "ID", "Created" }, rows)
    end
}
