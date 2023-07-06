-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    desc = { use = "rmi" },
    run = function(cmd, args)
        if #args == 0 then
            yassert("invalid id")
        end

        local id = args[1]
        local filename
        local url

        ---@type imagelib
        local image = import("../util/image"):new()

        for key, value in pairs(image:list()) do
            if strings.HasPrefix(key, id) then
                id = key
                filename = value["source"]
                break
            end
        end

        if filename == nil then
            yassert("file not found")
        end

        for key, value in pairs(ycache.buf) do
            if path.base(filename) == value then
                url = key
                break
            end
        end

        if filename ~= nil then
            ycache.buf[url] = nil
            ycache:write(true)
            image:free(id)
            image:save()
            print(filename)
            ---@diagnostic disable-next-line: param-type-mismatch
            rm({ safe = false, debug = true, redirect = true }, filename)
        end
    end
}
