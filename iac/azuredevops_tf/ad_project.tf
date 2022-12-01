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
  azurerm_spn_tenantid      = "${data.azurerm_key_vault_secret.azurerm-spn-tenantid.value}"
  azurerm_subscription_id   = "${data.azurerm_key_vault_secret.azurerm-subscription-id.value}"
  azurerm_subscription_name = var.azurerm_subscription_name
}

resource "azuredevops_serviceendpoint_github" "default" {
  project_id            = azuredevops_project.tf_project.id
  service_endpoint_name = "GitHub Personal Access Token"

  auth_personal {
    # Also can be set with AZDO_GITHUB_SERVICE_CONNECTION_PAT environment variable
    personal_access_token = "${data.azurerm_key_vault_secret.github-personal-access-token.value}"
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