resource "azurerm_resource_group" "rg" {
  name     = "rg${local.suffix}"
  location = "West Europe"
}
