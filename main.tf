provider "azurerm" {
    features {
    }

}
resource "azurerm_virtual_network" "nikhils_vnet" {
    name = "nikhils_vnet"
    resource_group_name = var.resource_group_name
    address_space = var.cidr
    location = "eastus"
}
resource "azurerm_subnet" "public_subnet-1" {
    name = "public_subnet-1"
    resource_group_name = var.resource_group_name
    virtual_network_name = "nikhils_vnet"
    address_prefixes = var.Subent_cidr
}

#The Public IP is necessary for any resource that needs internet access.
resource "azurerm_public_ip" "example" {
    name = "public_example_ip"
    location = var.region
    resource_group_name = var.resource_group_name
    #allocation_method: Determines if the IP is static or dynamic.
    allocation_method = dynamic
}

#In Azure, a Network Interface links the VM to the subnet and public IP. AWS handles this via Elastic Network Interfaces (ENIs) but typically hides this complexity during configuration.

resource "azurerm_network_interface" "network_interface_1" {
  name                = "example-nic"
  location            = var.region
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
}
