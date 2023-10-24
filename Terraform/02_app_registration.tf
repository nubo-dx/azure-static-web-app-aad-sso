resource "azuread_application_registration" "example" {
  display_name                       = "sp${local.suffix}"
  implicit_id_token_issuance_enabled = true
  sign_in_audience                   = "AzureADMyOrg"
}

resource "random_uuid" "example_administrator" {}

resource "azuread_application_app_role" "example_administer" {
  application_id       = azuread_application_registration.example.id
  role_id              = random_uuid.example_administrator.id
  allowed_member_types = ["User"]
  description          = "Users can access the app"
  display_name         = "User"
  value                = "User.Read"
}

resource "azuread_application_redirect_uris" "example_web" {
  application_id = azuread_application_registration.example.id
  type           = "Web"
  redirect_uris  = ["https://${azurerm_static_site.static_site.default_host_name}/.auth/login/aad/callback"]
}

data "azuread_application_published_app_ids" "well_known" {}

data "azuread_service_principal" "msgraph" {
  client_id = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]
}

resource "azuread_application_api_access" "example_msgraph" {
  application_id = azuread_application_registration.example.id
  api_client_id  = data.azuread_application_published_app_ids.well_known.result["MicrosoftGraph"]

  role_ids = [
    data.azuread_service_principal.msgraph.app_role_ids["GroupMember.Read.All"]
  ]

  scope_ids = [
    data.azuread_service_principal.msgraph.oauth2_permission_scope_ids["User.Read"]
  ]
}

resource "time_rotating" "rotation_time" {
  rotation_months = 6
}

resource "azuread_application_password" "application_password" {
  display_name   = "Application credentials"
  application_id = azuread_application_registration.example.id

  rotate_when_changed = {
    rotation = time_rotating.rotation_time.id
  }
}
