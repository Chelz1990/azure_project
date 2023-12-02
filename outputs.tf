output "username" {
    value = "${azurerm_mysql_flexible_server.wordpress.administrator_login}"
    depends_on = [azurerm_mysql_flexible_server.wordpress]
}

output "password" {
    value = "${azurerm_mysql_flexible_server.wordpress.administrator_password}"
    sensitive = true
    depends_on = [azurerm_mysql_flexible_server.wordpress]
}