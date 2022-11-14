App Service Environment V3: https://learn.microsoft.com/en-us/azure/app-service/environment/overview

https://learn.microsoft.com/en-us/azure/app-service/environment/create-from-template

?? Isolated App Service plans

ARM - for azure resources
    cli init
    Create azure deploy json
    deploy from command line
    create storage account for tfstate
TF - for Azure Devops project (ci/cd)
    commit azure-pipelines.yml
    create personal access token
    terraform init
    terraform plan
    configure backend
        show local dev changes to not use backend
    create connection
    configure project settings  + workflow artifacts and target repository (repo is also defined in azure deploy params)
        reference azure-pipelines file


CREATE PRODUCTION DEPLOY via swap out.


Builds will now happen on commit to watched repository
    

