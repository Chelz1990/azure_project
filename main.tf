terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.82.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = true 
  features {}
} 

# Create a resource group
resource "azurerm_resource_group" "azp_rg" {
  name     = "azure-project-resource-group"
  location = "eastus"
}