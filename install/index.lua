return function(...)
    local install = import("ark/cmd/install")
    for _, v in ipairs({ ... }) do
        install.standard(v, {
            suffix = env.platform:Zip(),
            arch = env.platform.Arch
        })
    end
end
