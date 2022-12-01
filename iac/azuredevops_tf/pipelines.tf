## Application Pipeline

# scope group to env or each variable to env
# if groups are scoped, create and reference azure-pipeline-${environment}.yml
resource "azuredevops_variable_group" "pipeline" {
  project_id   = azuredevops_project.tf_project.id
  name         = "pipeline-variables"
  description  = "azure-pipelines.yml variables"
  allow_access = true

  variable {
    name  = "resource-group-name"
    value = var.resource_group_name
  }

  variable {
    name         = "subscriptionId"
    value =  "${data.azurerm_key_vault_secret.azurerm-subscription-id.value}"
  }
    variable {
    name         = "location"
    value =  var.resource_group_location
  }
}

# scope to env "ARMPipeline-${environment}"
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

  variable_groups = [
    azuredevops_variable_group.pipeline.id
  ]
  repository {
    repo_type             = "GitHub"
    repo_id               = var.vcs_repo_id
    branch_name           = var.vcs_repo_branch
    yml_path              = "app/azure-pipelines.yml"
    service_connection_id = azuredevops_serviceendpoint_github.default.id
  }
}

## Azure Devops Resources Pipeline

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
#    yml_path              = "iac/azure-pipelines.yml"
#    service_connection_id = azuredevops_serviceendpoint_github.default.id
#  }