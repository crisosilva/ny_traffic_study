variable "rg_location" {
  default     = "eastus"
  description = "Location of the resource group."
}

variable "rg_name_prefix" {
  default     = "rg"
  description = "Prefix ofthe resource group name that's combined with a random ID so name is unique in your Azure subscription."
}