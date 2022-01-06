terraform {
  backend "azurerm" {
    resource_group_name  = "Karol-rq01"
    storage_account_name = "kwsto"
    container_name       = "state"
    key                  = "kwstate.tfstate"
  }
}
 
provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x.
  # If you're using version 1.x, the "features" block is not allowed.
  version = "~>2.0"
  features {}
}
 
data "azurerm_client_config" "current" {}
 
#Create Resource Group
resource "azurerm_resource_group" "tamops" {
  name     = "kw-rg-tf"
  location = "westeurope"
}
 
#Create Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "kww-vnet-tf"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.tamops.name
}
 
# Create Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "kw-subnet-tf"
  resource_group_name  = azurerm_resource_group.tamops.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "192.168.0.0/24"
}