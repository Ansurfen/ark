return {
    desc = { use = "uninstall", short = "uninstall software to be specified" },
    run = function(cmd, args)
        if #args == 0 then
            yassert("use `ark uninstall [software@version]`")
        end
        local uninstall = import("../util/uninstall")
        uninstall(args[1])
    end
}
