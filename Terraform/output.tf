output "static_web_app_api_key" {
  value     = azurerm_static_site.static_site.api_key
  sensitive = true
}
