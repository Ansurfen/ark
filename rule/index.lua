local windows = function(opt, repo)
    local choice = import("../util/choice")
    local res = choice({
        software = opt.software,
        ver = opt.ver,
        spec = {
            arch = env.platform.Arch
        }
    }, repo)
    for _, box in ipairs(res) do
        local file = fetch.file(box.value.url, "." .. box.value.check.suffix)
        if #file > 0 then
            if repo.document ~= nil then
                print(repo.document)
            end
            if box.value.check.suffix == "msi" or box.value.check.suffix == "exe" then
                local installed = false
                while not installed do
                    sh(file)
                    ::label::
                    fmt.Print("please input 1 to comfirm success for install, 2 to retry install, 3 to exit")
                    local num = io.read("*l")
                    if num == "1" then
                        return "-"
                    elseif num == "2" then
                        -- continue
                    elseif num == "3" then
                        return ""
                    else
                        goto label
                    end
                end
            end
        end
    end
    return ""
end

return {
    windows = windows
}
