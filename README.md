App Service Environment V3: https://learn.microsoft.com/en-us/azure/app-service/environment/overview

https://learn.microsoft.com/en-us/azure/app-service/environment/create-from-template

TF - for Azure Devops project (ci/cd)
    Authentication to Azure Devops/Azure - Service Principal
    create personal access token in Azure
    terraform init
    terraform plan
    configure backend
        show local dev changes to not use backend
    create connection
    configure project settings  + workflow artifacts and target repository (repo is also defined in azure deploy params)
        reference azure-pipelines file

    TODO: Pipeline for terraform
    TODO: Add tfstate file to Key Vault and reference terraform backend.
ARM - for azure resources and azure deploys
    cli init 
    create resource group
    Create azure deploy json !! If this is done in terraform, create azuredeploy.json when creating deployment resource
    create deployment group
    commit azure-pipelines.yml - use pipeline name and service connections defined in tf.main.
    deploy from command line
    create storage account for tfstate

CREATE PRODUCTION DEPLOY via swap out (requires Azure subscription upgrade)

Builds happen on feature branches, on pr and on merge.
