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
  name                = 
  location            = azurerm_resource_group.azp_rg.location
  resource_group_name = azurerm_resource_group.azp_rg.name

  administrator_login          = 
  administrator_password =
  delegated_subnet_id          = 
  geo_redundant_backup_enabled = 
  private_dns_zone_id          = 
  sku_name                     = 
  version                      = 
  zone = 1

  high_availability {
    mode                      = 
    standby_availability_zone = 
  }
  maintenance_window {
    day_of_week  = 
    start_hour   = 
    start_minute = 
  }
  storage {
    iops    = 
    size_gb = 
  }


#  depends_on = [azurerm_private_dns_zone_virtual_network_link.db_dns_link]
  
#  provisioner "local-exec" {
#    command = "ansible-playbook wordpress.yml"
#  }
}

