variable "azurerm_spn_tenantid" {
    type = string
    description = "Azure Tenant ID"
} 

variable "azurerm_subscription_id" {
    type = string
    description = "Azure Subscription ID"
}

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

variable github_personal_access_token {
    type = string
    sensitive = true
}