# Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "rg-terraform-vm"
  location = "newzealandnorth"
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-terraform-vm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/20"]

  # Subnet
  subnet {
    name                 = "subnet-terraform-vm"
    address_prefixes     = ["10.0.1.0/24"]
  }

  tags = {
    environment = "Production"
  }
}

