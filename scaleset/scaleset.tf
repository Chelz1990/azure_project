# Create linux machine scale set
resource "azurerm_linux_virtual_machine_scale_set" "ap_ss" {
  name                = "azure-project-scale-set"
  resource_group_name = azurerm_resource_group.azp_rg.name
  location            = azurerm_resource_group.azp_rg.location
  sku                 = "Standard_F2"
  instances           = 1
  admin_username      = "adminuser"

 admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.public_ssh.public_key_openssh 
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "ss-nic"
    primary = true

    ip_configuration {
      name      = "ss-ip"
      primary   = true
      subnet_id = azurerm_subnet.ss_subnet.id
    }
  }
}