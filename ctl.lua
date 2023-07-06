-- Copyright 2023 The Ark Authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

prompt({
    desc = {
        use = "ark",
        short = "ark is an software manager tool"
    },
    sub = {
        import("./cmd/search"),
        import("./cmd/sink"),
        import("./cmd/pull"),
        import("./cmd/load"),
        import("./cmd/images"),
        import("./cmd/map"),
        import("./cmd/version"),
        import("./cmd/unload"),
        import("./cmd/rmi"),
        import("./cmd/fix"),
        import("./cmd/cargo")
    },
})
