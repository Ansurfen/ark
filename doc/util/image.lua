-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

---@meta _

---@class imagelib
---@field file jsonfile
local image = {}

---@return imagelib
function image:new()
end

function image:save()
end

---@param k string
function image:free(k)
end

---@return table
function image:list()
end

---@param id string
---@param name string
---@param ver string
---@param src string
function image:safe_store(id, name, ver, src)
end
