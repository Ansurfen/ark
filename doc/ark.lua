---@meta _

---@vararg string
function install(...) end

---@vararg string
function uninstall(...) end

---@return table
function ls() end

---@return table
function repo() end

---@class ark
---@field install fun(...)
---@field uninstall fun(...)
---@field ls fun():table
---@field repo fun():table
local ark = {}

---@vararg string
function ark.install(...) end

---@vararg string
function ark.uninstall(...) end

---@return table
function ark.ls() end

---@return table
function ark.repo() end
