terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "0.3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}
provider "azuread" {
  use_msi   = true
  tenant_id = var.azurerm_spn_tenantid
}
provider "azuredevops" {}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

data "azurerm_client_config" "current" {}

# dev: See scripts/create-deploy-rg-dev.sh
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = var.resource_group_name
  tags = {
    environment = var.environment
    iac         = "tf"
  }
}

resource "azurerm_resource_group_template_deployment" "default" {
  name                = "default-deploy"
  resource_group_name = azurerm_resource_group.rg.name
  deployment_mode     = "Incremental"
  template_content    = templatefile("../azuredeploy_arm/azuredeploy.json", {})
  parameters_content  = templatefile("../azuredeploy_arm/azuredeploy.parameters.${var.environment}.json", {})
  tags = {
    environment = var.environment
    iac         = "tf"
  }
}

resource "azurerm_resource_group" "common" {
  location = var.resource_group_location
  name     = "APAppEx-rg-common"
  tags = {
    environment = "shared"
    iac         = "tf"
  }
}

