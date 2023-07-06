-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

---@diagnostic disable: undefined-global

return {
    desc = { use = "map" },
    run = function(cmd, args)
        if #args == 0 then
            yassert("arguments too little")
        end
        local chart = args[1]

        local jf = jsonfile:open(chart)

        local requirePath = jf.buf["requirePath"]
        local outputPath = jf.buf["outputPath"]
        local pullCheckWant = string.format([["%s"]], jf.buf["pullCheck"][1])
        local tmp = jf.buf["pullCheck"][2]
        local author = jf.buf["author"]
        local license = jf.buf["license"]
        local url = jf.buf["url"]
        local version = jf.buf["version"]
        local description = jf.buf["description"]
        local supplier = jf.buf["supplier"]

        local pullCheckGot = [["]]
        local i = 1
        local scope = false
        while i <= #tmp do
            local ch = string.sub(tmp, i, i)
            if ch == "$" then
                if i + 1 <= #tmp and string.sub(tmp, i + 1, i + 1) == "{" then
                    i = i + 2
                    local key = ""
                    while i <= #tmp do
                        ch = string.sub(tmp, i, i)
                        if ch == "}" then
                            break
                        end
                        key = key .. ch
                        i = i + 1
                    end
                    pullCheckGot = pullCheckGot .. string.format([[" .. (opt["%s"] or "")]], key)
                    scope = true
                    i = i + 1
                    goto continue
                end
            end
            if scope then
                pullCheckGot = pullCheckGot .. [[ .. "]]
                scope = false
            end
            pullCheckGot = pullCheckGot .. ch
            i = i + 1
            ::continue::
        end
        if string.sub(pullCheckGot, #pullCheckGot - 2, #pullCheckGot) ~= [["")]] then
            pullCheckGot = pullCheckGot .. [["]]
        end

        mkdir(outputPath)

        local tmplPath = path.join(cur_dir(), "../tmpl")
        local out = read_file(path.join(tmplPath, "pull.tpl"))
        local t = tmpl()
        local out, err = t:OnceParse(out, {
            require = requirePath,
            pullCheckWant = pullCheckWant,
            pullCheckGot = pullCheckGot,
            author = author,
            license = license
        })
        yassert(err)
        write_file(path.join(outputPath, "pull.lua"), strings.ReplaceAll(out, "&#34;", [["]]))

        out = read_file(path.join(tmplPath, "sail.tpl"))
        out, err = t:OnceParse(out, {
            require = requirePath,
            author = author,
            license = license
        })
        yassert(err)
        write_file(path.join(outputPath, "sail.lua"), strings.ReplaceAll(out, "&#34;", [["]]))

        out = read_file(path.join(tmplPath, "load.tpl"))
        out, err = t:OnceParse(out, {
            require = requirePath,
            pullCheckWant = pullCheckWant,
            pullCheckGot = pullCheckGot,
            author = author,
            license = license
        })
        yassert(err)
        write_file(path.join(outputPath, "load.lua"), strings.ReplaceAll(out, "&#34;", [["]]))

        out = read_file(path.join(tmplPath, "repo.tpl"))
        out, err = t:OnceParse(out, {
            author = supplier,
            description = description,
            license = license,
            url = url,
            version = version
        })
        yassert(err)
        write_file(supplier .. ".ini", strings.ReplaceAll(out, "&#34;", [["]]))
    end
}
