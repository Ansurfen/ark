-- Copyright 2023 {{.author}}. All rights reserved.
-- Use of this source code is governed by a {{.license}}-style
-- license that can be found in the LICENSE file.

---@diagnostic disable: undefined-global

return function(handle, opt)
    return handle({
        require = "{{.require}}",
        meta = opt,
        check = function()
            return CheckEnv({{.pullCheckWant}}, {{.pullCheckGot}})
        end,
        dir = debug.getinfo(1, 'S').source
    })
end
