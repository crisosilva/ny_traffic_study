#Resource group creation

resource "azurerm_resource_group" "rg_ny_traffic_study" {
  location = var.location
  name     = "rg_ny_traffic_study"
}