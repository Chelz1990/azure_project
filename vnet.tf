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

# Create route table association for vm subnet
resource "azurerm_subnet_route_table_association" "vm_rt" {
  subnet_id      = azurerm_subnet.vm_subnet.id
  route_table_id = azurerm_route_table.azp_rt.id
}

# Create subnet for scale set
resource "azurerm_subnet" "ss_subnet" {
  name                 = "azure-project-ss-subnet"
  resource_group_name  = azurerm_resource_group.azp_rg.name
  virtual_network_name = azurerm_virtual_network.ap_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create route table association for scale set subnet
resource "azurerm_subnet_route_table_association" "ss_rt" {
  subnet_id      = azurerm_subnet.ss_subnet.id
  route_table_id = azurerm_route_table.azp_rt.id
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

# Create route table association for database subnet
resource "azurerm_subnet_route_table_association" "db_rt" {
  subnet_id      = azurerm_subnet.db_subnet.id
  route_table_id = azurerm_route_table.azp_rt.id
}

# Create route table 
resource "azurerm_route_table" "azp_rt" {
  name                          = "azure-project-route-table"
  location                      = azurerm_resource_group.azp_rg.location
  resource_group_name           = azurerm_resource_group.azp_rg.name
  disable_bgp_route_propagation = false
}  
