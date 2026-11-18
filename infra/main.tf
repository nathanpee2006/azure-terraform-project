# Resource Group
resource "azurerm_resource_group" "resource_group" {
  name     = "rg-terraform-vm"
  location = "newzealandnorth"
}

# Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-terraform-vm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  security_rule {
    name                       = "AllowSSHInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.admin_ip}/32"
    destination_address_prefix = "*"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-terraform-vm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  address_space       = ["10.0.0.0/20"]

  # Subnet
  subnet {
    name             = "subnet-terraform-vm"
    address_prefixes = ["10.0.1.0/24"]
  }

  tags = {
    environment = "Production"
  }
}

# Public IP Address
resource "azurerm_public_ip" "public_ip" {
  name                = "pip-terraform-vm"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  allocation_method   = "Static"
}

