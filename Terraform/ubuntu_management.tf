#Create a ubuntu vm
provider "azurerm" {
  features {}
  alias = "management"
}

#create public ip
resource "azurerm_public_ip" "management-pip" {
  name                = "management-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Create a network interface for the webserver VM
resource "azurerm_network_interface" "management-nic" {
  name                = "management-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "192.168.1.10"
    public_ip_address_id          = azurerm_public_ip.management-pip.id
  }
}


#Create a ubuntu 18.04 VM
resource "azurerm_linux_virtual_machine" "management-vm" {
  name                            = "management-vm"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = "Standard_B1s"
  admin_username                  = var.ubuntu_user
  admin_password                  = var.ubuntu_pass
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.management-nic.id]

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

  connection {
    host     = "192.168.1.10"
    type     = "ssh"
    user     = var.ubuntu_user
    password = var.ubuntu_pass
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${var.ubuntu_pass}' | sudo -S apt update -y",
      "echo '${var.ubuntu_pass}' | sudo -S apt install software-properties-common",
      "echo '${var.ubuntu_pass}' | sudo -S apt-add-repository --yes --update ppa:ansible/ansible",
      "echo '${var.ubuntu_pass}' | sudo -S apt install ansible -y",
    ]
  }

}

