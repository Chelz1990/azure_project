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

# Create random name for database
resource "random_string" "dbname" {
  length           = 6
  special          = false
  override_special = true
  upper            = false
  lower = true
  numeric = true
}

# Create MySQL Server
resource "azurerm_mysql_flexible_server" "wordpress" {
  name                = unknown
  location            = unknown
  resource_group_name = azurerm_resource_group.azp_rg.name

  administrator_login          = unknown
  administrator_password = unknown
  delegated_subnet_id          = unknown
  geo_redundant_backup_enabled = unknown
  private_dns_zone_id          = unknown
  sku_name                     = unknown
  version                      = unknown
  zone = 1

  high_availability {
    mode                      = unknown
    standby_availability_zone = unknown
  }
  maintenance_window {
    day_of_week  = unknown
    start_hour   = unknown
    start_minute = unknown
  }
  storage {
    iops    = unknown
    size_gb = unknown
  }


#  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_dns_link]
  
#  provisioner "local-exec" {
#    command = "ansible-playbook wordpress.yml"
#  }
}

