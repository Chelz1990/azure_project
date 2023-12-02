#  Create random name 
resource "random_string" "name" {
  length  = 6
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Create DNS zone
resource "azurerm_private_dns_zone" "db_dns" {
  name                = "${random_string.name.result}.${azurerm_mysql_flexible_server.wordpress.name}.com"
  resource_group_name = azurerm_resource_group.azp_rg.name
}

# Create DNS virtual network line
resource "azurerm_private_dns_zone_virtual_network_link" "db_dns_link" {
  name                  = "mysqlfsVnetZone${random_string.name.result}.com"
  private_dns_zone_name = azurerm_private_dns_zone.db_dns.name
  resource_group_name   = azurerm_resource_group.azp_rg.name
  virtual_network_id    = azurerm_virtual_network.ap_vnet.id

  depends_on = [azurerm_subnet.db_subnet]
}