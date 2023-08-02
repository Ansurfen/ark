local chocie = import("./choice")

local spec = {
    suffix = "zip"
}

local res, repo = chocie({
    os = "windows",
    ver = "17",
    spec = spec,
    software = "java"
})

table.dump(res)
table.dump(repo)
