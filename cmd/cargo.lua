-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "cargo" },
    run = function(cmd, args)
        ---@type containerlib
        local con = import("../util/container"):new()
        local rows = {}
        for k, v in pairs(con:list()) do
            table.insert(rows, { k, v["image"], v["software"], v["version"], v["path"] })
        end
        printf({ "Container", "Image", "Software", "Version", "Path" }, rows)
    end
}
