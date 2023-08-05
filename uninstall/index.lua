return function(...)
    local uninstall = import("../util/uninstall")
    for _, v in ipairs({ ... }) do
        uninstall(v)
    end
end
