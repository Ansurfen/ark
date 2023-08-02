-- Copyright [Author]. All rights reserved.
-- Use of this source code is governed by a [License]-style
-- license that can be found in the LICENSE file.

return {
    install = import("./cmd/install"),
    uninstall = import("./cmd/uninstall"),
    ls = import("./cmd/ls"),
}
