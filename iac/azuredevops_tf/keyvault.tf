# resource group must be creted manually if keeping this resource in the same group as everything else
# this example uses and existing default group.  We can change it later.
# create manually, reference here.
# then imported before 'apply'ing any pre-existing refereneced resource.

locals {
  keyvaultname = "${var.environment}-keyvault-${split("-", data.azurerm_client_config.current.tenant_id)[0]}"
}

resource "azurerm_key_vault" "default" {
  name                        = local.keyvaultname
  location                    = var.resource_group_location
  resource_group_name         = "myResourceGroup"
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = false
  # public_network_access_enabled = false
  # network_acls              = {}

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Create",
      "Delete",
      "Get",
    ]

    secret_permissions = [
      "Set",
      "Delete",
      "Get",
    ]

    storage_permissions = [
      "Set",
      "Delete",
      "Get",
    ]
  }
  tags = {
    environment = "dev"
    iac         = "tf"
  }
}

data "azurerm_key_vault" "default" {
  name                = local.keyvaultname
  resource_group_name = "myResourceGroup"
}

data "azurerm_key_vault_secret" "azurerm-spn-tenantid" {
  name         = "azurerm-spn-tenantid"
  key_vault_id = data.azurerm_key_vault.default.id
}
output "azurerm_spn_tenantid" {
  value     = data.azurerm_key_vault_secret.azurerm-spn-tenantid.value
  sensitive = true
}

data "azurerm_key_vault_secret" "azurerm-subscription-id" {
  name         = "azurerm-subscription-id"
  key_vault_id = data.azurerm_key_vault.default.id
}
output "azurerm_subscription_id" {
  value     = data.azurerm_key_vault_secret.azurerm-subscription-id.value
  sensitive = true
}

data "azurerm_key_vault_secret" "github-personal-access-token" {
  name         = "github-personal-access-token"
  key_vault_id = data.azurerm_key_vault.default.id
}
output "github_personal_access_token" {
  value     = data.azurerm_key_vault_secret.github-personal-access-token.value
  sensitive = true
}

