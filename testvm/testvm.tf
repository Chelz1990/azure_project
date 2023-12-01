# Create Network Interface for VM
resource "azurerm_network_interface" "ap_nic" {
  name                = "azure-project-vm-nic"
  location            = azurerm_resource_group.azp_rg.location
  resource_group_name = azurerm_resource_group.azp_rg.name

  ip_configuration {
    name                          = "vm-nic"
    subnet_id                     = azurerm_subnet.vm_subnet.id
    public_ip_address_id = azurerm_public_ip.vm_ip.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create public ip for VM
resource "azurerm_public_ip" "vm_ip" {
  name                = "azure-project-vm-public"
  resource_group_name = azurerm_resource_group.azp_rg.name
  location            = azurerm_resource_group.azp_rg.location
  allocation_method   = "Dynamic"
}

# Create ssh key
resource "tls_private_key" "public_ssh" {
    algorithm = "RSA"
    rsa_bits = 4096
}


# Create web facing virtual machine
resource "azurerm_linux_virtual_machine" "azp_vm" {
  name                = "azure-project-virtual-machine"
  resource_group_name = azurerm_resource_group.azp_rg.name
  location            = azurerm_resource_group.azp_rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.ap_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = tls_private_key.public_ssh.public_key_openssh 
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}