-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

local image = {}

function image:new()
    self.file = json.create(pathf("#1", "../../images.json"))
    return self
end

function image:save()
    image.file:save(true)
end

function image:free(k)
    image.file.buf[k] = nil
end

function image:safe_store(id, name, ver, src)
    if image.file.buf[id] == nil then
        image.file.buf[id] = {
            software = name,
            version = ver,
            source = src,
            createAt = strconv.Itoa(time.Now():Unix()),
        }
    end
end

function image:list()
    return image.file.buf
end

return image
