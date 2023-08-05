return {
    desc = { use = "repo", short = "list software info from repository" },
    run = function(cmd, args)
        local repos = import("../util/repo")()
        for _, repo in ipairs(repos) do
            print(repo.software, repo.ver)
        end
    end
}
