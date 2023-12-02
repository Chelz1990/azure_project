# Create random resource for the database login
resource "random_string" "login" {
  length           = 8
  special          = false
  override_special = "/@£$"
  upper            = false
}

# Create random resource for the database password
resource "random_string" "password" {
  length           = 16
  special          = true
  upper            = true
  min_numeric = 4
  lower = true
}

# Create MySQL Server
resource "azurerm_mysql_flexible_server" "wordpress" {
  name                = "az1tp2ev3cproject"
  location            = azurerm_resource_group.azp_rg.location
  resource_group_name = azurerm_resource_group.azp_rg.name

  administrator_login          = "${random_string.login.result}"
  administrator_password = "${random_string.password.result}"
  delegated_subnet_id          = azurerm_subnet.db_subnet.id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = azurerm_private_dns_zone.db_dns.id
  sku_name                     = "GP_Standard_D2ds_v4"
  version                      = "8.0.21"
  zone = 1

  high_availability {
    mode                      = "ZoneRedundant"
    standby_availability_zone = "2"
  }
  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
  storage {
    iops    = 360
    size_gb = 20
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_dns_link]
  
  provisioner "local-exec" {
    command = "ansible-playbook wordpress.yml"
  }
}

