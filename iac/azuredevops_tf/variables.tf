variable "environment" {
    type = string
    description = "Target deployment environment name"
    validation {
        condition     = contains(["shared", "dev", "staging", "production"], var.environment)
        error_message = "Valid values for var: environment are (dev, staging, production)."
    } 
}

#variable "azurerm_spn_tenantid" {
#    type = string
#    description = "Azure Tenant ID"
#} 

#variable "azurerm_subscription_id" {
#    type = string
#    description = "Azure Subscription ID"
#}

variable "azurerm_subscription_name" {
    default = "Azure subscription 1"
    type = string
    description = "Name of Azure subscription"
} 

variable "vcs_repo_url" {
    type = string
    description = "Repo URL for remote source control"
}

variable "vcs_repo_id" {
    type = string
    description = "Repostory id in form {AccountName}/{RepoName}"
}

variable "vcs_repo_branch" {
    type = string
    description = "Branch for repository"
}


#variable github_personal_access_token {
#    type = string
#    sensitive = true
#}

variable "resource_group_location" {
  type = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type = string
  default     = "rg"
  description = "The resource group name.  Must be unique in subscription"
}