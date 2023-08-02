-- Copyright The ark authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

---@diagnostic disable: undefined-global

return {
    version = "0.0.2",
    name = "ark",
    author = "The ark authors",
    desc = "",
    url = "",
    license = "MIT",
    load = function(opt)
        sh(string.format([[yock mount ark %s]], pathf("#1", "..", "ctl.lua")))
    end,
    unload = function(opt)
    end
}
