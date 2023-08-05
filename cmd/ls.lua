return {
    desc = { use = "ls", short = "list softwares" },
    run = function(cmd, args)
        local ls = import("../util/ls")
        for key, value in pairs(ls()) do
            print(key, value)
        end
    end
}
