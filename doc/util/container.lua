-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

---@meta _

---@class containerlib
local container = {}

---@return containerlib
function container:new()
end

---@param path string
---@param image string
---@param software string
---@param version string
---@return string
function container:add(path, image, software, version)
end

---@return string
function container:rm(id)
end

---@param id string
---@return table
function container:query(id)
end

---@return table
function container:list()
end

function container:save()
end
