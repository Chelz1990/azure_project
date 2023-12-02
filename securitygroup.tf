# Create Security Group
resource "azurerm_network_security_group" "ap_sg" {
  name                = "azure-project-security-group"
  location            = azurerm_resource_group.azp_rg.location
  resource_group_name = azurerm_resource_group.azp_rg.name

  security_rule {
    name                        = "ssh"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "22"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                        = "http"
    priority                    = 110
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "8080"
    destination_port_range      = "8080"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }  

  security_rule {
    name                        = "https"
    priority                    = 120
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "443"
    destination_port_range      = "443"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }  

  security_rule {
    name                        = "mysql"
    priority                    = 130
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "3306"
    destination_port_range      = "3306"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }  

 security_rule {
    name                        = "all"
    priority                    = 150
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  } 
}
