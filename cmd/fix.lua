-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "fix", short = "Updates images data" },
    run = function(cmd, args)
        ---@type imagelib
        local image = import("../util/image"):new()

        for key, value in pairs(image:list()) do
            local source = value["source"]
            if source == nil or not is_exist(source) then
                image:free(key)
            end
        end
        image:save()
    end
}
