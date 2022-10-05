resource "azurerm_virtual_machine" "atmvm01" {
  name                  = "atmvm01"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = "Standard_B2s"
  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter-Server-Core-smalldisk"
    version   = "latest"
  }
  storage_os_disk {
    name              = "atmvm01os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "atmvm01"
    admin_username = "atmuser"
    admin_password = resource.random_password.password.result
  }
  os_profile_windows_config {
  }
  tags = {
    environment = "test"
    provisioner = "terraform"
  }
}
