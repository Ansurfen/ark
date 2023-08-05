-- Copyright The Ark authors. All rights reserved.
-- Use of this source code is governed by a MIT-style
-- license that can be found in the LICENSE file.

return {
    install = import("./install/index"),
    uninstall = import("./uninstall/index"),
    ls = import("./ls/index"),
    repo = import("./repo/index")
}
