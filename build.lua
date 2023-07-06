rm({ safe = false }, "./tmp/ark")
mkdir("./tmp/ark")
cp({ recuse = true }, {
    ["README.md"] = "./tmp/ark",
    ["boot.lua"] = "./tmp/ark",
    ["ctl.lua"] = "./tmp/ark",
    ["util"] = "./tmp/ark/util",
    ["example"] = "./tmp/ark/example",
    ["doc"] = "./tmp/ark/doc",
    ["cmd"] = "./tmp/ark/cmd"
})
compress("./tmp/ark", "ark.zip")
cd("./tmp")
compress("./ark", "../ark.tar.gz")
cd("..")
rm({ safe = false }, "./tmp")
