#Resource group creation
resource "azurerm_resource_group" "rg_ny_traffic_study" {
  prefix = var.rg_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.rg_location
  name     = azurerm_resource_group.rg_ny_traffic_study.id
}