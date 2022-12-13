#Loadbalancer VM
provider "azurerm" {
  features {}
  alias = "loadbalancer"
}

#Create a network interface for the loadbalancer VM
resource "azurerm_network_interface" "loadbalancer-nic" {
  name                = "loadbalancer-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "192.168.1.100"
    public_ip_address_id          = azurerm_public_ip.loadbalancer-pip.id
  }
}

#ceaate a public ip for the loadbalancer VM
resource "azurerm_public_ip" "loadbalancer-pip" {
  name                = "loadbalancer-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Create a ubuntu 18.04 VM
resource "azurerm_linux_virtual_machine" "loadbalancer-vm" {
  name                            = "loadbalancer"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  admin_username                  = var.ubuntu_user
  admin_password                  = var.ubuntu_pass
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.loadbalancer-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_ssh_key {
    username   = "mattice"
    public_key = file("~/.ssh/id_rsa.pub")
  }
}

