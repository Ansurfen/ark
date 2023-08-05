---@diagnostic disable: missing-fields

option({
    ycho = {
        stdout = true
    }
})

prompt({
    desc = { use = "ark" },
    sub = {
        import("./cmd/ls"),
        import("./cmd/install"),
        import("./cmd/uninstall"),
        import("./cmd/repo")
    }
})
