#Webserver VM
provider "azurerm" {
  features {}
  alias = "webserver"
}

#Create a network interface for the webserver VM
resource "azurerm_network_interface" "webserver-nic" {
  count               = 2
  name                = "nic-webserver-${count.index}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "192.168.1.10${count.index + 1}"
  }
}

#Create a ubuntu 18.04 VM
resource "azurerm_linux_virtual_machine" "webserver-vm" {
  count                           = 2
  name                            = "webserver-${count.index}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  admin_username                  = var.ubuntu_user
  admin_password                  = var.ubuntu_pass
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.webserver-nic[count.index].id]

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
}

