#!/usr/bin/env bash

# use this to initialize first development resource group.  Then add to terraform for dev, staging and production deployment 


az group create --name APExApp-rg-dev --location "eastus" --tags 'Enviroment=dev' 'iac=none'  && \
az deployment group create --resource-group APExApp-rg-dev --template-file ../azuredeploy.json --tags 'Enviroment=dev' 'iac=none'
# --template-uri https://github.com/aoffpo/ap-example/blob/main/iac/azuredeploy_arm/azuredeploy.json
#az lock create --name LockGroup --lock-type CanNotDelete --resource-group APExApp-rg-dev

