---@diagnostic disable: missing-fields

option({
    ycho = {
        stdout = true
    }
})

prompt({
    desc = { use = "ark" },
    sub = {
        {
            desc = { use = "ls", short = "list softwares" },
            run = function(cmd, args)
                local ls = import("./cmd/ls")
                for key, value in pairs(ls()) do
                    print(key, value)
                end
            end
        },
        {
            desc = { use = "install", short = "install software to be specified" },
            run = function(cmd, args)
                local install = import("./cmd/install")

                local installParameter = env.params["/ark/install"]

                local rule = installParameter["r"]:Var()
                local spec = installParameter["s"]:Var()

                if type(spec) == "table" then
                    local tmp = {}
                    for _, s in ipairs(spec) do
                        local k, v, ok = strings.Cut(s, "=")
                        if ok then
                            tmp[k] = v
                        end
                    end
                    spec = tmp
                end

                if #rule == 0 then
                    if #args == 0 then
                        yassert("")
                    else
                        install.standard(args[1], spec)
                    end
                else
                    install.config(spec, rule)
                end
            end,
            flags = {
                {
                    type = flag_type.str,
                    default = "",
                    shorthand = "r",
                    name = "rule",
                    usage = ""
                },
                {
                    type = flag_type.arr,
                    default = {},
                    shorthand = "s",
                    name = "spec",
                    usage = ""
                }
            }
        },
        {
            desc = { use = "uninstall", short = "uninstall software to be specified" },
            run = function(cmd, args)
                if #args == 0 then
                    yassert("use `ark uninstall [software@version]`")
                end
                local uninstall = import("./cmd/uninstall")
                uninstall(args[1])
            end
        },
    }
})
