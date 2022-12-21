# create our resource group for training objects
resource "azurerm_resource_group" "rg_ny_traffic_study" {
  name     = "ny_traffic_study"
  location = "East US 2"
}


# create storage account [blob storage] Data Lake Gen2
# account_kind = StorageV2 [Data lake gen2]
resource "azurerm_storage_account" "stg_ny_traffic_study" {
  name                     = "ny_traffic_study_stg"
  resource_group_name      = azurerm_resource_group.ny_traffic_study.name
  location                 = azurerm_resource_group.ny_traffic_study.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

# creating landing container - data coming from application [first contact]
resource "azurerm_storage_container" "landing" {
  name                  = "landing"
  storage_account_name  = azurerm_storage_account.stg_ny_traffic_study.name
  container_access_type = "private"
}