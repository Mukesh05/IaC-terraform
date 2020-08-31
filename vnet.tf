provider "azurerm" {
	version = "~>2.0"
features {}
}
resource "azurerm_resource_group" "JenkinsRG" {
	name =  "JenkinsRG"
	location =  "east us"
}
resource "azurerm_virtual_network" "JenkinsDemo" {
  name                = "JenkinsDemo"
  location            = azurerm_resource_group.JenkinsRG.location
  resource_group_name = azurerm_resource_group.JenkinsRG.name
  address_space       = [
    "10.0.0.0/24"
  ]
  tags = {
  }  
}
