App Service Environment V3: https://learn.microsoft.com/en-us/azure/app-service/environment/overview

https://learn.microsoft.com/en-us/azure/app-service/environment/create-from-template

?? Isolated App Service plans


TF - for Azure Devops project (ci/cd)
    Authentication to Azure Devops/Azure - Service Principal
    create personal access token
    terraform init
    terraform plan
    configure backend
        show local dev changes to not use backend
    create connection
    configure project settings  + workflow artifacts and target repository (repo is also defined in azure deploy params)
        reference azure-pipelines file

    TODO: Pipeline for terraform plan and scope git trigger to appropriate folder..
    TODO: Restructure entire project structure to ease scoping CI kickoffs
    TODO: Add terraform.tfvars to Key Vault and source from there.
ARM - for azure resources and azure deploys
    cli init
    Create azure deploy json
    commit azure-pipelines.yml - use pipeline name and service connections defined in tf.main.
    deploy from command line
    create storage account for tfstate

CREATE PRODUCTION DEPLOY via swap out (requires Azure subscription upgrade)

Builds will now happen on commit to watched repository
 - scope to application and tests vs. IaC code to ensure the right projects build on change.
    

