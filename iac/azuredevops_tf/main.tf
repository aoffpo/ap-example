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

resource "azuredevops_project" "tf_project" {
  name       = "tf-project"
  description = "Project deployed using Terraform"
  version_control = "git"
  visibility = "private"
  work_item_template = "Agile"
  features = {
    "boards" = "disabled"
    "repositories" = "disabled"
    "pipelines" = "enabled"
    "testplans" = "disabled"
    "artifacts" = "enabled"
  }
}

resource "azuredevops_serviceendpoint_azurerm" "tf_conn" {
  project_id                = azuredevops_project.tf_project.id
  service_endpoint_name     = "ArmPipeline-conn"
  azurerm_spn_tenantid      = var.azurerm_spn_tenantid
  azurerm_subscription_id   = var.azurerm_subscription_id
  azurerm_subscription_name = var.azurerm_subscription_name
}

resource "azuredevops_serviceendpoint_github" "default" {
  project_id            = azuredevops_project.tf_project.id
  service_endpoint_name = "GitHub Personal Access Token"

  auth_personal {
    # Also can be set with AZDO_GITHUB_SERVICE_CONNECTION_PAT environment variable
    personal_access_token = var.github_personal_access_token
  }
}

resource "azuredevops_build_definition" "arm_pipeline" {
  project_id = azuredevops_project.tf_project.id
  name       = "ARMPipeline"
  # description= "Pipeline for .NET 4.7 web application"
  path       = "\\app"

  ci_trigger {
    use_yaml = true
  }

  pull_request_trigger {
    use_yaml = true

    forks {
      enabled       = true
      share_secrets = false
    }
  }

  repository {
    repo_type             = "GitHub"
    repo_id               = var.vcs_repo_id
    branch_name           = "main"
    yml_path              = "app/azure-pipelines.yml"
    service_connection_id = azuredevops_serviceendpoint_github.default.id
  }
}
resource "azuredevops_resource_authorization" "github_service_conn" {
  project_id  = azuredevops_project.tf_project.id
  resource_id = azuredevops_serviceendpoint_github.default.id
  authorized  = true
}

resource "azuredevops_resource_authorization" "azurerm_service_conn" {
  project_id  = azuredevops_project.tf_project.id
  resource_id = azuredevops_serviceendpoint_azurerm.tf_conn.id
  authorized  = true
}

#resource "azuredevops_build_definition" "tf_pipeline" {
#  project_id = azuredevops_project.tf_project.id
#  name       = "TFPipeline"
#  description= "Pipeline for terraformed resources"
#  path       = "/iac"
# 
# ci_trigger {
#    use_yaml = true
#  }
#
#  pull_request_trigger {
#    use_yaml = true
#
#    forks {
#      enabled       = true
#      share_secrets = false
#    }
#  }
#
#  repository {
#    repo_type             = "GitHub"
#    repo_id               = var.vcs_repo_id
#    branch_name           = "main"
#    yml_path              = "terraform/azure-pipelines-tf.yml"
#    service_connection_id = azuredevops_serviceendpoint_github.default.id
#  }