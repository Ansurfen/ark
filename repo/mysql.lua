local defaultVersion = "8.1.0"
local defaultSetting = [[
# For advice on how to change settings please see
# http://dev.mysql.com/doc/refman/5.6/en/server-configuration-defaults.html
# *** DO NOT EDIT THIS FILE. It's a template which will be copied to the
# *** default location during install, and will be replaced if you
# *** upgrade to a newer version of MySQL.
[client]
default-character-set = utf8mb4
[mysql]
default-character-set = utf8mb4
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_bin
init_connect='SET NAMES utf8mb4'
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
innodb_buffer_pool_size = 128M
# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin
# These are commonly set, remove the # and set as required.
# basedir = {{ .Basedir }}
# datadir = {{ .Datadir }}
port = 3306
server_id = 1
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
join_buffer_size = 128M
sort_buffer_size = 16M
read_rnd_buffer_size = 16M
sql_mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES]]

return {
    version = defaultVersion,
    resolved = {
        ["8.1.0"] = {
            windows = {
                {
                    check = {
                        suffix = "zip"
                    },
                    url = "https://cdn.mysql.com//Downloads/MySQL-8.1/mysql-8.1.0-winx64.zip"
                }
            }
        }
    },
    install = function(opt)
        local found = false
        local ini
        path.walk(opt.path, function(p, info, err)
            if info:IsDir() then
                return true
            end
            if filepath.Base(p) == "my.ini" then
                ini = p
                found = true
            end
            return true
        end)
        if not found then
            ini = pathf(opt.path, "my.ini")
            write(ini, defaultSetting)
        end
        local c = conf.open(ini)
        if opt.meta.cfg["-p"] ~= nil then
            c:write("mysqld.port", opt.meta.cfg["-p"])
        end
        c:save()
    end,
    uninstall = function (opt)
        table.dump(opt)
    end
}