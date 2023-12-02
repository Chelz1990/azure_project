# Create route table 
resource "azurerm_route_table" "ap_rt" {
  name                          = "azure-project-route-table"
  location                      = azurerm_resource_group.azp_rg.location
  resource_group_name           = azurerm_resource_group.azp_rg.name
  disable_bgp_route_propagation = false
}  
