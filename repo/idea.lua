return {
    version = "2023.2",
    resolved = {
        ["2023.2"] = {
            windows = {
                {
                    check = { suffix = "exe", to = "ultimate" },
                    url = "https://download.jetbrains.com/idea/ideaIU-2023.2.exe"
                },
                {
                    check = { suffix = "exe", to = "community" },
                    url = "https://download.jetbrains.com/idea/ideaIC-2023.2.exe"
                }
            }
        }
    }
}
