<<<<<<< HEAD
=======
## Application Pipeline

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

## Azure Devops Resources Pipeline
>>>>>>> 5d868011f5a64ed0f4f158f0679605f27db1ee6f

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
<<<<<<< HEAD
#    yml_path              = "iac/azure-pipelines.yml"
=======
#    yml_path              = "terraform/azure-pipelines-tf.yml"
>>>>>>> 5d868011f5a64ed0f4f158f0679605f27db1ee6f
#    service_connection_id = azuredevops_serviceendpoint_github.default.id
#  }