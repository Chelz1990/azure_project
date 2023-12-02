#  Create random name 
resource "random_string" "dbname" {
  length  = 6
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_mysql_flexible_server" "wordpress" {
  name                   = "${random_string.dbname.result}azpproject.wordpress.com"
  resource_group_name    = azurerm_resource_group.azp_rg.name
  location               = azurerm_resource_group.azp_rg.location
}

#  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_dns_link]
  
#  provisioner "local-exec" {
#    command = "ansible-playbook wordpress.yml"
#  }


