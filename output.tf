output "username" {
    value = "${azurerm_mysql_flexible_server.wordpress.administrator_login}"
}

output "password" {
    value = "${azurerm_mysql_flexible_server.wordpress.administrator_password}"
    sensitive = true
}
