# Create virtual network
resource "azurerm_virtual_network" "ap_vnet" {
  name                = "azure-project-vnet"
  location            = azurerm_resource_group.azp_rg.location
  resource_group_name = azurerm_resource_group.azp_rg.name
  address_space       = ["10.0.0.0/16"]
}

# Create subnet for vm
resource "azurerm_subnet" "vm_subnet" {
  name                 = "azure-project-vm-subnet"
  resource_group_name  = azurerm_resource_group.azp_rg.name
  virtual_network_name = azurerm_virtual_network.ap_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create subnet for scale set
resource "azurerm_subnet" "ss_subnet" {
  name                 = "azure-project-ss-subnet"
  resource_group_name  = azurerm_resource_group.azp_rg.name
  virtual_network_name = azurerm_virtual_network.ap_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create subnet for database
resource "azurerm_subnet" "db_subnet" {
  name                 = "azure-project-db-subnet"
  resource_group_name  = azurerm_resource_group.azp_rg.name
  virtual_network_name = azurerm_virtual_network.ap_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
