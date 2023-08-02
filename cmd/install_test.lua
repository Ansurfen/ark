local install = import("./install")
install.config({
    suffix = "zip"
}, "docker run -p 3306:3308 --name mysql -e MYSQL_ROOT_PASSWORD=123456 -d mysql:8.1.0")
