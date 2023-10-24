resource "azurerm_static_site" "static_site" {
  name                = "swa${local.suffix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_size            = "Standard"
  sku_tier            = "Standard"

  app_settings = {
    "AAD_CLIENT_ID"     = azuread_application_registration.example.client_id
    "AAD_CLIENT_SECRET" = azuread_application_password.application_password.value
  }
}
