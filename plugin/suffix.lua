return function(v)
    local tmp = env.platform:Zip()
    return v == string.sub(tmp, 2, #tmp)
end
