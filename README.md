# Wordpress Server on MySQL

Host a wordpress server on a MySQL database on Microsoft Azure.

## Initialize

To initialze the backend. 

```bash
make init
```

## Apply

To provision the infrastrucure. 

```bash
make apply
```

## Destory

To destroy the infrastructure.

```bash
make destory
```

## Additional Notes

To use a different region, make sure to edit the provisoner file in main.tf

``` sh
# Create a resource group
resource "azurerm_resource_group" "azp_rg" {
  name     = "azure-project-resource-group"
  location = "EXAMPLE"
}
```
