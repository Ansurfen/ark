return {
    desc = { use = "install", short = "install software to be specified" },
    run = function(cmd, args)
        local install = import("../util/install")

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
                if spec.suffix == nil then
                    local zip = env.platform:Zip()
                    spec.suffix = string.sub(zip, 2, #zip)
                end
                if spec.arch == nil then
                    spec.arch = env.platform.Arch
                end
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
}
