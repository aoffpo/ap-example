terraform {
  required_providers {
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.3.0"
    }
  }
}
provider "azuread" {
  use_msi   = true
  tenant_id =var.azurerm_spn_tenantid
}
provider "azuredevops" {}
