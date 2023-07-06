-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

local container = {}

function container:new()
    self.file = json.create(pathf("#1", "../../container.json"))
    return self
end

function container:add(path, image, software, version)
    local id               = random.str(32)
    container.file.buf[id] = {
        image = image,
        path = path,
        software = software,
        version = version
    }
    return id
end

function container:rm(id)
    container.file.buf[id] = nil
end

function container:query(id)
    if container.file.buf[id] ~= nil then
        return container.file.buf[id]
    end
    for k, _ in pairs(container.file.buf) do
        if strings.HasPrefix(k, id) then
            id = k
            break
        end
    end
    return container.file.buf[id]
end

function container:list()
    return container.file.buf
end

function container:set()

end

function container:save()
    container.file:save(true)
end

return container
