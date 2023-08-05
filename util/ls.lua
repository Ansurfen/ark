return function()
    local jf = json.create(pathf(env.yock_path, "ark.json"), "{}")
    return jf.buf
end
