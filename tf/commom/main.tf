###########################
# CONFIGURATION
###########################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"

    }
  }

  backend "azurerm" {

  }
}

###########################
# VARIABLES
###########################

variable "rg_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "rg_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix ofthe resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

###########################
# PROVIDERS
###########################

provider "azurerm" {
  features {}
}

###########################
# DATA SOURCES
###########################

locals {
  #name = "${var.prefix}-${random_id.seed.hex}"
  name = "${var.rg_name_prefix}-${random_id.seed.hex}"
}

###########################
# RESOURCES
###########################

#Resource group creation
resource "azurerm_resource_group" "rg_ny_traffic_study" {
  prefix = var.rg_name_prefix
}

resource "azurerm_resource_group" "rg_ny_traffic_study" {
  location = var.rg_location
  name     = azurerm_resource_group.rg_ny_traffic_study.id
}
########

resource "random_id" "seed" {
  byte_length = 4
}

resource "azurerm_resource_group" "vnet" {
  name     = local.name
  location = var.region
}

resource "azurerm_virtual_network" "vnet" {
  resource_group_name = azurerm_resource_group.vnet.name
  location            = azurerm_resource_group.vnet.location
  name                = "ado-network"
  address_space       = ["10.42.0.0/24"]

  subnet {
    name           = "web"
    address_prefix = "10.42.0.0/24"
  }
}

resource "azurerm_network_security_group" "allow_ssh" {
  name                = "allow_ssh"
  location            = var.region
  resource_group_name = azurerm_resource_group.vnet.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "Tcp"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "22"
    destination_address_prefix = "*"
  }
}

